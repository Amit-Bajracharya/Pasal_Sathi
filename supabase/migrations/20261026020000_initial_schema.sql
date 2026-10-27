-- Run this in the Supabase SQL editor (Dashboard > SQL Editor).
-- Replaces the earlier shops/products-only migrations with the full
-- schema: shops, suppliers, products, sales, stock movements, special
-- days, and the forecasting/reorder tables.
--
-- If you already ran the old 20261024000000_create_shops.sql /
-- 20261026000000_create_products.sql migrations against this project,
-- drop those tables first (this script has no IF NOT EXISTS guards):
--   drop table if exists public.products, public.shops cascade;

-- 1. Shops (one per owner: name + settings)
create table public.shops (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null unique default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  currency text not null default 'NPR',
  service_level numeric not null default 0.95 check (service_level between 0.5 and 0.999),
  review_days int not null default 7 check (review_days > 0),
  created_at timestamptz not null default now()
);

-- 2. Suppliers
create table public.suppliers (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  phone text,
  lead_time_days int not null default 2 check (lead_time_days >= 0),
  created_at timestamptz not null default now()
);

-- 3. Products
create table public.products (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null,
  category text,
  unit text not null default 'piece',
  cost_price numeric not null default 0 check (cost_price >= 0),
  selling_price numeric not null default 0 check (selling_price >= 0),
  current_stock numeric not null default 0,
  supplier_id uuid references public.suppliers(id) on delete set null,
  shelf_life_days int,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (owner_id, name)
);

-- 4. Sales
create table public.sales (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  sale_date date not null default current_date,
  quantity numeric not null check (quantity >= 0),
  unit_price numeric,
  created_at timestamptz not null default now()
);
create index sales_product_date_idx on public.sales (product_id, sale_date);

-- 5. Stock receipts
create table public.stock_receipts (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  received_date date not null default current_date,
  quantity numeric not null check (quantity > 0),
  cost_price numeric,
  expiry_date date,
  created_at timestamptz not null default now()
);

-- 6. Stock adjustments
create table public.stock_adjustments (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  adjust_date date not null default current_date,
  quantity_change numeric not null,
  reason text not null check (reason in ('damaged','expired','count_correction','other')),
  created_at timestamptz not null default now()
);

-- 7. Special days
create table public.special_days (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  day date not null,
  name text not null,
  kind text not null check (kind in ('festival','promotion','closed')),
  unique (owner_id, day, kind)
);

-- 8. Forecasts
create table public.forecasts (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  forecast_date date not null,
  predicted_qty numeric not null check (predicted_qty >= 0),
  model_name text not null check (model_name in ('decision_tree','linear_regression','moving_average','blend')),
  created_at timestamptz not null default now(),
  unique (product_id, forecast_date, model_name)
);

-- 9. Model evaluations
create table public.model_evaluations (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  model_name text not null,
  mae numeric, rmse numeric, mape numeric,
  train_days int, test_days int,
  is_selected boolean not null default false,
  model_json jsonb,
  created_at timestamptz not null default now()
);

-- 10. Reorder advice
create table public.reorder_advice (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  product_id uuid not null references public.products(id) on delete cascade,
  avg_daily_demand numeric not null,
  safety_stock numeric not null,
  reorder_point numeric not null,
  suggested_qty numeric not null,
  status text not null default 'new' check (status in ('new','seen','ordered','dismissed')),
  created_at timestamptz not null default now()
);

-- Daily sales with zero-sale days filled in
create view public.daily_sales with (security_invoker = true) as
select p.id as product_id, d.day::date as sale_date,
       coalesce(sum(s.quantity), 0) as quantity
from public.products p
cross join lateral generate_series(
  (select coalesce(min(sale_date), current_date) from public.sales where product_id = p.id),
  current_date, interval '1 day') as d(day)
left join public.sales s on s.product_id = p.id and s.sale_date = d.day::date
group by p.id, d.day;

-- Keep current_stock in sync
create function public.apply_stock_change() returns trigger language plpgsql as $$
begin
  if tg_table_name = 'sales' then
    update public.products set current_stock = current_stock - new.quantity where id = new.product_id;
  elsif tg_table_name = 'stock_receipts' then
    update public.products set current_stock = current_stock + new.quantity where id = new.product_id;
  else
    update public.products set current_stock = current_stock + new.quantity_change where id = new.product_id;
  end if;
  return new;
end $$;

create trigger trg_sales after insert on public.sales
  for each row execute function public.apply_stock_change();
create trigger trg_receipts after insert on public.stock_receipts
  for each row execute function public.apply_stock_change();
create trigger trg_adjust after insert on public.stock_adjustments
  for each row execute function public.apply_stock_change();

-- Row Level Security: every owner sees only their own rows
do $$
declare t text;
begin
  foreach t in array array['shops','suppliers','products','sales','stock_receipts',
    'stock_adjustments','special_days','forecasts','model_evaluations','reorder_advice']
  loop
    execute format('alter table public.%I enable row level security', t);
    execute format('create policy own_rows on public.%I for all using (owner_id = auth.uid()) with check (owner_id = auth.uid())', t);
  end loop;
end $$;

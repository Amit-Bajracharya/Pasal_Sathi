-- Run this in the Supabase SQL editor (Dashboard > SQL Editor).
-- One shop per owner for now; drop the unique constraint later if an
-- account should be able to own multiple shops.

create table if not exists public.shops (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null unique references auth.users (id) on delete cascade,
  name text not null,
  created_at timestamptz not null default now()
);

alter table public.shops enable row level security;

create policy "Owners can view own shop"
  on public.shops for select
  using (owner_id = auth.uid());

create policy "Owners can insert own shop"
  on public.shops for insert
  with check (owner_id = auth.uid());

create policy "Owners can update own shop"
  on public.shops for update
  using (owner_id = auth.uid());

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/routes/app_router.gr.dart';
import 'package:pasal_sathi/src/modules/products/model/product.dart';
import 'package:pasal_sathi/src/modules/products/view/widgets/inventory_status_strip.dart';
import 'package:pasal_sathi/src/modules/products/view/widgets/product_card.dart';
import 'package:pasal_sathi/src/modules/products/view/widgets/product_filter_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appTextField/app_text_field.dart';
import 'package:pasal_sathi/src/modules/shop/data/repository/shop_repository.dart';

/// Products & Inventory tab: search, category/stock filters, a quick
/// inventory-health summary, and the product list itself.
class ProductsView extends ConsumerStatefulWidget {
  const ProductsView({super.key});

  @override
  ConsumerState<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState<ProductsView> {
  final _searchController = TextEditingController();
  int _selectedFilter = 0;

  static const _filters = [
    ('All (142)', null),
    ('Low Stock (6)', true),
    ('Grains & Rice (28)', false),
    ('Oils & Ghee (14)', false),
    ('Snacks & Noodles (35)', false),
    ('Dairy (12)', false),
    ('Spices (22)', false),
  ];

  static const _products = [
    Product(
      name: 'Wai Wai Quick Noodles 75g',
      category: 'Snacks',
      unitLabel: 'Packet',
      tagLabel: 'Barcode: 890123',
      sellingPrice: 25,
      costPrice: 20,
      stockLabel: '80 packets in stock',
      status: ProductStockStatus.normal,
    ),
    Product(
      name: 'DDC Fresh Milk 500ml',
      category: 'Dairy',
      unitLabel: 'Pouch',
      tagLabel: 'Only 4 pouches left!',
      sellingPrice: 50,
      costPrice: 45,
      stockLabel: 'Only 4 pouches left!',
      status: ProductStockStatus.lowStock,
    ),
    Product(
      name: 'Basmati Special Rice 5kg',
      category: 'Grains',
      unitLabel: 'Bag',
      tagLabel: 'Fast Mover',
      sellingPrice: 720,
      costPrice: 640,
      stockLabel: '32 bags in stock',
      status: ProductStockStatus.normal,
    ),
    Product(
      name: 'Fortune Sunflower Oil 1L',
      category: 'Oil',
      unitLabel: 'Pouch',
      tagLabel: 'Pouch 1L',
      sellingPrice: 265,
      costPrice: 240,
      stockLabel: '19 pouches in stock',
      status: ProductStockStatus.normal,
    ),
    Product(
      name: 'Everest Garam Masala 100g',
      category: 'Spices',
      unitLabel: 'Box',
      tagLabel: 'Out of Stock',
      sellingPrice: 115,
      costPrice: 95,
      stockLabel: '0 units available',
      status: ProductStockStatus.outOfStock,
    ),
    Product(
      name: 'Aashirvaad Shudh Chakki Atta 10kg',
      category: 'Flour',
      unitLabel: 'Bag',
      tagLabel: 'Heavy Stock',
      sellingPrice: 840,
      costPrice: 750,
      stockLabel: '14 bags in stock',
      status: ProductStockStatus.normal,
    ),
    Product(
      name: 'Aayo Nun / Salt 1kg',
      category: 'Grocery',
      unitLabel: 'Packet',
      tagLabel: 'Essential',
      sellingPrice: 26,
      costPrice: 22,
      stockLabel: '112 packets in stock',
      status: ProductStockStatus.normal,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final shopName = ref.watch(currentShopNameProvider).value ?? 'My Shop';

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.p16,
        AppDimens.p16,
        AppDimens.p16,
        AppDimens.p32,
      ),
      children: [
        _Header(shopName: shopName, productCount: _products.length),
        AppSpacing.h20,
        AppTextField(
          textEditingController: _searchController,
          labelText: 'Search products',
          showLabel: false,
          hintText: 'Search by product name, barcode, or brand...',
          borderRadius: AppRadius.lg,
          isDense: true,
          bottomPadding: 0,
          prefixIcon: Icon(Icons.search_rounded, color: colorScheme.outline),
          suffixIcon: IconButton(
            icon: Icon(Icons.mic_rounded, color: colorScheme.outline),
            onPressed: () {},
          ),
        ),
        AppSpacing.h12,
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _filters.length,
            separatorBuilder: (_, _) => AppSpacing.w8,
            itemBuilder: (context, index) {
              final (label, isLowStock) = _filters[index];
              return ProductFilterChip(
                label: label,
                selected: _selectedFilter == index,
                dotColor: isLowStock == true ? colorScheme.tertiary : null,
                onTap: () => setState(() => _selectedFilter = index),
              );
            },
          ),
        ),
        AppSpacing.h16,
        const InventoryStatusStrip(
          totalValueLabel: 'NPR 3.45L',
          totalValueTrendLabel: '+4.2% mo',
          inStockLabel: '136 Items',
          inStockCaption: '95% Healthy',
          restockLabel: '6 Items',
        ),
        AppSpacing.h20,
        Row(
          children: [
            AppText(
              'SORTED BY POPULARITY',
              style: AppTextStyles.label,
              color: colorScheme.outline,
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  AppSpacing.w4,
                  AppText(
                    'Filter & Sort',
                    style: AppTextStyles.label,
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ],
        ),
        AppSpacing.h12,
        for (final product in _products) ...[
          ProductCard(
            product: product,
            onEdit: () {},
            onAddStock: () {},
            onMore: () {},
          ),
          AppSpacing.h12,
        ],
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.shopName, required this.productCount});

  final String shopName;
  final int productCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: colorScheme.primary.useOpacity(0.1),
            borderRadius: AppRadius.normal,
          ),
          child: Icon(Icons.storefront_rounded, color: colorScheme.primary),
        ),
        AppSpacing.w12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                shopName,
                style: AppTextStyles.label,
                color: colorScheme.onSurfaceVariant,
                overflow: TextOverflow.ellipsis,
              ),
              AppSpacing.h2,
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AppText(
                    'Products ',
                    style: AppTextStyles.headline,
                    color: colorScheme.onSurface,
                  ),
                  AppText(
                    '($productCount items)',
                    style: AppTextStyles.bodySmall,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.qr_code_scanner_rounded,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Material(
          color: colorScheme.primaryContainer,
          borderRadius: AppRadius.pill,
          child: InkWell(
            borderRadius: AppRadius.pill,
            onTap: () => context.pushRoute(const AddProductRoute()),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimens.p14,
                vertical: AppDimens.p10,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add_rounded,
                    size: 18,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  AppSpacing.w4,
                  AppText(
                    'Add Product',
                    style: AppTextStyles.label,
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

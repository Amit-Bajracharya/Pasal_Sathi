import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/routes/app_router.gr.dart';
import 'package:pasal_sathi/src/modules/products/data/repository/product_repository.dart';
import 'package:pasal_sathi/src/modules/products/model/product_model.dart';
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
  _ProductSort _sort = _ProductSort.newest;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() => setState(() {});

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _addProduct() async {
    await context.pushRoute(const AddProductRoute());
    ref.invalidate(ownedProductsProvider);
  }

  Future<void> _showSortSheet() async {
    final selected = await showModalBottomSheet<_ProductSort>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: RadioGroup<_ProductSort>(
          groupValue: _sort,
          onChanged: (v) => Navigator.of(sheetContext).pop(v),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final sort in _ProductSort.values)
                RadioListTile<_ProductSort>(
                  title: AppText(sort.label),
                  value: sort,
                ),
            ],
          ),
        ),
      ),
    );
    if (selected != null) setState(() => _sort = selected);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final shopName = ref.watch(currentShopNameProvider).value ?? 'My Shop';
    final productsAsync = ref.watch(ownedProductsProvider);
    final products = productsAsync.value ?? const <Product>[];
    final lowStockCount = products
        .where((p) => p.status == ProductStockStatus.lowStock)
        .length;
    final needsRestockCount = products
        .where((p) => p.status != ProductStockStatus.normal)
        .length;
    final inStockCount = products.where((p) => p.stockQuantity > 0).length;
    final healthyPercent = products.isEmpty
        ? 0
        : (inStockCount / products.length * 100).round();
    final totalStockValue = products.fold<double>(
      0,
      (sum, p) => sum + p.sellingPrice * p.stockQuantity,
    );

    final categories = {for (final p in products) p.category}.toList()..sort();
    final filters = [
      ('All (${products.length})', null, false),
      ('Low Stock ($lowStockCount)', null, true),
      for (final c in categories)
        ('$c (${products.where((p) => p.category == c).length})', c, false),
    ];
    final safeFilterIndex = _selectedFilter.clamp(0, filters.length - 1);

    final query = _searchController.text.trim().toLowerCase();
    var visibleProducts = products.where((p) {
      if (query.isNotEmpty &&
          !p.name.toLowerCase().contains(query) &&
          !p.category.toLowerCase().contains(query)) {
        return false;
      }
      if (safeFilterIndex == 1) {
        return p.status == ProductStockStatus.lowStock;
      }
      if (safeFilterIndex >= 2) {
        return p.category == filters[safeFilterIndex].$2;
      }
      return true;
    }).toList();
    visibleProducts = _sortProducts(visibleProducts, _sort);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.p16,
        AppDimens.p16,
        AppDimens.p16,
        AppDimens.p32,
      ),
      children: [
        _Header(
          shopName: shopName,
          productCount: products.length,
          onAddProductTap: _addProduct,
        ),
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
            itemCount: filters.length,
            separatorBuilder: (_, _) => AppSpacing.w8,
            itemBuilder: (context, index) {
              final (label, _, isLowStock) = filters[index];
              return ProductFilterChip(
                label: label,
                selected: safeFilterIndex == index,
                dotColor: isLowStock ? colorScheme.tertiary : null,
                onTap: () => setState(() => _selectedFilter = index),
              );
            },
          ),
        ),
        AppSpacing.h16,
        InventoryStatusStrip(
          totalValueLabel: 'NPR ${totalStockValue.toStringAsFixed(0)}',
          totalValueTrendLabel: '${products.length} products',
          inStockLabel: '$inStockCount Items',
          inStockCaption: '$healthyPercent% Healthy',
          restockLabel: '$needsRestockCount Items',
        ),
        AppSpacing.h20,
        Row(
          children: [
            AppText(
              'SORTED BY ${_sort.label.toUpperCase()}',
              style: AppTextStyles.label,
              color: colorScheme.outline,
            ),
            const Spacer(),
            InkWell(
              onTap: _showSortSheet,
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
        if (productsAsync.isLoading && products.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.p32),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (productsAsync.hasError)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p24),
            child: Column(
              children: [
                AppText(
                  'Couldn\'t load products.',
                  style: AppTextStyles.body,
                  color: colorScheme.error,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.h8,
                TextButton(
                  onPressed: () => ref.invalidate(ownedProductsProvider),
                  child: const AppText('Retry'),
                ),
              ],
            ),
          )
        else if (products.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p32),
            child: AppText(
              'No products yet. Tap "Add Product" to get started.',
              style: AppTextStyles.body,
              color: colorScheme.outline,
              textAlign: TextAlign.center,
            ),
          )
        else if (visibleProducts.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p32),
            child: AppText(
              'No products match your search or filter.',
              style: AppTextStyles.body,
              color: colorScheme.outline,
              textAlign: TextAlign.center,
            ),
          )
        else
          for (final product in visibleProducts) ...[
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
  const _Header({
    required this.shopName,
    required this.productCount,
    required this.onAddProductTap,
  });

  final String shopName;
  final int productCount;
  final VoidCallback onAddProductTap;

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
                    style: AppTextStyles.bodySmall,
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

        Material(
          color: colorScheme.primaryContainer,
          borderRadius: AppRadius.pill,
          child: InkWell(
            borderRadius: AppRadius.pill,
            onTap: onAddProductTap,
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

enum _ProductSort {
  newest('Newest'),
  nameAsc('Name (A-Z)'),
  priceHighToLow('Price: High to Low'),
  priceLowToHigh('Price: Low to High'),
  stockLowToHigh('Stock: Low to High');

  const _ProductSort(this.label);

  final String label;
}

List<Product> _sortProducts(List<Product> items, _ProductSort sort) {
  final sorted = [...items];
  switch (sort) {
    case _ProductSort.newest:
      break;
    case _ProductSort.nameAsc:
      sorted.sort(
        (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
      );
    case _ProductSort.priceHighToLow:
      sorted.sort((a, b) => b.sellingPrice.compareTo(a.sellingPrice));
    case _ProductSort.priceLowToHigh:
      sorted.sort((a, b) => a.sellingPrice.compareTo(b.sellingPrice));
    case _ProductSort.stockLowToHigh:
      sorted.sort((a, b) => a.stockQuantity.compareTo(b.stockQuantity));
  }
  return sorted;
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/config/colors/app_colors.dart';
import 'package:pasal_sathi/src/core/routes/app_router.gr.dart';
import 'package:pasal_sathi/src/modules/auth/data/repository/auth_repository.dart';
import 'package:pasal_sathi/src/modules/home/page/utils/bottomNav/home_bottom_nav_bar.dart';
import 'package:pasal_sathi/src/modules/home/page/utils/overviewCards/overview_stat_card.dart';
import 'package:pasal_sathi/src/modules/products/data/repository/product_repository.dart';
import 'package:pasal_sathi/src/modules/products/model/product_model.dart';
import 'package:pasal_sathi/src/modules/products/view/products_view.dart';
import 'package:pasal_sathi/src/modules/sales/data/repository/sale_repository.dart';
import 'package:pasal_sathi/src/modules/sales/model/sale_model.dart';
import 'package:pasal_sathi/src/modules/sales/view/sales_view.dart';
import 'package:pasal_sathi/src/modules/sales/view/widgets/sale_tile.dart';
import 'package:pasal_sathi/src/modules/home/page/utils/quickActions/quick_actions_row.dart';
import 'package:pasal_sathi/src/modules/home/page/utils/restock/restock_item_card.dart';
import 'package:pasal_sathi/src/modules/home/page/utils/salesSummary/sales_summary_card.dart';
import 'package:pasal_sathi/src/modules/home/page/utils/shopHeader/shop_header.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appCard/app_surface_card.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appChip/app_pill_chip.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appScaffold/app_scaffold_widget.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appSectionHeader/app_section_header.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/comingSoon/coming_soon_view.dart';
import 'package:pasal_sathi/src/modules/shop/data/repository/shop_repository.dart';

@RoutePage()
class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int _navIndex = 0;

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You will need to log in again to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    await ref.read(authRepositoryProvider).signOut();
    if (!mounted) return;
    context.replaceRoute(const AuthRoute());
  }

  @override
  Widget build(BuildContext context) {
    final ownerName =
        ref.watch(authRepositoryProvider).currentUserName ?? 'Owner';
    final shopName = ref.watch(currentShopNameProvider).value ?? 'My Shop';
    final products =
        ref.watch(ownedProductsProvider).value ?? const <Product>[];
    final sales = ref.watch(ownedSalesProvider).value ?? const <Sale>[];
    final needsRestockCount = products
        .where((p) => p.status != ProductStockStatus.normal)
        .length;

    return AppScaffoldWidget(
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
      ),
      body: Container(
        color: context.colorScheme.surface,
        child: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _navIndex,
            children: [
              _buildDashboard(
                ownerName: ownerName,
                shopName: shopName,
                products: products,
                sales: sales,
                needsRestockCount: needsRestockCount,
              ),
              const ProductsView(),
              const SalesView(),
              const ComingSoonView(
                title: 'Analysis',
                icon: Icons.bar_chart_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboard({
    required String ownerName,
    required String shopName,
    required List<Product> products,
    required List<Sale> sales,
    required int needsRestockCount,
  }) {
    final now = DateTime.now();
    final today = sales.where((s) => _isSameDay(s.saleDate, now)).toList();
    final yesterday = sales
        .where(
          (s) => _isSameDay(s.saleDate, now.subtract(const Duration(days: 1))),
        )
        .toList();

    final todayTotal = today.fold<double>(0, (sum, s) => sum + s.total);
    final yesterdayTotal = yesterday.fold<double>(0, (sum, s) => sum + s.total);
    final trendLabel = yesterdayTotal == 0
        ? (todayTotal == 0 ? 'No sales yet today' : 'First sales today')
        : '${todayTotal >= yesterdayTotal ? '+' : ''}${(((todayTotal - yesterdayTotal) / yesterdayTotal) * 100).toStringAsFixed(0)}% vs yesterday';
    final avgPerSale = today.isEmpty ? 0.0 : todayTotal / today.length;

    final stockValue = products.fold<double>(
      0,
      (sum, p) => sum + p.sellingPrice * p.stockQuantity,
    );

    final restockItems = [...products]
      ..removeWhere((p) => p.status == ProductStockStatus.normal)
      ..sort((a, b) => a.stockQuantity.compareTo(b.stockQuantity));
    final topRestockItems = restockItems.take(3).toList();

    final recentSales = sales.take(3).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.p16,
        AppDimens.p16,
        AppDimens.p16,
        AppDimens.p32,
      ),
      children: [
        ShopHeader(
          shopName: shopName,
          ownerName: ownerName,
          isOpen: true,
          hasNotification: needsRestockCount > 0,
          onLogoutTap: _logout,
        ),
        AppSpacing.h20,
        QuickActionsRow(
          onNewSale: () {
            context.pushRoute(const AddSaleRoute());
          },
          onNewProduct: () {
            context.pushRoute(const AddProductRoute());
          },
        ),
        AppSpacing.h24,
        Row(
          children: [
            AppText(
              "Today's Summary",
              style: AppTextStyles.title,
              color: AppColor.homeOnSurface,
            ),
            Spacer(),
            AppPillChip(
              label: _todayLabel(now),
              backgroundColor: AppColor.homeSurfaceContainer,
              foregroundColor: AppColor.homeOnSurfaceMuted,
            ),
      
           
          ],
        ),
        AppSpacing.h12,
        SalesSummaryCard(
          totalLabel: 'Total Counter Sales',
          amount: todayTotal.toStringAsFixed(0),
          currencyLabel: 'NPR',
          trendLabel: trendLabel,
          billsSettledLabel: '${today.length} sales today',
          targetLabel: today.isEmpty
              ? 'No sales yet'
              : 'Avg: NPR ${avgPerSale.toStringAsFixed(0)}/sale',
        ),
        AppSpacing.h16,
        Row(
          children: [
            Expanded(
              child: OverviewStatCard(
                label: 'Stock Value',
                value: 'NPR ${stockValue.toStringAsFixed(0)}',
                caption: '${products.length} products',
                icon: Icons.inventory_2_rounded,
                accentColor: AppColor.homePrimary,
                accentContainerColor: AppColor.homeSuccessContainer,
              ),
            ),
            AppSpacing.w12,
            Expanded(
              child: OverviewStatCard(
                label: 'Low Stock Alert',
                value: '$needsRestockCount Items',
                caption: needsRestockCount > 0
                    ? 'Immediate reorder'
                    : 'All stocked up',
                icon: Icons.warning_rounded,
                accentColor: AppColor.homeDanger,
                accentContainerColor: AppColor.homeDangerContainer,
                valueColor: AppColor.homeDanger,
              ),
            ),
          ],
        ),
        AppSpacing.h24,
        AppSectionHeader(
          title: 'Urgent Restock Needed',
          titleStyle: AppTextStyles.title,
          titleColor: AppColor.homeOnSurface,
          dotColor: AppColor.homeDanger,
          trailing: AppPillChip(
            label: '$needsRestockCount to review',
            backgroundColor: AppColor.homeDangerContainer,
            foregroundColor: AppColor.homeOnDangerContainer,
          ),
        ),
        AppSpacing.h12,
        if (topRestockItems.isEmpty)
          AppText(
            'All stocked up! No items need restocking.',
            style: AppTextStyles.body,
            color: AppColor.homeOnSurfaceMuted,
          )
        else
          for (final product in topRestockItems) ...[
            RestockItemCard(
              item: _restockItemFor(product),
              onReorder: () => context.pushRoute(const AddProductRoute()),
            ),
            AppSpacing.h12,
          ],
        AppSpacing.h12,
        AppSectionHeader(
          title: 'Recent Sales',
          titleStyle: AppTextStyles.title,
          titleColor: AppColor.homeOnSurface,
          trailing: InkWell(
            onTap: () => setState(() => _navIndex = 2),
            child: AppText(
              'View All',
              style: AppTextStyles.title,
              color: AppColor.homePrimary,
            ),
          ),
        ),
        AppSpacing.h12,
        if (recentSales.isEmpty)
          AppSurfaceCard(
            child: AppText(
              'No sales yet. Record your first sale to see it here.',
              style: AppTextStyles.body,
              color: AppColor.homeOnSurfaceMuted,
            ),
          )
        else
          for (var i = 0; i < recentSales.length; i++) ...[
            SaleTile(sale: recentSales[i], displayNumber: sales.length - i),
            AppSpacing.h12,
          ],
      ],
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  RestockItem _restockItemFor(Product product) {
    final isOut = product.status == ProductStockStatus.outOfStock;
    return RestockItem(
      name: product.name,
      quantityLabel: isOut
          ? 'Out of stock'
          : '${product.stockQuantity} ${_pluralUnit(product.unitLabel, product.stockQuantity)}',
      caption:
          '${product.category} • Reorder below ${Product.lowStockThreshold} ${_pluralUnit(product.unitLabel, Product.lowStockThreshold)}',
      isUrgent: isOut,
    );
  }

  String _pluralUnit(String unitLabel, int quantity) {
    if (quantity == 1) return unitLabel;
    return unitLabel == 'piece' ? 'pieces' : '${unitLabel}s';
  }

  String _todayLabel(DateTime now) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Today, ${now.day} ${months[now.month - 1]}';
  }
}

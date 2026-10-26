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
import 'package:pasal_sathi/src/modules/home/page/utils/checkouts/checkout_tile.dart';
import 'package:pasal_sathi/src/modules/home/page/utils/overviewCards/overview_stat_card.dart';
import 'package:pasal_sathi/src/modules/products/view/products_view.dart';
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

  static const _restockItems = [
    RestockItem(
      name: 'Wai Wai Quick Noodles',
      quantityLabel: '4 left',
      caption: 'Daily avg: 15 pkts • Runout today',
      isUrgent: true,
    ),
    RestockItem(
      name: 'Fortune Sunflower Oil 1L',
      quantityLabel: '2 bottles',
      caption: 'Dealer: Shrestha Traders (Kalanki)',
    ),
    RestockItem(
      name: 'Taichin Rice 25kg',
      quantityLabel: '1 sack',
      caption: 'Threshold: 3 sacks required',
    ),
  ];

  static const _checkouts = [
    CheckoutRecord(
      billNumber: '1042',
      method: PaymentMethod.fonepay,
      customerLabel: 'Sita Sharma • 4 items',
      amountLabel: 'Rs. 1,280',
      timeAgoLabel: '3m ago',
    ),
    CheckoutRecord(
      billNumber: '1041',
      method: PaymentMethod.cash,
      customerLabel: 'Walk-in Customer • 1 item',
      amountLabel: 'Rs. 450',
      timeAgoLabel: '12m ago',
    ),
    CheckoutRecord(
      billNumber: '1040',
      method: PaymentMethod.khata,
      customerLabel: 'Bikash Dai (Neighbor) • 2 items',
      amountLabel: 'Rs. 320',
      timeAgoLabel: '28m ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ownerName =
        ref.watch(authRepositoryProvider).currentUserName ?? 'Owner';
    final shopName = ref.watch(currentShopNameProvider).value ?? 'My Shop';

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
              _buildDashboard(ownerName: ownerName, shopName: shopName),
              const ProductsView(),
              const ComingSoonView(
                title: 'Sales',
                icon: Icons.receipt_long_outlined,
              ),
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
  }) {
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
          hasNotification: true,
          onLogoutTap: _logout,
        ),
        AppSpacing.h20,
        QuickActionsRow(
          onNewSale: () {},
          onScan: () {},
          onKhata: () {},
          onMore: () {},
        ),
        AppSpacing.h24,
        Row(
          children: [
            AppText(
              "Today's Summary",
              style: AppTextStyles.title,
              color: AppColor.homeOnSurface,
            ),
            AppSpacing.w8,
            const AppPillChip(
              label: 'Baisakh 14',
              backgroundColor: AppColor.homeSurfaceContainer,
              foregroundColor: AppColor.homeOnSurfaceMuted,
            ),
            const Spacer(),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    'View Analytics',
                    style: AppTextStyles.bodySmall,
                    color: AppColor.homePrimary,
                  ),
                  AppSpacing.w4,
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 16,
                    color: AppColor.homePrimary,
                  ),
                ],
              ),
            ),
          ],
        ),
        AppSpacing.h12,
        const SalesSummaryCard(
          totalLabel: 'Total Counter Sales',
          amount: 'Rs. 18,450',
          currencyLabel: 'NPR',
          trendLabel: "+12.4% vs y'day",
          billsSettledLabel: '42 Bills settled',
          targetLabel: 'Target: 82% reached',
        ),
        AppSpacing.h16,
        Row(
          children: [
            Expanded(
              child: OverviewStatCard(
                label: 'Khata Due',
                value: 'Rs. 4,200',
                caption: '3 customers pending',
                icon: Icons.menu_book_rounded,
                accentColor: AppColor.homeWarning,
                accentContainerColor: AppColor.homeWarningContainer,
              ),
            ),
            AppSpacing.w12,
            Expanded(
              child: OverviewStatCard(
                label: 'Low Stock Alert',
                value: '5 Items',
                caption: 'Immediate reorder',
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
          trailing: const AppPillChip(
            label: 'Fast Depletion',
            backgroundColor: AppColor.homeDangerContainer,
            foregroundColor: AppColor.homeOnDangerContainer,
          ),
        ),
        AppSpacing.h12,
        for (final item in _restockItems) ...[
          RestockItemCard(item: item, onReorder: () {}),
          AppSpacing.h12,
        ],
        AppSpacing.h12,
        AppSectionHeader(
          title: 'Recent Checkouts',
          titleStyle: AppTextStyles.title,
          titleColor: AppColor.homeOnSurface,
          trailing: InkWell(
            onTap: () {},
            child: AppText(
              'All Bills',
              style: AppTextStyles.title,
              color: AppColor.homePrimary,
            ),
          ),
        ),
        AppSpacing.h12,
        AppSurfaceCard(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.p12),
          child: Column(
            children: [
              for (var i = 0; i < _checkouts.length; i++) ...[
                CheckoutTile(record: _checkouts[i]),
                if (i != _checkouts.length - 1)
                  const Divider(height: 1, color: AppColor.homeOutline),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/core/routes/app_router.gr.dart';
import 'package:pasal_sathi/src/modules/products/data/repository/product_repository.dart';
import 'package:pasal_sathi/src/modules/sales/data/repository/sale_repository.dart';
import 'package:pasal_sathi/src/modules/sales/model/sale_model.dart';
import 'package:pasal_sathi/src/modules/sales/view/widgets/sale_tile.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';
import 'package:pasal_sathi/src/modules/shop/data/repository/shop_repository.dart';

/// Sales tab: today's totals, a quick All/Today filter, and the recent
/// sales feed itself.
class SalesView extends ConsumerStatefulWidget {
  const SalesView({super.key});

  @override
  ConsumerState<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends ConsumerState<SalesView> {
  bool _todayOnly = false;

  Future<void> _newSale() async {
    await context.pushRoute(const AddSaleRoute());
    ref.invalidate(ownedSalesProvider);
    ref.invalidate(ownedProductsProvider);
  }

  Future<void> _showDetails(Sale sale) {
    return showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: AppText(sale.productName, style: AppTextStyles.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow(
              label: 'Quantity',
              value: '${sale.quantity} ${sale.unitLabel}',
            ),
            _DetailRow(
              label: 'Unit price',
              value: 'NPR ${sale.unitPrice.toStringAsFixed(0)}',
            ),
            _DetailRow(
              label: 'Total',
              value: 'NPR ${sale.total.toStringAsFixed(0)}',
            ),
            _DetailRow(
              label: 'Sale date',
              value:
                  '${sale.saleDate.year}-${sale.saleDate.month.toString().padLeft(2, '0')}-${sale.saleDate.day.toString().padLeft(2, '0')}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final shopName = ref.watch(currentShopNameProvider).value ?? 'My Shop';
    final salesAsync = ref.watch(ownedSalesProvider);
    final sales = salesAsync.value ?? const <Sale>[];

    final now = DateTime.now();
    bool isSameDay(DateTime a, DateTime b) =>
        a.year == b.year && a.month == b.month && a.day == b.day;

    final todaySales = sales.where((s) => isSameDay(s.saleDate, now)).toList();
    final yesterday = now.subtract(const Duration(days: 1));
    final yesterdaySales = sales
        .where((s) => isSameDay(s.saleDate, yesterday))
        .toList();

    final todayTotal = todaySales.fold<double>(0, (sum, s) => sum + s.total);
    final yesterdayTotal = yesterdaySales.fold<double>(
      0,
      (sum, s) => sum + s.total,
    );
    final trendLabel = yesterdayTotal == 0
        ? null
        : (((todayTotal - yesterdayTotal) / yesterdayTotal) * 100);

    final visibleSales = _todayOnly ? todaySales : sales;

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
          transactionCount: sales.length,
          onNewSaleTap: _newSale,
        ),
        AppSpacing.h20,
        _SummaryCard(
          totalLabel: 'NPR ${todayTotal.toStringAsFixed(0)}',
          trendPercent: trendLabel,
          orderCount: todaySales.length,
        ),
        AppSpacing.h16,
        Row(
          children: [
            _FilterChip(
              label: 'All (${sales.length})',
              selected: !_todayOnly,
              onTap: () => setState(() => _todayOnly = false),
            ),
            AppSpacing.w8,
            _FilterChip(
              label: 'Today (${todaySales.length})',
              selected: _todayOnly,
              onTap: () => setState(() => _todayOnly = true),
            ),
          ],
        ),
        AppSpacing.h20,
        Row(
          children: [
            AppText(
              'RECENT SALES',
              style: AppTextStyles.label,
              color: colorScheme.outline,
            ),
            const Spacer(),
            AppText(
              'Sorted by time',
              style: AppTextStyles.label,
              color: colorScheme.outline,
            ),
          ],
        ),
        AppSpacing.h12,
        if (salesAsync.isLoading && sales.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppDimens.p32),
            child: Center(child: CircularProgressIndicator()),
          )
        else if (salesAsync.hasError)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p24),
            child: Column(
              children: [
                AppText(
                  "Couldn't load sales.",
                  style: AppTextStyles.body,
                  color: colorScheme.error,
                  textAlign: TextAlign.center,
                ),
                AppSpacing.h8,
                TextButton(
                  onPressed: () => ref.invalidate(ownedSalesProvider),
                  child: const AppText('Retry'),
                ),
              ],
            ),
          )
        else if (sales.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p32),
            child: AppText(
              'No sales yet. Tap "New Sale" to record one.',
              style: AppTextStyles.body,
              color: colorScheme.outline,
              textAlign: TextAlign.center,
            ),
          )
        else if (visibleSales.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p32),
            child: AppText(
              'No sales recorded today yet.',
              style: AppTextStyles.body,
              color: colorScheme.outline,
              textAlign: TextAlign.center,
            ),
          )
        else
          for (var i = 0; i < visibleSales.length; i++) ...[
            SaleTile(
              sale: visibleSales[i],
              displayNumber: visibleSales.length - i,
              onDetailsTap: () => _showDetails(visibleSales[i]),
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
    required this.transactionCount,
    required this.onNewSaleTap,
  });

  final String shopName;
  final int transactionCount;
  final VoidCallback onNewSaleTap;

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
          child: Icon(Icons.receipt_long_rounded, color: colorScheme.primary),
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
                    'Sales ',
                    style: AppTextStyles.bodySmall,
                    color: colorScheme.onSurface,
                  ),
                  AppText(
                    '($transactionCount transactions)',
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
            onTap: onNewSaleTap,
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
                    'New Sale',
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

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.totalLabel,
    required this.trendPercent,
    required this.orderCount,
  });

  final String totalLabel;
  final double? trendPercent;
  final int orderCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Container(
      padding: const EdgeInsets.all(AppDimens.p16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: AppRadius.medium,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF18221D).useOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      "Today's Total Sales",
                      style: AppTextStyles.label,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    AppSpacing.h4,
                    AppText(
                      totalLabel,
                      style: AppTextStyles.headline,
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
              if (trendPercent != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.p10,
                    vertical: AppDimens.p4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer.useOpacity(0.6),
                    borderRadius: AppRadius.pill,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendPercent! >= 0
                            ? Icons.trending_up_rounded
                            : Icons.trending_down_rounded,
                        size: 16,
                        color: colorScheme.secondary,
                      ),
                      AppSpacing.w4,
                      AppText(
                        '${trendPercent! >= 0 ? '+' : ''}${trendPercent!.toStringAsFixed(0)}% vs yesterday',
                        style: AppTextStyles.label,
                        color: colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDimens.p12),
            child: Divider(
              height: 1,
              color: colorScheme.surfaceContainerHighest,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.receipt_long_rounded,
                size: 16,
                color: colorScheme.primary,
              ),
              AppSpacing.w6,
              AppText(
                'Total count: ',
                style: AppTextStyles.label,
                color: colorScheme.onSurfaceVariant,
              ),
              AppText(
                '$orderCount transactions today',
                style: AppTextStyles.label,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, this.onTap});

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return Material(
      color: selected ? colorScheme.primaryContainer : colorScheme.surface,
      borderRadius: AppRadius.pill,
      child: InkWell(
        borderRadius: AppRadius.pill,
        onTap: onTap,
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.p14),
          decoration: BoxDecoration(
            borderRadius: AppRadius.pill,
            border: selected
                ? null
                : Border.all(color: colorScheme.outlineVariant),
          ),
          alignment: Alignment.center,
          child: AppText(
            label,
            style: AppTextStyles.label,
            color: selected
                ? colorScheme.onPrimaryContainer
                : colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.p4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            label,
            style: AppTextStyles.label,
            color: colorScheme.outline,
          ),
          AppText(
            value,
            style: AppTextStyles.bodySmall,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

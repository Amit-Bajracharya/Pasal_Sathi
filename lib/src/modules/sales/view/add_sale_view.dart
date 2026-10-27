import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/products/data/repository/product_repository.dart';
import 'package:pasal_sathi/src/modules/products/model/product_model.dart';
import 'package:pasal_sathi/src/modules/sales/data/repository/sale_repository.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appButton/app_primary_button.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appCard/app_surface_card.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appDropdownField/app_dropdown_field.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appScaffold/app_scaffold_widget.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appTextField/app_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Form for recording a sale: pick a product, quantity, and unit price
/// (prefilled from the product's selling price), then save.
@RoutePage()
class AddSaleView extends ConsumerStatefulWidget {
  const AddSaleView({super.key});

  @override
  ConsumerState<AddSaleView> createState() => _AddSaleViewState();
}

class _AddSaleViewState extends ConsumerState<AddSaleView> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController(text: '1');
  final _unitPriceController = TextEditingController();

  Product? _selectedProduct;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _quantityController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  void _onProductChanged(Product? product) {
    setState(() {
      _selectedProduct = product;
      if (product != null) {
        _unitPriceController.text = product.sellingPrice.toStringAsFixed(0);
      }
    });
  }

  Future<void> _save({required bool addAnother}) async {
    final product = _selectedProduct;
    if (product == null) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(saleRepositoryProvider)
          .createSale(
            productId: product.id,
            quantity: double.parse(_quantityController.text),
            unitPrice: double.parse(_unitPriceController.text),
          );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sale of ${_selectedProduct!.name} saved')),
      );

      if (addAnother) {
        _formKey.currentState?.reset();
        _quantityController.text = '1';
        _unitPriceController.clear();
        setState(() => _selectedProduct = null);
      } else {
        Navigator.of(context).pop();
      }
    } on PostgrestException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final productsAsync = ref.watch(ownedProductsProvider);
    final products = productsAsync.value ?? const <Product>[];
    final quantity = double.tryParse(_quantityController.text) ?? 0;
    final unitPrice = double.tryParse(_unitPriceController.text) ?? 0;
    final total = quantity * unitPrice;

    return AppScaffoldWidget(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: AppText('New Sale', style: AppTextStyles.title),
      ),
      bottomNavigationBar: _BottomActionDock(
        isSubmitting: _isSubmitting,
        canSave: _selectedProduct != null,
        onSave: () => _save(addAnother: false),
        onSaveAndAddAnother: () => _save(addAnother: true),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            AppSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (products.isEmpty)
                    AppText(
                      'Add a product first before recording a sale.',
                      style: AppTextStyles.body,
                      color: colorScheme.outline,
                    )
                  else
                    AppDropdownField<Product>(
                      labelText: 'Product',
                      value: _selectedProduct ?? products.first,
                      items: products,
                      itemLabelBuilder: (p) => '${p.name} (${p.unitLabel})',
                      onChanged: _onProductChanged,
                      isMandatory: true,
                    ),
                  AppSpacing.h16,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          labelText: 'Quantity',
                          textEditingController: _quantityController,
                          isMandatory: true,
                          isDense: true,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => setState(() {}),
                          validator: (v) =>
                              (v == null ||
                                  double.tryParse(v) == null ||
                                  double.parse(v) <= 0)
                              ? 'Enter a valid quantity'
                              : null,
                        ),
                      ),
                      AppSpacing.w12,
                      Expanded(
                        child: AppTextField(
                          labelText: 'Unit price (NPR)',
                          textEditingController: _unitPriceController,
                          isMandatory: true,
                          isDense: true,
                          prefixText: 'NPR ',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          onChanged: (_) => setState(() {}),
                          validator: (v) =>
                              (v == null || double.tryParse(v) == null)
                              ? 'Enter a valid price'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.h16,
                  Container(
                    padding: const EdgeInsets.all(AppDimens.p14),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.useOpacity(0.5),
                      borderRadius: AppRadius.medium,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText(
                          'Total',
                          style: AppTextStyles.body,
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w600,
                        ),
                        AppText(
                          'NPR ${total.toStringAsFixed(0)}',
                          style: AppTextStyles.headline,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomActionDock extends StatelessWidget {
  const _BottomActionDock({
    required this.isSubmitting,
    required this.canSave,
    required this.onSave,
    required this.onSaveAndAddAnother,
  });

  final bool isSubmitting;
  final bool canSave;
  final VoidCallback onSave;
  final VoidCallback onSaveAndAddAnother;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(AppDimens.p16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppPrimaryButton(
              label: 'Save sale',
              onPressed: canSave ? onSave : () {},
              isLoading: isSubmitting,
            ),
            AppSpacing.h8,
            InkWell(
              borderRadius: AppRadius.medium,
              onTap: (isSubmitting || !canSave) ? null : onSaveAndAddAnother,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppDimens.p10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_rounded,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    AppSpacing.w6,
                    AppText(
                      'Save and add another',
                      style: AppTextStyles.label,
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

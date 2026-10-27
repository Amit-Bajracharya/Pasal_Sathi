import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pasal_sathi/src/core/config/extensions/extensions.dart';
import 'package:pasal_sathi/src/core/config/textTheme/text_theme.dart';
import 'package:pasal_sathi/src/core/constants/appSizes/app_sizes.dart';
import 'package:pasal_sathi/src/modules/products/data/repository/product_repository.dart';
import 'package:pasal_sathi/src/modules/products/data/repository/supplier_repository.dart';
import 'package:pasal_sathi/src/modules/products/model/product_unit.dart';
import 'package:pasal_sathi/src/modules/products/model/supplier_model.dart';
import 'package:pasal_sathi/src/modules/products/view/widgets/product_unit_selector.dart';
import 'package:pasal_sathi/src/modules/products/view/widgets/profit_banner.dart';
import 'package:pasal_sathi/src/modules/products/view/widgets/stock_stepper.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appButton/app_primary_button.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appCard/app_surface_card.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appDropdownField/app_dropdown_field.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appScaffold/app_scaffold_widget.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appText/app_text.dart';
import 'package:pasal_sathi/src/modules/shared/presenter/view/appTextField/app_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _categories = [
  'Snacks & Instant Food',
  'Grains & Rice',
  'Dairy & Eggs',
  'Oil & Spices',
  'Drinks & Juices',
  'Household & Cleaning',
  'Other Goods',
];

/// Form for adding a new product to inventory: name, unit, pricing with a
/// live profit readout, opening stock, and optional category/supplier/
/// shelf-life details.
@RoutePage()
class AddProductView extends ConsumerStatefulWidget {
  const AddProductView({super.key});

  @override
  ConsumerState<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends ConsumerState<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _stockController = TextEditingController(text: '0');
  final _shelfLifeController = TextEditingController();

  ProductUnit _selectedUnit = ProductUnit.packet;
  String _selectedCategory = _categories.first;
  Supplier? _selectedSupplier;
  bool _moreDetailsExpanded = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _sellingPriceController.dispose();
    _costPriceController.dispose();
    _stockController.dispose();
    _shelfLifeController.dispose();
    super.dispose();
  }

  Future<void> _save({required bool addAnother}) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    try {
      final supplierList = ref.read(suppliersProvider).value ?? const [];
      final supplierId =
          _selectedSupplier?.id ??
          (supplierList.isNotEmpty ? supplierList.first.id : null);

      await ref
          .read(productRepositoryProvider)
          .createProduct(
            name: _nameController.text.trim(),
            unit: _selectedUnit.name,
            sellingPrice: double.parse(_sellingPriceController.text),
            costPrice: double.parse(_costPriceController.text),
            stockQuantity: int.tryParse(_stockController.text) ?? 0,
            category: _selectedCategory,
            supplierId: supplierId,
            shelfLifeDays: int.tryParse(_shelfLifeController.text),
          );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${_nameController.text.trim()} saved')),
      );

      if (addAnother) {
        _formKey.currentState?.reset();
        _nameController.clear();
        _sellingPriceController.clear();
        _costPriceController.clear();
        _stockController.text = '0';
        _shelfLifeController.clear();
        setState(() => _selectedUnit = ProductUnit.packet);
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

  Future<void> _addSupplier() async {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final leadTimeController = TextEditingController();
    final dialogFormKey = GlobalKey<FormState>();

    final created = await showDialog<Supplier>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add supplier'),
        content: Form(
          key: dialogFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                labelText: 'Supplier name',
                textEditingController: nameController,
                isMandatory: true,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Required' : null,
              ),
              AppTextField(
                labelText: 'Phone',
                textEditingController: phoneController,
                isMandatory: false,
                keyboardType: TextInputType.phone,
              ),
              AppTextField(
                labelText: 'Lead time (days)',
                textEditingController: leadTimeController,
                isMandatory: false,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (!(dialogFormKey.currentState?.validate() ?? false)) return;
              try {
                final supplier = await ref
                    .read(supplierRepositoryProvider)
                    .createSupplier(
                      name: nameController.text.trim(),
                      phone: phoneController.text.trim().isEmpty
                          ? null
                          : phoneController.text.trim(),
                      leadTimeDays: int.tryParse(leadTimeController.text),
                    );
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(supplier);
                }
              } on PostgrestException catch (e) {
                if (dialogContext.mounted) {
                  ScaffoldMessenger.of(dialogContext)
                      .showSnackBar(SnackBar(content: Text(e.message)));
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    nameController.dispose();
    phoneController.dispose();
    leadTimeController.dispose();

    if (created != null) {
      ref.invalidate(suppliersProvider);
      setState(() => _selectedSupplier = created);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final supplierList = ref.watch(suppliersProvider).value ?? const [];
    final effectiveSupplier =
        _selectedSupplier ??
        (supplierList.isNotEmpty ? supplierList.first : null);

    return AppScaffoldWidget(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: AppText('Add Product', style: AppTextStyles.title),
      ),
      bottomNavigationBar: _BottomActionDock(
        isSubmitting: _isSubmitting,
        onSave: () => _save(addAnother: false),
        onSaveAndAddAnother: () => _save(addAnother: true),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          
          children: [
            AppSurfaceCard(
              padding: const EdgeInsets.fromLTRB(
                AppDimens.p16,
                AppDimens.p12,
                AppDimens.p16,
                AppDimens.p16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextField(
                    labelText: 'Product name',
                    textEditingController: _nameController,
                    hintText: 'e.g., Basmati Rice, DDC Milk',
                    isMandatory: true,
                    isDense: true,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Enter a product name'
                        : null,
                  ),
                  AppText(
                    'Unit',
                    style: AppTextStyles.label,
                    color: colorScheme.onSurface,
                  ),
                  AppSpacing.h8,
                  ProductUnitSelector(
                    selected: _selectedUnit,
                    onChanged: (unit) => setState(() => _selectedUnit = unit),
                  ),
                  AppSpacing.h16,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppTextField(
                          labelText: 'Selling price (NPR)',
                          textEditingController: _sellingPriceController,
                          isMandatory: true,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          isDense: true,
                          prefixText: 'NPR ',
                          addPrefixIconPadding: false,
                          bottomPadding: 0,
                          onChanged: (_) => setState(() {}),
                          validator: (v) =>
                              (v == null || double.tryParse(v) == null)
                              ? 'Required'
                              : null,
                        ),
                      ),
                      AppSpacing.w12,
                      Expanded(
                        child: AppTextField(
                          isDense: true,
                          labelText: 'Cost price (NPR)',
                          textEditingController: _costPriceController,
                          isMandatory: true,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          prefixText: 'NPR ',
                          bottomPadding: 0,
                          onChanged: (_) => setState(() {}),
                          validator: (v) =>
                              (v == null || double.tryParse(v) == null)
                              ? 'Required'
                              : null,
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.h16,
                  ProfitBanner(
                    sellingPrice: double.tryParse(_sellingPriceController.text),
                    costPrice: double.tryParse(_costPriceController.text),
                  ),
                  AppSpacing.h16,
                  AppText(
                    'Opening stock (${_selectedUnit.pluralLabel})',
                    style: AppTextStyles.label,
                    color: colorScheme.onSurface,
                  ),
                  AppSpacing.h8,
                  StockStepper(controller: _stockController),
                  AppSpacing.h6,
                  AppText(
                    'Available immediately in counter inventory',
                    style: AppTextStyles.label,
                    color: colorScheme.outline,
                  ),
                ],
              ),
            ),
            AppSpacing.h16,
            AppSurfaceCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  InkWell(
                    borderRadius: AppRadius.medium,
                    onTap: () => setState(
                      () => _moreDetailsExpanded = !_moreDetailsExpanded,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppDimens.p16),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.tune_rounded,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          AppSpacing.w12,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  'More details',
                                  style: AppTextStyles.title,
                                  color: colorScheme.onSurface,
                                ),
                                AppText(
                                  'Optional details',
                                  style: AppTextStyles.label,
                                  color: colorScheme.outline,
                                ),
                              ],
                            ),
                          ),
                          AnimatedRotation(
                            turns: _moreDetailsExpanded ? 0 : -0.25,
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.expand_more_rounded,
                              color: colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: _moreDetailsExpanded
                        ? Padding(
                            padding: const EdgeInsets.fromLTRB(
                              AppDimens.p16,
                              0,
                              AppDimens.p16,
                              AppDimens.p16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  color: colorScheme.outlineVariant.useOpacity(
                                    0.4,
                                  ),
                                ),
                                AppSpacing.h12,
                                AppDropdownField<String>(
                                  labelText: 'Category',
                                  value: _selectedCategory,
                                  items: _categories,
                                  itemLabelBuilder: (c) => c,
                                  onChanged: (v) =>
                                      setState(() => _selectedCategory = v!),
                                ),
                                AppSpacing.h16,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      'Supplier',
                                      style: AppTextStyles.label,
                                      color: colorScheme.onSurface,
                                    ),
                                    InkWell(
                                      onTap: _addSupplier,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.add_rounded,
                                            size: 16,
                                            color: colorScheme.primary,
                                          ),
                                          AppText(
                                            'Add new supplier',
                                            style: AppTextStyles.label,
                                            color: colorScheme.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                AppSpacing.h6,
                                if (supplierList.isEmpty)
                                  AppText(
                                    'No suppliers yet — add one above.',
                                    style: AppTextStyles.label,
                                    color: colorScheme.outline,
                                  )
                                else
                                  DropdownButtonFormField<Supplier>(
                                    initialValue: effectiveSupplier,
                                    itemHeight: null,
                                    icon: Icon(
                                      Icons.unfold_more_rounded,
                                      color: colorScheme.outline,
                                    ),
                                    style: AppTextStyles.body.copyWith(
                                      color: colorScheme.onSurface,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: colorScheme.surface,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: AppDimens.p14,
                                            vertical: AppDimens.p14,
                                          ),
                                      border: OutlineInputBorder(
                                        borderRadius: AppRadius.medium,
                                        borderSide: BorderSide(
                                          color: colorScheme.outlineVariant,
                                        ),
                                      ),
                                    ),
                                    items: [
                                      for (final s in supplierList)
                                        DropdownMenuItem(
                                          value: s,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: AppDimens.p8,
                                            ),
                                            child: AppText(s.name),
                                          ),
                                        ),
                                    ],
                                    onChanged: (v) =>
                                        setState(() => _selectedSupplier = v),
                                  ),
                                AppSpacing.h16,
                                AppTextField(
                                  labelText: 'Shelf life in days',
                                  textEditingController: _shelfLifeController,
                                  hintText: 'e.g., 180',
                                  keyboardType: TextInputType.number,
                                  bottomPadding: AppDimens.p4,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      size: 14,
                                      color: colorScheme.outline,
                                    ),
                                    AppSpacing.w4,
                                    Expanded(
                                      child: AppText(
                                        'For items that expire (sets auto-expiry tracking)',
                                        style: AppTextStyles.label,
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(width: double.infinity),
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
    required this.onSave,
    required this.onSaveAndAddAnother,
  });

  final bool isSubmitting;
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
              label: 'Save product',
              onPressed: onSave,
              isLoading: isSubmitting,
            ),
            AppSpacing.h8,
            InkWell(
              borderRadius: AppRadius.medium,
              onTap: isSubmitting ? null : onSaveAndAddAnother,
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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pasal_sathi/src/modules/products/model/product_unit.dart';

part 'product_model.freezed.dart';

/// How a [Product]'s stock level should be presented.
enum ProductStockStatus { normal, lowStock, outOfStock }

/// A single row in the Products & Inventory list.
@freezed
abstract class Product with _$Product {
  const factory Product({
    required String name,
    required String category,
    required String unitLabel,
    required double sellingPrice,
    required double costPrice,
    required int stockQuantity,

    /// e.g. "80 packets in stock" or "Only 4 pouches left!".
    required String stockLabel,
    required ProductStockStatus status,

    /// Secondary tag shown next to the category chip, e.g. "Barcode: 890123"
    /// or "Fast Mover" — purely informational, not status-related. `null`
    /// when there's nothing to show (the real data has no analog yet).
    String? tagLabel,
  }) = _Product;

  const Product._();

  /// Below this quantity (but above zero) a product is flagged "Low Stock".
  static const lowStockThreshold = 5;

  double get margin => sellingPrice - costPrice;

  double get marginPercent => costPrice == 0 ? 0 : (margin / costPrice) * 100;

  /// Builds a [Product] from a `products` table row (see
  /// `supabase/migrations/20261026020000_initial_schema.sql`).
  factory Product.fromRow(Map<String, dynamic> row) {
    final unit = ProductUnit.values.byName(row['unit'] as String);
    final stockQuantity = (row['current_stock'] as num).toInt();
    final status = stockQuantity <= 0
        ? ProductStockStatus.outOfStock
        : stockQuantity <= lowStockThreshold
        ? ProductStockStatus.lowStock
        : ProductStockStatus.normal;

    return Product(
      name: row['name'] as String,
      category: (row['category'] as String?) ?? 'Uncategorized',
      unitLabel: unit.label,
      sellingPrice: (row['selling_price'] as num).toDouble(),
      costPrice: (row['cost_price'] as num).toDouble(),
      stockQuantity: stockQuantity,
      stockLabel: _stockLabelFor(stockQuantity, unit, status),
      status: status,
    );
  }

  static String _stockLabelFor(
    int quantity,
    ProductUnit unit,
    ProductStockStatus status,
  ) {
    switch (status) {
      case ProductStockStatus.outOfStock:
        return '0 ${unit.pluralLabel} available';
      case ProductStockStatus.lowStock:
        return 'Only $quantity ${unit.pluralLabel} left!';
      case ProductStockStatus.normal:
        return '$quantity ${unit.pluralLabel} in stock';
    }
  }
}

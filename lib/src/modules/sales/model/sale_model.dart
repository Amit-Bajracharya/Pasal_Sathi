import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_model.freezed.dart';

/// A single sale line (one product, one quantity, one price) from the
/// `sales` table.
@freezed
abstract class Sale with _$Sale {
  const factory Sale({
    required String id,
    required String productId,
    required String productName,
    required String unitLabel,
    required double quantity,
    required double unitPrice,
    required DateTime saleDate,
    required DateTime createdAt,
  }) = _Sale;

  const Sale._();

  double get total => quantity * unitPrice;

  /// Builds a [Sale] from a `sales` row joined with its product's `name`
  /// and `unit` (see `supabase/migrations/20261026020000_initial_schema.sql`).
  factory Sale.fromRow(Map<String, dynamic> row) {
    final product = row['products'] as Map<String, dynamic>?;
    return Sale(
      id: row['id'] as String,
      productId: row['product_id'] as String,
      productName: (product?['name'] as String?) ?? 'Unknown product',
      unitLabel: (product?['unit'] as String?) ?? '',
      quantity: (row['quantity'] as num).toDouble(),
      unitPrice: (row['unit_price'] as num?)?.toDouble() ?? 0,
      saleDate: DateTime.parse(row['sale_date'] as String),
      createdAt: DateTime.parse(row['created_at'] as String),
    );
  }
}

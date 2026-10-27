import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier_model.freezed.dart';

/// A supplier an owner orders stock from — backs the `supplier_id` foreign
/// key on `products`.
@freezed
abstract class Supplier with _$Supplier {
  const factory Supplier({
    required String id,
    required String name,
    String? phone,
    int? leadTimeDays,
  }) = _Supplier;

  const Supplier._();

  factory Supplier.fromRow(Map<String, dynamic> row) {
    return Supplier(
      id: row['id'] as String,
      name: row['name'] as String,
      phone: row['phone'] as String?,
      leadTimeDays: (row['lead_time_days'] as num?)?.toInt(),
    );
  }
}

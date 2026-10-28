import 'package:pasal_sathi/src/core/providers/supabase/supabase_client_provider.dart';
import 'package:pasal_sathi/src/modules/sales/model/sale_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sale_repository.g.dart';

/// Wraps Supabase calls for the `sales` table (see
/// `supabase/migrations/20261026020000_initial_schema.sql`).
///
/// Inserting a sale also decrements the product's `current_stock` via the
/// `trg_sales` trigger, so no separate stock update is needed here.
class SaleRepository {
  SaleRepository(this._client);

  final SupabaseClient _client;

  /// Records a sale of [quantity] units of [productId] at [unitPrice].
  Future<void> createSale({
    required String productId,
    required double quantity,
    required double unitPrice,
    DateTime? saleDate,
  }) {
    final ownerId = _client.auth.currentUser?.id;
    if (ownerId == null) {
      throw const AuthException('No signed-in user.');
    }

    final date = saleDate ?? DateTime.now();
    return _client.from('sales').insert({
      'owner_id': ownerId,
      'product_id': productId,
      'quantity': quantity,
      'unit_price': unitPrice,
      'sale_date': date.toIso8601String().split('T').first,
    });
  }

  /// Fetches every sale owned by the current user, newest first, joined
  /// with its product's name and unit.
  Future<List<Map<String, dynamic>>> fetchSales() async {
    final ownerId = _client.auth.currentUser?.id;
    if (ownerId == null) return const [];

    final rows = await _client
        .from('sales')
        .select('*, products(name, unit, category)')
        .eq('owner_id', ownerId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(rows);
  }
}

@riverpod
SaleRepository saleRepository(Ref ref) {
  return SaleRepository(ref.watch(supabaseClientProvider));
}

/// Every sale owned by the current user, newest first.
@riverpod
Future<List<Sale>> ownedSales(Ref ref) async {
  final rows = await ref.watch(saleRepositoryProvider).fetchSales();
  return [for (final row in rows) Sale.fromRow(row)];
}

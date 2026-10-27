import 'package:pasal_sathi/src/core/providers/supabase/supabase_client_provider.dart';
import 'package:pasal_sathi/src/modules/products/model/supplier_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supplier_repository.g.dart';

/// Wraps Supabase calls for the `suppliers` table (see
/// `supabase/migrations/20261026020000_initial_schema.sql`).
class SupplierRepository {
  SupplierRepository(this._client);

  final SupabaseClient _client;

  /// Fetches every supplier owned by the current user, alphabetically.
  Future<List<Supplier>> fetchSuppliers() async {
    final ownerId = _client.auth.currentUser?.id;
    if (ownerId == null) return const [];

    final rows = await _client
        .from('suppliers')
        .select()
        .eq('owner_id', ownerId)
        .order('name');
    return [for (final row in rows) Supplier.fromRow(row)];
  }

  /// Creates a supplier for the current owner and returns the new row.
  Future<Supplier> createSupplier({
    required String name,
    String? phone,
    int? leadTimeDays,
  }) async {
    final ownerId = _client.auth.currentUser?.id;
    if (ownerId == null) {
      throw const AuthException('No signed-in user.');
    }

    final row = await _client
        .from('suppliers')
        .insert({
          'owner_id': ownerId,
          'name': name,
          'phone': phone,
          'lead_time_days': ?leadTimeDays,
        })
        .select()
        .single();
    return Supplier.fromRow(row);
  }
}

@riverpod
SupplierRepository supplierRepository(Ref ref) {
  return SupplierRepository(ref.watch(supabaseClientProvider));
}

/// Every supplier owned by the current user.
@riverpod
Future<List<Supplier>> suppliers(Ref ref) {
  return ref.watch(supplierRepositoryProvider).fetchSuppliers();
}

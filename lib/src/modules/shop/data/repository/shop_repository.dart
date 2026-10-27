import 'package:pasal_sathi/src/core/providers/supabase/supabase_client_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'shop_repository.g.dart';

/// Wraps Supabase calls for the `shops` table (see
/// `supabase/migrations/20261026020000_initial_schema.sql`).
///
/// One row per owner, enforced by a unique constraint on `owner_id` and
/// row-level security policies that scope every read/write to `auth.uid()`.
class ShopRepository {
  ShopRepository(this._client);

  final SupabaseClient _client;

  /// Creates the shop row for the given owner right after sign up.
  ///
  /// Must be called while the owner's session is still active — RLS checks
  /// `owner_id = auth.uid()`, so this throws [PostgrestException] if called
  /// without a session (e.g. email confirmation is required and pending).
  Future<void> createShop({required String ownerId, required String name}) {
    return _client.from('shops').insert({'owner_id': ownerId, 'name': name});
  }

  /// Fetches the shop name for the currently signed-in owner, or `null` if
  /// they don't have one yet.
  Future<String?> fetchCurrentShopName() async {
    final ownerId = _client.auth.currentUser?.id;
    if (ownerId == null) return null;

    final row = await _client
        .from('shops')
        .select('name')
        .eq('owner_id', ownerId)
        .maybeSingle();
    return row?['name'] as String?;
  }
}

@riverpod
ShopRepository shopRepository(Ref ref) {
  return ShopRepository(ref.watch(supabaseClientProvider));
}

/// The current owner's shop name, or `null` if they don't have one yet.
@riverpod
Future<String?> currentShopName(Ref ref) {
  return ref.watch(shopRepositoryProvider).fetchCurrentShopName();
}

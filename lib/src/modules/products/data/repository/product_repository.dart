import 'package:pasal_sathi/src/core/providers/supabase/supabase_client_provider.dart';
import 'package:pasal_sathi/src/modules/products/model/product_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_repository.g.dart';

/// Wraps Supabase calls for the `products` table (see
/// `supabase/migrations/20261026020000_initial_schema.sql`).
///
/// Every row is scoped directly to its owner — row-level security rejects
/// any read/write where `owner_id != auth.uid()`.
class ProductRepository {
  ProductRepository(this._client);

  final SupabaseClient _client;

  /// Adds a product to the current owner's inventory.
  ///
  /// Throws [PostgrestException] if there's no signed-in user, the name
  /// collides with an existing product (`unique (owner_id, name)`), or
  /// `supplierId` doesn't belong to this owner.
  Future<void> createProduct({
    required String name,
    required String unit,
    required double sellingPrice,
    required double costPrice,
    required int stockQuantity,
    String? category,
    String? supplierId,
    int? shelfLifeDays,
  }) {
    final ownerId = _client.auth.currentUser?.id;
    if (ownerId == null) {
      throw const AuthException('No signed-in user.');
    }

    return _client.from('products').insert({
      'owner_id': ownerId,
      'name': name,
      'unit': unit,
      'selling_price': sellingPrice,
      'cost_price': costPrice,
      'current_stock': stockQuantity,
      'category': category,
      'supplier_id': supplierId,
      'shelf_life_days': shelfLifeDays,
    });
  }

  /// Fetches every product owned by the current user, newest first.
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final ownerId = _client.auth.currentUser?.id;
    if (ownerId == null) return const [];

    final rows = await _client
        .from('products')
        .select()
        .eq('owner_id', ownerId)
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(rows);
  }
}

@riverpod
ProductRepository productRepository(Ref ref) {
  return ProductRepository(ref.watch(supabaseClientProvider));
}

/// Every product owned by the current user.
@riverpod
Future<List<Product>> ownedProducts(Ref ref) async {
  final rows = await ref.watch(productRepositoryProvider).fetchProducts();
  return [for (final row in rows) Product.fromRow(row)];
}

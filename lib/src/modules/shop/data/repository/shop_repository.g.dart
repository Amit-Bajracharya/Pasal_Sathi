// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shopRepository)
final shopRepositoryProvider = ShopRepositoryProvider._();

final class ShopRepositoryProvider
    extends $FunctionalProvider<ShopRepository, ShopRepository, ShopRepository>
    with $Provider<ShopRepository> {
  ShopRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shopRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shopRepositoryHash();

  @$internal
  @override
  $ProviderElement<ShopRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ShopRepository create(Ref ref) {
    return shopRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShopRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShopRepository>(value),
    );
  }
}

String _$shopRepositoryHash() => r'1077875d1eb8e34dc64b8147ed1d6f05f5e6beac';

/// The current owner's shop name, or `null` if they don't have one yet.

@ProviderFor(currentShopName)
final currentShopNameProvider = CurrentShopNameProvider._();

/// The current owner's shop name, or `null` if they don't have one yet.

final class CurrentShopNameProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// The current owner's shop name, or `null` if they don't have one yet.
  CurrentShopNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentShopNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentShopNameHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return currentShopName(ref);
  }
}

String _$currentShopNameHash() => r'244dda44c476e26b224161eb3adab02e2c653540';

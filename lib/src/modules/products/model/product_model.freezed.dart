// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Product {

 String get id; String get name; String get category; String get unitLabel; double get sellingPrice; double get costPrice; int get stockQuantity;/// e.g. "80 packets in stock" or "Only 4 pouches left!".
 String get stockLabel; ProductStockStatus get status;/// Secondary tag shown next to the category chip, e.g. "Barcode: 890123"
/// or "Fast Mover" — purely informational, not status-related. `null`
/// when there's nothing to show (the real data has no analog yet).
 String? get tagLabel;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Product;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.unitLabel, _this.unitLabel) || other.unitLabel == _this.unitLabel)&&(identical(other.sellingPrice, _this.sellingPrice) || other.sellingPrice == _this.sellingPrice)&&(identical(other.costPrice, _this.costPrice) || other.costPrice == _this.costPrice)&&(identical(other.stockQuantity, _this.stockQuantity) || other.stockQuantity == _this.stockQuantity)&&(identical(other.stockLabel, _this.stockLabel) || other.stockLabel == _this.stockLabel)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.tagLabel, _this.tagLabel) || other.tagLabel == _this.tagLabel));
}


@override
int get hashCode {
  final _this = this as Product;
  return Object.hash(runtimeType,_this.id,_this.name,_this.category,_this.unitLabel,_this.sellingPrice,_this.costPrice,_this.stockQuantity,_this.stockLabel,_this.status,_this.tagLabel);
}

@override
String toString() {
  final _this = this as Product;
  return 'Product(id: ${_this.id}, name: ${_this.name}, category: ${_this.category}, unitLabel: ${_this.unitLabel}, sellingPrice: ${_this.sellingPrice}, costPrice: ${_this.costPrice}, stockQuantity: ${_this.stockQuantity}, stockLabel: ${_this.stockLabel}, status: ${_this.status}, tagLabel: ${_this.tagLabel})';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String category, String unitLabel, double sellingPrice, double costPrice, int stockQuantity, String stockLabel, ProductStockStatus status, String? tagLabel
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? category = null,Object? unitLabel = null,Object? sellingPrice = null,Object? costPrice = null,Object? stockQuantity = null,Object? stockLabel = null,Object? status = null,Object? tagLabel = freezed,}) {
  return _then(Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,unitLabel: null == unitLabel ? _self.unitLabel : unitLabel // ignore: cast_nullable_to_non_nullable
as String,sellingPrice: null == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double,costPrice: null == costPrice ? _self.costPrice : costPrice // ignore: cast_nullable_to_non_nullable
as double,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,stockLabel: null == stockLabel ? _self.stockLabel : stockLabel // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProductStockStatus,tagLabel: freezed == tagLabel ? _self.tagLabel : tagLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String unitLabel,  double sellingPrice,  double costPrice,  int stockQuantity,  String stockLabel,  ProductStockStatus status,  String? tagLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.unitLabel,_that.sellingPrice,_that.costPrice,_that.stockQuantity,_that.stockLabel,_that.status,_that.tagLabel);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String category,  String unitLabel,  double sellingPrice,  double costPrice,  int stockQuantity,  String stockLabel,  ProductStockStatus status,  String? tagLabel)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.category,_that.unitLabel,_that.sellingPrice,_that.costPrice,_that.stockQuantity,_that.stockLabel,_that.status,_that.tagLabel);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String category,  String unitLabel,  double sellingPrice,  double costPrice,  int stockQuantity,  String stockLabel,  ProductStockStatus status,  String? tagLabel)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.category,_that.unitLabel,_that.sellingPrice,_that.costPrice,_that.stockQuantity,_that.stockLabel,_that.status,_that.tagLabel);case _:
  return null;

}
}

}

/// @nodoc


class _Product extends Product {
  const _Product({required this.id, required this.name, required this.category, required this.unitLabel, required this.sellingPrice, required this.costPrice, required this.stockQuantity, required this.stockLabel, required this.status, this.tagLabel}): super._();
  

@override final  String id;
@override final  String name;
@override final  String category;
@override final  String unitLabel;
@override final  double sellingPrice;
@override final  double costPrice;
@override final  int stockQuantity;
/// e.g. "80 packets in stock" or "Only 4 pouches left!".
@override final  String stockLabel;
@override final  ProductStockStatus status;
/// Secondary tag shown next to the category chip, e.g. "Barcode: 890123"
/// or "Fast Mover" — purely informational, not status-related. `null`
/// when there's nothing to show (the real data has no analog yet).
@override final  String? tagLabel;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.unitLabel, unitLabel) || other.unitLabel == unitLabel)&&(identical(other.sellingPrice, sellingPrice) || other.sellingPrice == sellingPrice)&&(identical(other.costPrice, costPrice) || other.costPrice == costPrice)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.stockLabel, stockLabel) || other.stockLabel == stockLabel)&&(identical(other.status, status) || other.status == status)&&(identical(other.tagLabel, tagLabel) || other.tagLabel == tagLabel));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,category,unitLabel,sellingPrice,costPrice,stockQuantity,stockLabel,status,tagLabel);
}

@override
String toString() {
    return 'Product(id: $id, name: $name, category: $category, unitLabel: $unitLabel, sellingPrice: $sellingPrice, costPrice: $costPrice, stockQuantity: $stockQuantity, stockLabel: $stockLabel, status: $status, tagLabel: $tagLabel)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String category, String unitLabel, double sellingPrice, double costPrice, int stockQuantity, String stockLabel, ProductStockStatus status, String? tagLabel
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? category = null,Object? unitLabel = null,Object? sellingPrice = null,Object? costPrice = null,Object? stockQuantity = null,Object? stockLabel = null,Object? status = null,Object? tagLabel = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,unitLabel: null == unitLabel ? _self.unitLabel : unitLabel // ignore: cast_nullable_to_non_nullable
as String,sellingPrice: null == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double,costPrice: null == costPrice ? _self.costPrice : costPrice // ignore: cast_nullable_to_non_nullable
as double,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,stockLabel: null == stockLabel ? _self.stockLabel : stockLabel // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProductStockStatus,tagLabel: freezed == tagLabel ? _self.tagLabel : tagLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

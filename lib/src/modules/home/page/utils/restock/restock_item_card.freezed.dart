// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restock_item_card.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestockItem {

 String get name; String get quantityLabel; String get caption; bool get isUrgent;
/// Create a copy of RestockItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestockItemCopyWith<RestockItem> get copyWith => _$RestockItemCopyWithImpl<RestockItem>(this as RestockItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RestockItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestockItem&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.quantityLabel, _this.quantityLabel) || other.quantityLabel == _this.quantityLabel)&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.isUrgent, _this.isUrgent) || other.isUrgent == _this.isUrgent));
}


@override
int get hashCode {
  final _this = this as RestockItem;
  return Object.hash(runtimeType,_this.name,_this.quantityLabel,_this.caption,_this.isUrgent);
}

@override
String toString() {
  final _this = this as RestockItem;
  return 'RestockItem(name: ${_this.name}, quantityLabel: ${_this.quantityLabel}, caption: ${_this.caption}, isUrgent: ${_this.isUrgent})';
}


}

/// @nodoc
abstract mixin class $RestockItemCopyWith<$Res>  {
  factory $RestockItemCopyWith(RestockItem value, $Res Function(RestockItem) _then) = _$RestockItemCopyWithImpl;
@useResult
$Res call({
 String name, String quantityLabel, String caption, bool isUrgent
});




}
/// @nodoc
class _$RestockItemCopyWithImpl<$Res>
    implements $RestockItemCopyWith<$Res> {
  _$RestockItemCopyWithImpl(this._self, this._then);

  final RestockItem _self;
  final $Res Function(RestockItem) _then;

/// Create a copy of RestockItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? quantityLabel = null,Object? caption = null,Object? isUrgent = null,}) {
  return _then(RestockItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantityLabel: null == quantityLabel ? _self.quantityLabel : quantityLabel // ignore: cast_nullable_to_non_nullable
as String,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RestockItem].
extension RestockItemPatterns on RestockItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RestockItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RestockItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RestockItem value)  $default,){
final _that = this;
switch (_that) {
case _RestockItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RestockItem value)?  $default,){
final _that = this;
switch (_that) {
case _RestockItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String quantityLabel,  String caption,  bool isUrgent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RestockItem() when $default != null:
return $default(_that.name,_that.quantityLabel,_that.caption,_that.isUrgent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String quantityLabel,  String caption,  bool isUrgent)  $default,) {final _that = this;
switch (_that) {
case _RestockItem():
return $default(_that.name,_that.quantityLabel,_that.caption,_that.isUrgent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String quantityLabel,  String caption,  bool isUrgent)?  $default,) {final _that = this;
switch (_that) {
case _RestockItem() when $default != null:
return $default(_that.name,_that.quantityLabel,_that.caption,_that.isUrgent);case _:
  return null;

}
}

}

/// @nodoc


class _RestockItem implements RestockItem {
  const _RestockItem({required this.name, required this.quantityLabel, required this.caption, this.isUrgent = false});
  

@override final  String name;
@override final  String quantityLabel;
@override final  String caption;
@override@JsonKey() final  bool isUrgent;

/// Create a copy of RestockItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RestockItemCopyWith<_RestockItem> get copyWith => __$RestockItemCopyWithImpl<_RestockItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RestockItem&&(identical(other.name, name) || other.name == name)&&(identical(other.quantityLabel, quantityLabel) || other.quantityLabel == quantityLabel)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,quantityLabel,caption,isUrgent);
}

@override
String toString() {
    return 'RestockItem(name: $name, quantityLabel: $quantityLabel, caption: $caption, isUrgent: $isUrgent)';
}


}

/// @nodoc
abstract mixin class _$RestockItemCopyWith<$Res> implements $RestockItemCopyWith<$Res> {
  factory _$RestockItemCopyWith(_RestockItem value, $Res Function(_RestockItem) _then) = __$RestockItemCopyWithImpl;
@override @useResult
$Res call({
 String name, String quantityLabel, String caption, bool isUrgent
});




}
/// @nodoc
class __$RestockItemCopyWithImpl<$Res>
    implements _$RestockItemCopyWith<$Res> {
  __$RestockItemCopyWithImpl(this._self, this._then);

  final _RestockItem _self;
  final $Res Function(_RestockItem) _then;

/// Create a copy of RestockItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? quantityLabel = null,Object? caption = null,Object? isUrgent = null,}) {
  return _then(_RestockItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,quantityLabel: null == quantityLabel ? _self.quantityLabel : quantityLabel // ignore: cast_nullable_to_non_nullable
as String,caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

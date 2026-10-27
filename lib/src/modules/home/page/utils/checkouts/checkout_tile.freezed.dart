// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_tile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutRecord {

 String get billNumber; PaymentMethod get method; String get customerLabel; String get amountLabel; String get timeAgoLabel;
/// Create a copy of CheckoutRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutRecordCopyWith<CheckoutRecord> get copyWith => _$CheckoutRecordCopyWithImpl<CheckoutRecord>(this as CheckoutRecord, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckoutRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutRecord&&(identical(other.billNumber, _this.billNumber) || other.billNumber == _this.billNumber)&&(identical(other.method, _this.method) || other.method == _this.method)&&(identical(other.customerLabel, _this.customerLabel) || other.customerLabel == _this.customerLabel)&&(identical(other.amountLabel, _this.amountLabel) || other.amountLabel == _this.amountLabel)&&(identical(other.timeAgoLabel, _this.timeAgoLabel) || other.timeAgoLabel == _this.timeAgoLabel));
}


@override
int get hashCode {
  final _this = this as CheckoutRecord;
  return Object.hash(runtimeType,_this.billNumber,_this.method,_this.customerLabel,_this.amountLabel,_this.timeAgoLabel);
}

@override
String toString() {
  final _this = this as CheckoutRecord;
  return 'CheckoutRecord(billNumber: ${_this.billNumber}, method: ${_this.method}, customerLabel: ${_this.customerLabel}, amountLabel: ${_this.amountLabel}, timeAgoLabel: ${_this.timeAgoLabel})';
}


}

/// @nodoc
abstract mixin class $CheckoutRecordCopyWith<$Res>  {
  factory $CheckoutRecordCopyWith(CheckoutRecord value, $Res Function(CheckoutRecord) _then) = _$CheckoutRecordCopyWithImpl;
@useResult
$Res call({
 String billNumber, PaymentMethod method, String customerLabel, String amountLabel, String timeAgoLabel
});




}
/// @nodoc
class _$CheckoutRecordCopyWithImpl<$Res>
    implements $CheckoutRecordCopyWith<$Res> {
  _$CheckoutRecordCopyWithImpl(this._self, this._then);

  final CheckoutRecord _self;
  final $Res Function(CheckoutRecord) _then;

/// Create a copy of CheckoutRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? billNumber = null,Object? method = null,Object? customerLabel = null,Object? amountLabel = null,Object? timeAgoLabel = null,}) {
  return _then(CheckoutRecord(
billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,customerLabel: null == customerLabel ? _self.customerLabel : customerLabel // ignore: cast_nullable_to_non_nullable
as String,amountLabel: null == amountLabel ? _self.amountLabel : amountLabel // ignore: cast_nullable_to_non_nullable
as String,timeAgoLabel: null == timeAgoLabel ? _self.timeAgoLabel : timeAgoLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutRecord].
extension CheckoutRecordPatterns on CheckoutRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutRecord value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutRecord value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String billNumber,  PaymentMethod method,  String customerLabel,  String amountLabel,  String timeAgoLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutRecord() when $default != null:
return $default(_that.billNumber,_that.method,_that.customerLabel,_that.amountLabel,_that.timeAgoLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String billNumber,  PaymentMethod method,  String customerLabel,  String amountLabel,  String timeAgoLabel)  $default,) {final _that = this;
switch (_that) {
case _CheckoutRecord():
return $default(_that.billNumber,_that.method,_that.customerLabel,_that.amountLabel,_that.timeAgoLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String billNumber,  PaymentMethod method,  String customerLabel,  String amountLabel,  String timeAgoLabel)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutRecord() when $default != null:
return $default(_that.billNumber,_that.method,_that.customerLabel,_that.amountLabel,_that.timeAgoLabel);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutRecord implements CheckoutRecord {
  const _CheckoutRecord({required this.billNumber, required this.method, required this.customerLabel, required this.amountLabel, required this.timeAgoLabel});
  

@override final  String billNumber;
@override final  PaymentMethod method;
@override final  String customerLabel;
@override final  String amountLabel;
@override final  String timeAgoLabel;

/// Create a copy of CheckoutRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutRecordCopyWith<_CheckoutRecord> get copyWith => __$CheckoutRecordCopyWithImpl<_CheckoutRecord>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutRecord&&(identical(other.billNumber, billNumber) || other.billNumber == billNumber)&&(identical(other.method, method) || other.method == method)&&(identical(other.customerLabel, customerLabel) || other.customerLabel == customerLabel)&&(identical(other.amountLabel, amountLabel) || other.amountLabel == amountLabel)&&(identical(other.timeAgoLabel, timeAgoLabel) || other.timeAgoLabel == timeAgoLabel));
}


@override
int get hashCode {
    return Object.hash(runtimeType,billNumber,method,customerLabel,amountLabel,timeAgoLabel);
}

@override
String toString() {
    return 'CheckoutRecord(billNumber: $billNumber, method: $method, customerLabel: $customerLabel, amountLabel: $amountLabel, timeAgoLabel: $timeAgoLabel)';
}


}

/// @nodoc
abstract mixin class _$CheckoutRecordCopyWith<$Res> implements $CheckoutRecordCopyWith<$Res> {
  factory _$CheckoutRecordCopyWith(_CheckoutRecord value, $Res Function(_CheckoutRecord) _then) = __$CheckoutRecordCopyWithImpl;
@override @useResult
$Res call({
 String billNumber, PaymentMethod method, String customerLabel, String amountLabel, String timeAgoLabel
});




}
/// @nodoc
class __$CheckoutRecordCopyWithImpl<$Res>
    implements _$CheckoutRecordCopyWith<$Res> {
  __$CheckoutRecordCopyWithImpl(this._self, this._then);

  final _CheckoutRecord _self;
  final $Res Function(_CheckoutRecord) _then;

/// Create a copy of CheckoutRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? billNumber = null,Object? method = null,Object? customerLabel = null,Object? amountLabel = null,Object? timeAgoLabel = null,}) {
  return _then(_CheckoutRecord(
billNumber: null == billNumber ? _self.billNumber : billNumber // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,customerLabel: null == customerLabel ? _self.customerLabel : customerLabel // ignore: cast_nullable_to_non_nullable
as String,amountLabel: null == amountLabel ? _self.amountLabel : amountLabel // ignore: cast_nullable_to_non_nullable
as String,timeAgoLabel: null == timeAgoLabel ? _self.timeAgoLabel : timeAgoLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

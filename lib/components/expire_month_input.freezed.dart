// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expire_month_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExpireMonthInputData {
  DateTime? get date;
  bool get noExpirationDate;

  /// Create a copy of ExpireMonthInputData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExpireMonthInputDataCopyWith<ExpireMonthInputData> get copyWith =>
      _$ExpireMonthInputDataCopyWithImpl<ExpireMonthInputData>(
          this as ExpireMonthInputData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpireMonthInputData &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.noExpirationDate, noExpirationDate) ||
                other.noExpirationDate == noExpirationDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, noExpirationDate);

  @override
  String toString() {
    return 'ExpireMonthInputData(date: $date, noExpirationDate: $noExpirationDate)';
  }
}

/// @nodoc
abstract mixin class $ExpireMonthInputDataCopyWith<$Res> {
  factory $ExpireMonthInputDataCopyWith(ExpireMonthInputData value,
          $Res Function(ExpireMonthInputData) _then) =
      _$ExpireMonthInputDataCopyWithImpl;
  @useResult
  $Res call({DateTime? date, bool noExpirationDate});
}

/// @nodoc
class _$ExpireMonthInputDataCopyWithImpl<$Res>
    implements $ExpireMonthInputDataCopyWith<$Res> {
  _$ExpireMonthInputDataCopyWithImpl(this._self, this._then);

  final ExpireMonthInputData _self;
  final $Res Function(ExpireMonthInputData) _then;

  /// Create a copy of ExpireMonthInputData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? noExpirationDate = null,
  }) {
    return _then(_self.copyWith(
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      noExpirationDate: null == noExpirationDate
          ? _self.noExpirationDate
          : noExpirationDate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _ExpireMonthInputData extends ExpireMonthInputData {
  const _ExpireMonthInputData({this.date, this.noExpirationDate = false})
      : super._();

  @override
  final DateTime? date;
  @override
  @JsonKey()
  final bool noExpirationDate;

  /// Create a copy of ExpireMonthInputData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExpireMonthInputDataCopyWith<_ExpireMonthInputData> get copyWith =>
      __$ExpireMonthInputDataCopyWithImpl<_ExpireMonthInputData>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExpireMonthInputData &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.noExpirationDate, noExpirationDate) ||
                other.noExpirationDate == noExpirationDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, noExpirationDate);

  @override
  String toString() {
    return 'ExpireMonthInputData(date: $date, noExpirationDate: $noExpirationDate)';
  }
}

/// @nodoc
abstract mixin class _$ExpireMonthInputDataCopyWith<$Res>
    implements $ExpireMonthInputDataCopyWith<$Res> {
  factory _$ExpireMonthInputDataCopyWith(_ExpireMonthInputData value,
          $Res Function(_ExpireMonthInputData) _then) =
      __$ExpireMonthInputDataCopyWithImpl;
  @override
  @useResult
  $Res call({DateTime? date, bool noExpirationDate});
}

/// @nodoc
class __$ExpireMonthInputDataCopyWithImpl<$Res>
    implements _$ExpireMonthInputDataCopyWith<$Res> {
  __$ExpireMonthInputDataCopyWithImpl(this._self, this._then);

  final _ExpireMonthInputData _self;
  final $Res Function(_ExpireMonthInputData) _then;

  /// Create a copy of ExpireMonthInputData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? date = freezed,
    Object? noExpirationDate = null,
  }) {
    return _then(_ExpireMonthInputData(
      date: freezed == date
          ? _self.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      noExpirationDate: null == noExpirationDate
          ? _self.noExpirationDate
          : noExpirationDate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on

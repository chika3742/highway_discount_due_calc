// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expire_month_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExpireMonthInputData {
  DateTime? get date => throw _privateConstructorUsedError;
  bool get noExpirationDate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExpireMonthInputDataCopyWith<ExpireMonthInputData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpireMonthInputDataCopyWith<$Res> {
  factory $ExpireMonthInputDataCopyWith(ExpireMonthInputData value,
          $Res Function(ExpireMonthInputData) then) =
      _$ExpireMonthInputDataCopyWithImpl<$Res, ExpireMonthInputData>;
  @useResult
  $Res call({DateTime? date, bool noExpirationDate});
}

/// @nodoc
class _$ExpireMonthInputDataCopyWithImpl<$Res,
        $Val extends ExpireMonthInputData>
    implements $ExpireMonthInputDataCopyWith<$Res> {
  _$ExpireMonthInputDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? noExpirationDate = null,
  }) {
    return _then(_value.copyWith(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      noExpirationDate: null == noExpirationDate
          ? _value.noExpirationDate
          : noExpirationDate // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpireMonthInputDataImplCopyWith<$Res>
    implements $ExpireMonthInputDataCopyWith<$Res> {
  factory _$$ExpireMonthInputDataImplCopyWith(_$ExpireMonthInputDataImpl value,
          $Res Function(_$ExpireMonthInputDataImpl) then) =
      __$$ExpireMonthInputDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? date, bool noExpirationDate});
}

/// @nodoc
class __$$ExpireMonthInputDataImplCopyWithImpl<$Res>
    extends _$ExpireMonthInputDataCopyWithImpl<$Res, _$ExpireMonthInputDataImpl>
    implements _$$ExpireMonthInputDataImplCopyWith<$Res> {
  __$$ExpireMonthInputDataImplCopyWithImpl(_$ExpireMonthInputDataImpl _value,
      $Res Function(_$ExpireMonthInputDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = freezed,
    Object? noExpirationDate = null,
  }) {
    return _then(_$ExpireMonthInputDataImpl(
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      noExpirationDate: null == noExpirationDate
          ? _value.noExpirationDate
          : noExpirationDate // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ExpireMonthInputDataImpl implements _ExpireMonthInputData {
  const _$ExpireMonthInputDataImpl({this.date, this.noExpirationDate = false});

  @override
  final DateTime? date;
  @override
  @JsonKey()
  final bool noExpirationDate;

  @override
  String toString() {
    return 'ExpireMonthInputData(date: $date, noExpirationDate: $noExpirationDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpireMonthInputDataImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.noExpirationDate, noExpirationDate) ||
                other.noExpirationDate == noExpirationDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date, noExpirationDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpireMonthInputDataImplCopyWith<_$ExpireMonthInputDataImpl>
      get copyWith =>
          __$$ExpireMonthInputDataImplCopyWithImpl<_$ExpireMonthInputDataImpl>(
              this, _$identity);
}

abstract class _ExpireMonthInputData implements ExpireMonthInputData {
  const factory _ExpireMonthInputData(
      {final DateTime? date,
      final bool noExpirationDate}) = _$ExpireMonthInputDataImpl;

  @override
  DateTime? get date;
  @override
  bool get noExpirationDate;
  @override
  @JsonKey(ignore: true)
  _$$ExpireMonthInputDataImplCopyWith<_$ExpireMonthInputDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

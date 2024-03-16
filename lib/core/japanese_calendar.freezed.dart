// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'japanese_calendar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$JapaneseCalendarYear {
  JapaneseEra get era => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $JapaneseCalendarYearCopyWith<JapaneseCalendarYear> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JapaneseCalendarYearCopyWith<$Res> {
  factory $JapaneseCalendarYearCopyWith(JapaneseCalendarYear value,
          $Res Function(JapaneseCalendarYear) then) =
      _$JapaneseCalendarYearCopyWithImpl<$Res, JapaneseCalendarYear>;
  @useResult
  $Res call({JapaneseEra era, int year});
}

/// @nodoc
class _$JapaneseCalendarYearCopyWithImpl<$Res,
        $Val extends JapaneseCalendarYear>
    implements $JapaneseCalendarYearCopyWith<$Res> {
  _$JapaneseCalendarYearCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? era = null,
    Object? year = null,
  }) {
    return _then(_value.copyWith(
      era: null == era
          ? _value.era
          : era // ignore: cast_nullable_to_non_nullable
              as JapaneseEra,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JapaneseCalendarYearImplCopyWith<$Res>
    implements $JapaneseCalendarYearCopyWith<$Res> {
  factory _$$JapaneseCalendarYearImplCopyWith(_$JapaneseCalendarYearImpl value,
          $Res Function(_$JapaneseCalendarYearImpl) then) =
      __$$JapaneseCalendarYearImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({JapaneseEra era, int year});
}

/// @nodoc
class __$$JapaneseCalendarYearImplCopyWithImpl<$Res>
    extends _$JapaneseCalendarYearCopyWithImpl<$Res, _$JapaneseCalendarYearImpl>
    implements _$$JapaneseCalendarYearImplCopyWith<$Res> {
  __$$JapaneseCalendarYearImplCopyWithImpl(_$JapaneseCalendarYearImpl _value,
      $Res Function(_$JapaneseCalendarYearImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? era = null,
    Object? year = null,
  }) {
    return _then(_$JapaneseCalendarYearImpl(
      era: null == era
          ? _value.era
          : era // ignore: cast_nullable_to_non_nullable
              as JapaneseEra,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$JapaneseCalendarYearImpl extends _JapaneseCalendarYear {
  const _$JapaneseCalendarYearImpl({required this.era, required this.year})
      : super._();

  @override
  final JapaneseEra era;
  @override
  final int year;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JapaneseCalendarYearImpl &&
            (identical(other.era, era) || other.era == era) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(runtimeType, era, year);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JapaneseCalendarYearImplCopyWith<_$JapaneseCalendarYearImpl>
      get copyWith =>
          __$$JapaneseCalendarYearImplCopyWithImpl<_$JapaneseCalendarYearImpl>(
              this, _$identity);
}

abstract class _JapaneseCalendarYear extends JapaneseCalendarYear {
  const factory _JapaneseCalendarYear(
      {required final JapaneseEra era,
      required final int year}) = _$JapaneseCalendarYearImpl;
  const _JapaneseCalendarYear._() : super._();

  @override
  JapaneseEra get era;
  @override
  int get year;
  @override
  @JsonKey(ignore: true)
  _$$JapaneseCalendarYearImplCopyWith<_$JapaneseCalendarYearImpl>
      get copyWith => throw _privateConstructorUsedError;
}

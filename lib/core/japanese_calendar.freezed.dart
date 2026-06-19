// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'japanese_calendar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JapaneseCalendarYear {
  JapaneseEra get era;
  int get year;

  /// Create a copy of JapaneseCalendarYear
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $JapaneseCalendarYearCopyWith<JapaneseCalendarYear> get copyWith =>
      _$JapaneseCalendarYearCopyWithImpl<JapaneseCalendarYear>(
          this as JapaneseCalendarYear, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is JapaneseCalendarYear &&
            (identical(other.era, era) || other.era == era) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(runtimeType, era, year);
}

/// @nodoc
abstract mixin class $JapaneseCalendarYearCopyWith<$Res> {
  factory $JapaneseCalendarYearCopyWith(JapaneseCalendarYear value,
          $Res Function(JapaneseCalendarYear) _then) =
      _$JapaneseCalendarYearCopyWithImpl;
  @useResult
  $Res call({JapaneseEra era, int year});
}

/// @nodoc
class _$JapaneseCalendarYearCopyWithImpl<$Res>
    implements $JapaneseCalendarYearCopyWith<$Res> {
  _$JapaneseCalendarYearCopyWithImpl(this._self, this._then);

  final JapaneseCalendarYear _self;
  final $Res Function(JapaneseCalendarYear) _then;

  /// Create a copy of JapaneseCalendarYear
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? era = null,
    Object? year = null,
  }) {
    return _then(_self.copyWith(
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as JapaneseEra,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _JapaneseCalendarYear extends JapaneseCalendarYear {
  const _JapaneseCalendarYear({required this.era, required this.year})
      : super._();

  @override
  final JapaneseEra era;
  @override
  final int year;

  /// Create a copy of JapaneseCalendarYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$JapaneseCalendarYearCopyWith<_JapaneseCalendarYear> get copyWith =>
      __$JapaneseCalendarYearCopyWithImpl<_JapaneseCalendarYear>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JapaneseCalendarYear &&
            (identical(other.era, era) || other.era == era) &&
            (identical(other.year, year) || other.year == year));
  }

  @override
  int get hashCode => Object.hash(runtimeType, era, year);
}

/// @nodoc
abstract mixin class _$JapaneseCalendarYearCopyWith<$Res>
    implements $JapaneseCalendarYearCopyWith<$Res> {
  factory _$JapaneseCalendarYearCopyWith(_JapaneseCalendarYear value,
          $Res Function(_JapaneseCalendarYear) _then) =
      __$JapaneseCalendarYearCopyWithImpl;
  @override
  @useResult
  $Res call({JapaneseEra era, int year});
}

/// @nodoc
class __$JapaneseCalendarYearCopyWithImpl<$Res>
    implements _$JapaneseCalendarYearCopyWith<$Res> {
  __$JapaneseCalendarYearCopyWithImpl(this._self, this._then);

  final _JapaneseCalendarYear _self;
  final $Res Function(_JapaneseCalendarYear) _then;

  /// Create a copy of JapaneseCalendarYear
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? era = null,
    Object? year = null,
  }) {
    return _then(_JapaneseCalendarYear(
      era: null == era
          ? _self.era
          : era // ignore: cast_nullable_to_non_nullable
              as JapaneseEra,
      year: null == year
          ? _self.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on

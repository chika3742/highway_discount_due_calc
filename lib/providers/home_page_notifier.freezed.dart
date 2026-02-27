// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HomePageState {
  ProcedureType get procedureType;
  DateTime? get birthDate;
  ExpireMonthInputData? get physicalExpire;
  ExpireMonthInputData? get rehabilitationExpire;
  bool get registerVehicle;
  bool get useEtc;
  bool get leaseVehicle;
  bool get isCertType2;
  bool get isAgent;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      _$HomePageStateCopyWithImpl<HomePageState>(
          this as HomePageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HomePageState &&
            (identical(other.procedureType, procedureType) ||
                other.procedureType == procedureType) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.physicalExpire, physicalExpire) ||
                other.physicalExpire == physicalExpire) &&
            (identical(other.rehabilitationExpire, rehabilitationExpire) ||
                other.rehabilitationExpire == rehabilitationExpire) &&
            (identical(other.registerVehicle, registerVehicle) ||
                other.registerVehicle == registerVehicle) &&
            (identical(other.useEtc, useEtc) || other.useEtc == useEtc) &&
            (identical(other.leaseVehicle, leaseVehicle) ||
                other.leaseVehicle == leaseVehicle) &&
            (identical(other.isCertType2, isCertType2) ||
                other.isCertType2 == isCertType2) &&
            (identical(other.isAgent, isAgent) || other.isAgent == isAgent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      procedureType,
      birthDate,
      physicalExpire,
      rehabilitationExpire,
      registerVehicle,
      useEtc,
      leaseVehicle,
      isCertType2,
      isAgent);

  @override
  String toString() {
    return 'HomePageState(procedureType: $procedureType, birthDate: $birthDate, physicalExpire: $physicalExpire, rehabilitationExpire: $rehabilitationExpire, registerVehicle: $registerVehicle, useEtc: $useEtc, leaseVehicle: $leaseVehicle, isCertType2: $isCertType2, isAgent: $isAgent)';
  }
}

/// @nodoc
abstract mixin class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) _then) =
      _$HomePageStateCopyWithImpl;
  @useResult
  $Res call(
      {ProcedureType procedureType,
      DateTime? birthDate,
      ExpireMonthInputData? physicalExpire,
      ExpireMonthInputData? rehabilitationExpire,
      bool registerVehicle,
      bool useEtc,
      bool leaseVehicle,
      bool isCertType2,
      bool isAgent});

  $ExpireMonthInputDataCopyWith<$Res>? get physicalExpire;
  $ExpireMonthInputDataCopyWith<$Res>? get rehabilitationExpire;
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._self, this._then);

  final HomePageState _self;
  final $Res Function(HomePageState) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? procedureType = null,
    Object? birthDate = freezed,
    Object? physicalExpire = freezed,
    Object? rehabilitationExpire = freezed,
    Object? registerVehicle = null,
    Object? useEtc = null,
    Object? leaseVehicle = null,
    Object? isCertType2 = null,
    Object? isAgent = null,
  }) {
    return _then(_self.copyWith(
      procedureType: null == procedureType
          ? _self.procedureType
          : procedureType // ignore: cast_nullable_to_non_nullable
              as ProcedureType,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      physicalExpire: freezed == physicalExpire
          ? _self.physicalExpire
          : physicalExpire // ignore: cast_nullable_to_non_nullable
              as ExpireMonthInputData?,
      rehabilitationExpire: freezed == rehabilitationExpire
          ? _self.rehabilitationExpire
          : rehabilitationExpire // ignore: cast_nullable_to_non_nullable
              as ExpireMonthInputData?,
      registerVehicle: null == registerVehicle
          ? _self.registerVehicle
          : registerVehicle // ignore: cast_nullable_to_non_nullable
              as bool,
      useEtc: null == useEtc
          ? _self.useEtc
          : useEtc // ignore: cast_nullable_to_non_nullable
              as bool,
      leaseVehicle: null == leaseVehicle
          ? _self.leaseVehicle
          : leaseVehicle // ignore: cast_nullable_to_non_nullable
              as bool,
      isCertType2: null == isCertType2
          ? _self.isCertType2
          : isCertType2 // ignore: cast_nullable_to_non_nullable
              as bool,
      isAgent: null == isAgent
          ? _self.isAgent
          : isAgent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpireMonthInputDataCopyWith<$Res>? get physicalExpire {
    if (_self.physicalExpire == null) {
      return null;
    }

    return $ExpireMonthInputDataCopyWith<$Res>(_self.physicalExpire!, (value) {
      return _then(_self.copyWith(physicalExpire: value));
    });
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpireMonthInputDataCopyWith<$Res>? get rehabilitationExpire {
    if (_self.rehabilitationExpire == null) {
      return null;
    }

    return $ExpireMonthInputDataCopyWith<$Res>(_self.rehabilitationExpire!,
        (value) {
      return _then(_self.copyWith(rehabilitationExpire: value));
    });
  }
}

/// @nodoc

class _HomePageState extends HomePageState {
  const _HomePageState(
      {required this.procedureType,
      required this.birthDate,
      required this.physicalExpire,
      required this.rehabilitationExpire,
      required this.registerVehicle,
      required this.useEtc,
      required this.leaseVehicle,
      required this.isCertType2,
      required this.isAgent})
      : super._();

  @override
  final ProcedureType procedureType;
  @override
  final DateTime? birthDate;
  @override
  final ExpireMonthInputData? physicalExpire;
  @override
  final ExpireMonthInputData? rehabilitationExpire;
  @override
  final bool registerVehicle;
  @override
  final bool useEtc;
  @override
  final bool leaseVehicle;
  @override
  final bool isCertType2;
  @override
  final bool isAgent;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HomePageStateCopyWith<_HomePageState> get copyWith =>
      __$HomePageStateCopyWithImpl<_HomePageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HomePageState &&
            (identical(other.procedureType, procedureType) ||
                other.procedureType == procedureType) &&
            (identical(other.birthDate, birthDate) ||
                other.birthDate == birthDate) &&
            (identical(other.physicalExpire, physicalExpire) ||
                other.physicalExpire == physicalExpire) &&
            (identical(other.rehabilitationExpire, rehabilitationExpire) ||
                other.rehabilitationExpire == rehabilitationExpire) &&
            (identical(other.registerVehicle, registerVehicle) ||
                other.registerVehicle == registerVehicle) &&
            (identical(other.useEtc, useEtc) || other.useEtc == useEtc) &&
            (identical(other.leaseVehicle, leaseVehicle) ||
                other.leaseVehicle == leaseVehicle) &&
            (identical(other.isCertType2, isCertType2) ||
                other.isCertType2 == isCertType2) &&
            (identical(other.isAgent, isAgent) || other.isAgent == isAgent));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      procedureType,
      birthDate,
      physicalExpire,
      rehabilitationExpire,
      registerVehicle,
      useEtc,
      leaseVehicle,
      isCertType2,
      isAgent);

  @override
  String toString() {
    return 'HomePageState(procedureType: $procedureType, birthDate: $birthDate, physicalExpire: $physicalExpire, rehabilitationExpire: $rehabilitationExpire, registerVehicle: $registerVehicle, useEtc: $useEtc, leaseVehicle: $leaseVehicle, isCertType2: $isCertType2, isAgent: $isAgent)';
  }
}

/// @nodoc
abstract mixin class _$HomePageStateCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$HomePageStateCopyWith(
          _HomePageState value, $Res Function(_HomePageState) _then) =
      __$HomePageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ProcedureType procedureType,
      DateTime? birthDate,
      ExpireMonthInputData? physicalExpire,
      ExpireMonthInputData? rehabilitationExpire,
      bool registerVehicle,
      bool useEtc,
      bool leaseVehicle,
      bool isCertType2,
      bool isAgent});

  @override
  $ExpireMonthInputDataCopyWith<$Res>? get physicalExpire;
  @override
  $ExpireMonthInputDataCopyWith<$Res>? get rehabilitationExpire;
}

/// @nodoc
class __$HomePageStateCopyWithImpl<$Res>
    implements _$HomePageStateCopyWith<$Res> {
  __$HomePageStateCopyWithImpl(this._self, this._then);

  final _HomePageState _self;
  final $Res Function(_HomePageState) _then;

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? procedureType = null,
    Object? birthDate = freezed,
    Object? physicalExpire = freezed,
    Object? rehabilitationExpire = freezed,
    Object? registerVehicle = null,
    Object? useEtc = null,
    Object? leaseVehicle = null,
    Object? isCertType2 = null,
    Object? isAgent = null,
  }) {
    return _then(_HomePageState(
      procedureType: null == procedureType
          ? _self.procedureType
          : procedureType // ignore: cast_nullable_to_non_nullable
              as ProcedureType,
      birthDate: freezed == birthDate
          ? _self.birthDate
          : birthDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      physicalExpire: freezed == physicalExpire
          ? _self.physicalExpire
          : physicalExpire // ignore: cast_nullable_to_non_nullable
              as ExpireMonthInputData?,
      rehabilitationExpire: freezed == rehabilitationExpire
          ? _self.rehabilitationExpire
          : rehabilitationExpire // ignore: cast_nullable_to_non_nullable
              as ExpireMonthInputData?,
      registerVehicle: null == registerVehicle
          ? _self.registerVehicle
          : registerVehicle // ignore: cast_nullable_to_non_nullable
              as bool,
      useEtc: null == useEtc
          ? _self.useEtc
          : useEtc // ignore: cast_nullable_to_non_nullable
              as bool,
      leaseVehicle: null == leaseVehicle
          ? _self.leaseVehicle
          : leaseVehicle // ignore: cast_nullable_to_non_nullable
              as bool,
      isCertType2: null == isCertType2
          ? _self.isCertType2
          : isCertType2 // ignore: cast_nullable_to_non_nullable
              as bool,
      isAgent: null == isAgent
          ? _self.isAgent
          : isAgent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpireMonthInputDataCopyWith<$Res>? get physicalExpire {
    if (_self.physicalExpire == null) {
      return null;
    }

    return $ExpireMonthInputDataCopyWith<$Res>(_self.physicalExpire!, (value) {
      return _then(_self.copyWith(physicalExpire: value));
    });
  }

  /// Create a copy of HomePageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExpireMonthInputDataCopyWith<$Res>? get rehabilitationExpire {
    if (_self.rehabilitationExpire == null) {
      return null;
    }

    return $ExpireMonthInputDataCopyWith<$Res>(_self.rehabilitationExpire!,
        (value) {
      return _then(_self.copyWith(rehabilitationExpire: value));
    });
  }
}

// dart format on

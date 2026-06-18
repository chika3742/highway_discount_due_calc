import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:highway_discount_due_calc/components/expire_month_input.dart';
import 'package:highway_discount_due_calc/core/expiration_date_calculator.dart';
import 'package:highway_discount_due_calc/core/procedure_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils.dart';

part 'home_page_notifier.freezed.dart';
part 'home_page_notifier.g.dart';

@riverpod
class HomePageNotifier extends _$HomePageNotifier {
  @override
  HomePageState build() {
    return const HomePageState(
      procedureType: ProcedureType.update,
      birthDate: null,
      physicalExpire: null,
      rehabilitationExpire: null,
      registerVehicle: false,
      useEtc: false,
      leaseVehicle: false,
      isCertType2: false,
      isAgent: false,
    );
  }

  void setProcedureType(ProcedureType procedureType) {
    state = state.copyWith(procedureType: procedureType);
  }

  void setBirthDate(DateTime? birthDate) {
    state = state.copyWith(birthDate: birthDate);
  }

  void setPhysicalExpire(ExpireMonthInputData? physicalExpDate) {
    state = state.copyWith(physicalExpire: physicalExpDate);
  }

  void setRehabilitationExpire(ExpireMonthInputData? rehabilitationExpDate) {
    state = state.copyWith(rehabilitationExpire: rehabilitationExpDate);
  }

  void setRegisterVehicle(bool registerVehicle) {
    state = state.copyWith(registerVehicle: registerVehicle);
  }

  void setUseEtc(bool useEtc) {
    state = state.copyWith(useEtc: useEtc);
  }

  void setLeaseVehicle(bool leaseVehicle) {
    state = state.copyWith(leaseVehicle: leaseVehicle);
  }

  void setIsCertType2(bool isCertType2) {
    state = state.copyWith(isCertType2: isCertType2);
  }

  void setIsAgent(bool isAgent) {
    state = state.copyWith(isAgent: isAgent);
  }

  void clear() {
    ref.invalidateSelf();
  }
}

@freezed
sealed class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    required ProcedureType procedureType,
    required DateTime? birthDate,
    required ExpireMonthInputData? physicalExpire,
    required ExpireMonthInputData? rehabilitationExpire,
    required bool registerVehicle,
    required bool useEtc,
    required bool leaseVehicle,
    required bool isCertType2,
    required bool isAgent,
  }) = _HomePageState;

  bool get isInputValid => birthDate != null &&
      physicalExpire?.isValid != false &&
      rehabilitationExpire?.isValid != false;

  (DateTime, bool)? get _calcResult {
    if (!isInputValid) {
      return null;
    }

    return calculateExpirationDate(
      procedureType,
      birthDate!,
      physicalExpire,
      rehabilitationExpire,
    );
  }

  DateTime? get expirationDate => _calcResult?.$1;

  bool? get isDueToExpiration => _calcResult?.$2;

  bool get becomesAdultBeforeExpirationDate {
    if (!isInputValid) {
      return false;
    }
    final now = clock.now();

    var adultBorderBirthday = birthDate!.copyWith(year: birthDate!.year + adultAge);
    return adultBorderBirthday.isAfter(now)
        && adultBorderBirthday.isBefore(expirationDate!);
  }

  bool? get isAdult {
    if (!isInputValid) {
      return null;
    }

    final now = clock.now();

    final adultBorderBirthday = Clock.fixed(birthDate!).yearsFromNow(adultAge);
    return !adultBorderBirthday.isAfter(now);
  }

  bool get isTodayOver2MonthsBeforeBirthday {
    if (!isInputValid) {
      return false;
    }
    if (procedureType != ProcedureType.update) {
      return false;
    }
    return isMoreThanTwoMonthsAhead(birthDate!.month, birthDate!.day);
  }
}

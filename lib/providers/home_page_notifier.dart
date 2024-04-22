import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kigenkeisann/home.dart';
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
      hasExpirationDate: false,
      physicalExpDate: null,
      rehabilitationExpDate: null,
      registerVehicle: false,
      useEtc: false,
      leaseVehicle: false,
      isCertType2: false,
    );
  }

  void setProcedureType(ProcedureType procedureType) {
    state = state.copyWith(procedureType: procedureType);
  }

  void setBirthDate(DateTime? birthDate) {
    state = state.copyWith(birthDate: birthDate);
  }

  void setHasExpirationDate(bool hasExpirationDate) {
    state = state.copyWith(hasExpirationDate: hasExpirationDate);
  }

  void setPhysicalExpDate(DateTime? physicalExpDate) {
    state = state.copyWith(physicalExpDate: physicalExpDate);
  }

  void setRehabilitationExpDate(DateTime? rehabilitationExpDate) {
    state = state.copyWith(rehabilitationExpDate: rehabilitationExpDate);
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

  void clear() {
    state = state.copyWith(
      birthDate: null,
      physicalExpDate: null,
      rehabilitationExpDate: null,
      isCertType2: false,
      registerVehicle: false,
      useEtc: false,
      leaseVehicle: false,
    );
  }
}

@freezed
class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    required ProcedureType procedureType,
    required DateTime? birthDate,
    required bool hasExpirationDate,
    required DateTime? physicalExpDate,
    required DateTime? rehabilitationExpDate,
    required bool registerVehicle,
    required bool useEtc,
    required bool leaseVehicle,
    required bool isCertType2,
  }) = _HomePageState;

  DateTime? get expirationDate {
    if (birthDate == null) {
      return null;
    }

    final now = clock.now();

    var result = DateTime(
      now.year,
      birthDate!.month,
      birthDate!.day,
    );
    if (result.isBeforeOrAtSameMomentAs(now)) {
      result = Clock.fixed(result).yearsFromNow(1);
    }
    // result: 次の誕生日
    result = Clock.fixed(result).yearsFromNow(
      procedureType.birthdaysBeforeExpirationDate - 1,
    );
    // result: 本来の有効期限日
    // 手続き日が誕生日より２ヶ月以上前である場合は、手続き日から2回目の誕生日
    if (procedureType == ProcedureType.update
        && isTodayOver2MonthsBeforeBirthday) {
      result = Clock.fixed(result).yearsFromNow(-1);
    }

    if (hasExpirationDate &&
        (physicalExpDate != null ||
            rehabilitationExpDate != null)) {
      result = earlierDate(
        result,
        laterDate(
          physicalExpDate,
          rehabilitationExpDate,
        ),
      );
    }

    return result;
  }
  
  bool get isTurns18BeforeExpirationDate {
    if (birthDate == null) {
      return false;
    }
    final now = clock.now();

    var x18thBirthday = birthDate!.copyWith(year: birthDate!.year + 18);
    return x18thBirthday.isAfter(now)
        && x18thBirthday.isBefore(expirationDate!);
  }

  bool get isTodayOver2MonthsBeforeBirthday {
    if (birthDate == null) {
      return false;
    }

    final now = clock.now();

    var result = DateTime(
      now.year,
      birthDate!.month,
      birthDate!.day,
    );
    if (result.isBeforeOrAtSameMomentAs(now)) {
      result = result.copyWith(year: result.year + 1);
    }
    result = result.copyWith(month: result.month - 2);
    return now.isBefore(result);
  }

  bool? get isOver18YearsOld {
    if (birthDate == null) {
      return null;
    }

    final now = clock.now();

    final x18thBirthday = Clock.fixed(birthDate!).yearsFromNow(18);
    return x18thBirthday.isBefore(now);
  }
}

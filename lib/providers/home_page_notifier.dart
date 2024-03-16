import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kigenkeisann/home.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../utils.dart';
import 'birthday_input_notifier.dart';

part 'home_page_notifier.freezed.dart';
part 'home_page_notifier.g.dart';

@riverpod
class HomePageNotifier extends _$HomePageNotifier {
  @override
  HomePageState build() {
    ref.listen(birthdayInputNotifierProvider, (_, newValue) {
      setBirthDate(newValue.date);
    });

    return const HomePageState(
      procedureType: ProcedureType.update,
      birthDate: null,
      hasExpirationDate: false,
      physicalExpirationDate: null,
      rehabilitationExpirationDate: null,
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

  void setPhysicalExpirationDate(DateTime? physicalExpirationDate) {
    state = state.copyWith(physicalExpirationDate: physicalExpirationDate);
  }

  void setRehabilitationExpirationDate(DateTime? rehabilitationExpirationDate) {
    state = state.copyWith(rehabilitationExpirationDate: rehabilitationExpirationDate);
  }
}

@freezed
class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    required ProcedureType procedureType,
    required DateTime? birthDate,
    required bool hasExpirationDate,
    required DateTime? physicalExpirationDate,
    required DateTime? rehabilitationExpirationDate,
  }) = _HomePageState;

  DateTime? get expirationDate {
    if (birthDate == null) {
      return null;
    }

    var result = DateTime(
      DateTime.now().year,
      birthDate!.month,
      birthDate!.day,
    );
    if (result.isBefore(DateTime.now())) {
      result = result.copyWith(year: result.year + 1);
    }
    // result: 次の誕生日
    result = result.copyWith(year: result.year
        + procedureType.birthdaysBeforeExpirationDate - 1);
    // result: 本来の有効期限日
    if (procedureType == ProcedureType.update
        && isTodayOver2MonthsBeforeBirthday) {
      result = result.copyWith(year: result.year - 1);
    }

    if (hasExpirationDate &&
        (physicalExpirationDate != null ||
            rehabilitationExpirationDate != null)) {
      result = earlierDate(
        result,
        laterDate(
          physicalExpirationDate,
          rehabilitationExpirationDate,
        ),
      );
    }

    return result;
  }
  
  bool get isTurns18BeforeExpirationDate {
    if (birthDate == null) {
      return false;
    }
    var nthBirthday = birthDate!.copyWith(year: birthDate!.year + 18);
    return nthBirthday.isAfter(DateTime.now())
        && nthBirthday.isBefore(expirationDate!);
  }

  bool get isTodayOver2MonthsBeforeBirthday {
    if (birthDate == null) {
      return false;
    }
    var result = DateTime(
      DateTime.now().year,
      birthDate!.month,
      birthDate!.day,
    );
    if (result.isBefore(DateTime.now())) {
      result = result.copyWith(year: result.year + 1);
    }
    result = result.copyWith(month: result.month - 2);
    return DateTime.now().isBefore(result);
  }
}

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kigenkeisann/home.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/japanese_calendar.dart';
import '../utils.dart';

part 'home_page_notifier.freezed.dart';
part 'home_page_notifier.g.dart';

@riverpod
class HomePageNotifier extends _$HomePageNotifier {
  @override
  HomePageState build() {
    return HomePageState(
      procedureType: ProcedureType.update,
      birthdayInputState: BirthdayInputState(
        yearController: TextEditingController(),
        dayController: TextEditingController(),
      ),
      hasExpirationDate: false,
      physicalExpDateInputState: YearMonthInputState(
        jcYearController: TextEditingController(),
      ),
      rehabilitationExpDateInputState: YearMonthInputState(
        jcYearController: TextEditingController(),
      ),
    );
  }

  void setProcedureType(ProcedureType procedureType) {
    state = state.copyWith(procedureType: procedureType);
  }

  void setBirthdayInputState(BirthdayInputState birthdayInputState) {
    state = state.copyWith(birthdayInputState: birthdayInputState);
    normalizeBirthdayDay();
  }

  void normalizeBirthdayDay() {
    final validationResult = state.birthdayInputState.validateDay(state.birthdayInputState.day);
    if (validationResult != null) {
      state.birthdayInputState.dayController.text = validationResult.toString();
    }
  }

  void setHasExpirationDate(bool hasExpirationDate) {
    state = state.copyWith(hasExpirationDate: hasExpirationDate);
  }

  void setPhysicalExpDateInputState(YearMonthInputState physicalExpDateInputState) {
    state = state.copyWith(physicalExpDateInputState: physicalExpDateInputState);
  }

  void setRehabilitationExpDateInputState(YearMonthInputState rehabilitationExpDateInputState) {
    state = state.copyWith(rehabilitationExpDateInputState: rehabilitationExpDateInputState);
  }

  void clear() {
    state = state.copyWith(
      birthdayInputState: state.birthdayInputState.copyWith(
        era: null,
        month: null,
      ),
      physicalExpDateInputState: state.physicalExpDateInputState.copyWith(
        month: null,
      ),
      rehabilitationExpDateInputState: state.rehabilitationExpDateInputState.copyWith(
        month: null,
      ),
    );
    state.birthdayInputState.clearText();
    state.physicalExpDateInputState.clearText();
    state.rehabilitationExpDateInputState.clearText();
  }
}

@freezed
class HomePageState with _$HomePageState {
  const HomePageState._();

  const factory HomePageState({
    required ProcedureType procedureType,
    required BirthdayInputState birthdayInputState,
    required bool hasExpirationDate,
    required YearMonthInputState physicalExpDateInputState,
    required YearMonthInputState rehabilitationExpDateInputState,
  }) = _HomePageState;

  DateTime? get birthDate => birthdayInputState.date;

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
        + procedureType.birthdaysBeforeExpirationDate - 1,);
    // result: 本来の有効期限日
    if (procedureType == ProcedureType.update
        && isTodayOver2MonthsBeforeBirthday) {
      result = result.copyWith(year: result.year - 1);
    }
    if (birthDate!.isLeapDay && !result.isLeapDay) {
      result = result.subtract(const Duration(days: 1));
    }

    if (hasExpirationDate &&
        (physicalExpDateInputState.date != null ||
            rehabilitationExpDateInputState.date != null)) {
      result = earlierDate(
        result,
        laterDate(
          physicalExpDateInputState.date,
          rehabilitationExpDateInputState.date,
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

@freezed
class BirthdayInputState with _$BirthdayInputState {
  const BirthdayInputState._();

  const factory BirthdayInputState({
    required TextEditingController yearController,
    required TextEditingController dayController,
    JapaneseEra? era,
    @Deprecated('Unused value (for notifying changes only)')
    String? mYear,
    int? month,
    @Deprecated('Unused value (for notifying changes only)')
    String? mDay,
  }) = _BirthdayInputState;

  int? get year => int.tryParse(yearController.text);

  int? get day => int.tryParse(dayController.text);

  JapaneseCalendarYear? get japaneseCalendarYear {
    if (era == null || year == null) {
      return null;
    }
    return JapaneseCalendarYear(era: era!, year: year!);
  }

  DateTime? get date {
    if (japaneseCalendarYear == null || month == null || day == null) {
      return null;
    }
    return DateTime(japaneseCalendarYear!.adYear, month!, day!);
  }

  /// if no change, return null
  int? validateDay(int? day) {
    if (day == null) {
      return null;
    }
    if (japaneseCalendarYear != null && month != null) {
      var dayLengthOfCurrentMonth = DateTime(japaneseCalendarYear!.adYear, month! + 1, 0).day;
      if (dayLengthOfCurrentMonth < day) {
        return dayLengthOfCurrentMonth;
      }
    }
    if (day > 31) {
      return 31;
    }
    return null;
  }

  void clearText() {
    yearController.clear();
    dayController.clear();
  }
}

@freezed
class YearMonthInputState with _$YearMonthInputState {
  const YearMonthInputState._();

  const factory YearMonthInputState({
    required TextEditingController jcYearController,
    @Deprecated("Unused value (for notifying changes only)")
    String? mJcYear,
    int? month,
  }) = _YearMonthInputState;

  DateTime? get date {
    if (jcYearController.text.isEmpty || month == null) {
      return null;
    }
    final jcYear = int.parse(jcYearController.text);
    return DateTime(jcYear + JapaneseEra.reiwa.startYear - 1, month! + 1, 0);
  }

  void clearText() {
    jcYearController.clear();
  }
}

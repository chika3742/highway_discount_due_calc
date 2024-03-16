import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kigenkeisann/core/japanese_calendar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'birthday_input_notifier.freezed.dart';
part 'birthday_input_notifier.g.dart';

@riverpod
class BirthdayInputNotifier extends _$BirthdayInputNotifier {
  @override
  BirthdayInputState build() {
    return BirthdayInputState(
      dayController: TextEditingController(),
    );
  }

  void setEra(JapaneseEra? era) {
    state = state.copyWith(era: era);
    normalizeDay();
  }

  void setYear(int? year) {
    state = state.copyWith(year: year);
    normalizeDay();
  }

  void setMonth(int? month) {
    state = state.copyWith(month: month);
    normalizeDay();
  }

  void setDay(int? day) {
    var validationResult = validateDay(day);
    state = state.copyWith(day: validationResult ?? day);
    if (validationResult != null) {
      state.dayController.text = validationResult.toString();
    }
  }

  int? validateDay(int? day) {
    if (day == null) {
      return null;
    }
    if (state.japaneseCalendarYear != null && state.month != null) {
      var dayLengthOfCurrentMonth = DateTime(state.japaneseCalendarYear!.adYear, state.month! + 1, 0).day;
      if (dayLengthOfCurrentMonth < day) {
        return dayLengthOfCurrentMonth;
      }
    }
    if (day > 31) {
      return 31;
    }
    return null;
  }

  void normalizeDay() {
    final validationResult = validateDay(state.day);
    if (validationResult != null) {
      setDay(validationResult);
      state.dayController.text = validationResult.toString();
    }
  }
}

@freezed
class BirthdayInputState with _$BirthdayInputState {
  const BirthdayInputState._();

  const factory BirthdayInputState({
    required TextEditingController dayController,
    JapaneseEra? era,
    int? year,
    int? month,
    int? day,
  }) = _BirthdayInputState;

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
}

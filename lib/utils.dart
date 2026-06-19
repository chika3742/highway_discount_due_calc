import "package:clock/clock.dart";
import "package:flutter/services.dart";

DateTime earlierDate(DateTime a, DateTime b) {
  return a.isBefore(b) ? a : b;
}

DateTime laterDate(DateTime? a, DateTime? b) {
  assert(a != null || b != null);
  return a == null ? b! : b == null ? a : a.isAfter(b) ? a : b;
}

final months = List.generate(12, (index) => index + 1);

extension DateTimeExtension on DateTime {
  bool get isLeapDay {
    return month == 2 && day == 29;
  }
}

final yearInputFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
  if (newValue.text.isEmpty) {
    return newValue;
  }

  final newValueInt = int.tryParse(newValue.text);
  if (newValueInt == null) {
    return oldValue;
  }
  if (newValueInt > 100) {
    return const TextEditingValue(text: "100");
  }
  return newValue;
});

/// 今日から、指定した月日が2ヶ月以上後であるかどうかを返します。
bool isMoreThanTwoMonthsAhead(int month, int day) {
  final now = clock.now();

  var target = DateTime(now.year, month, day);
  // 指定月日が今日より過去（または今日）なら、来年の同月日を対象にする
  if (!target.isAfter(now)) {
    target = target.copyWith(year: target.year + 1);
  }
  return target.copyWith(month: target.month - 2).isAfter(now);
}

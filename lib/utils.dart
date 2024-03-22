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

  bool isBeforeOrAtSameMomentAs(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }
}

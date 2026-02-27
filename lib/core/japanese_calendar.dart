import 'package:freezed_annotation/freezed_annotation.dart';

part "japanese_calendar.freezed.dart";

@freezed
sealed class JapaneseCalendarYear with _$JapaneseCalendarYear {
  const JapaneseCalendarYear._();

  const factory JapaneseCalendarYear({
    required JapaneseEra era,
    required int year,
  }) = _JapaneseCalendarYear;

  int get adYear => era.startYear + year - 1;

  @override
  String toString() {
    return "${era.text}$year";
  }
}

enum JapaneseEra {
  showa("昭和", 1926),
  heisei("平成", 1989),
  reiwa("令和", 2019),
  ;

  const JapaneseEra(this.text, this.startYear);

  final String text;
  final int startYear;
}

extension JapaneseCalendarYearExtension on DateTime {
  JapaneseCalendarYear? get japaneseCalendarYear {
    for (var value in [...JapaneseEra.values]
      ..sort((a, b) => b.startYear.compareTo(a.startYear))) {
      if (year >= value.startYear) {
        return JapaneseCalendarYear(era: value, year: year - value.startYear + 1);
      }
    }
    return null;
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:kigenkeisann/core/japanese_calendar.dart';

void main() {
  group('DateTime.japaneseCalendarYear（令和）', () {
    test('令和開始日（2019-05-01）は令和1年', () {
      final date = DateTime(2019, 5, 1);
      final result = date.japaneseCalendarYear;
      expect(result, isNotNull);
      expect(result!.era, JapaneseEra.reiwa);
      expect(result.year, 1);
    });

    test('2024-01-01 は令和6年', () {
      final date = DateTime(2024, 1, 1);
      final result = date.japaneseCalendarYear;
      expect(result, isNotNull);
      expect(result!.era, JapaneseEra.reiwa);
      expect(result.year, 6);
    });

    test('未来日付（2030-12-31）は令和12年', () {
      final date = DateTime(2030, 12, 31);
      final result = date.japaneseCalendarYear;
      expect(result, isNotNull);
      expect(result!.era, JapaneseEra.reiwa);
      expect(result.year, 12);
    });
  });

  group('JapaneseCalendarYear.adYear / toString()', () {
    test('reiwa year=6 の adYear は 2024', () {
      final jcy = JapaneseCalendarYear(era: JapaneseEra.reiwa, year: 6);
      expect(jcy.adYear, 2024);
    });

    test('reiwa year=1 の toString() は "令和1"', () {
      final jcy = JapaneseCalendarYear(era: JapaneseEra.reiwa, year: 1);
      expect(jcy.toString(), '令和1');
    });
  });
}

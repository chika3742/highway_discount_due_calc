import 'package:flutter_test/flutter_test.dart';
import 'package:highway_discount_due_calc/utils.dart';

void main() {
  group('earlierDate', () {
    test('a < b のとき a を返す', () {
      final a = DateTime(2024, 1, 1);
      final b = DateTime(2024, 6, 1);
      expect(earlierDate(a, b), a);
    });

    test('b < a のとき b を返す', () {
      final a = DateTime(2024, 6, 1);
      final b = DateTime(2024, 1, 1);
      expect(earlierDate(a, b), b);
    });

    test('a == b のとき a を返す', () {
      final a = DateTime(2024, 3, 15);
      final b = DateTime(2024, 3, 15);
      expect(earlierDate(a, b), a);
    });
  });

  group('laterDate', () {
    test('a = null のとき b を返す', () {
      final b = DateTime(2024, 6, 1);
      expect(laterDate(null, b), b);
    });

    test('b = null のとき a を返す', () {
      final a = DateTime(2024, 6, 1);
      expect(laterDate(a, null), a);
    });

    test('a > b のとき a を返す', () {
      final a = DateTime(2024, 6, 1);
      final b = DateTime(2024, 1, 1);
      expect(laterDate(a, b), a);
    });

    test('b > a のとき b を返す', () {
      final a = DateTime(2024, 1, 1);
      final b = DateTime(2024, 6, 1);
      expect(laterDate(a, b), b);
    });
  });

  group('isLeapDay', () {
    test('2024年2月29日は true', () {
      expect(DateTime(2024, 2, 29).isLeapDay, true);
    });

    test('2024年2月28日は false', () {
      expect(DateTime(2024, 2, 28).isLeapDay, false);
    });

    test('2024年3月1日は false', () {
      expect(DateTime(2024, 3, 1).isLeapDay, false);
    });

    test('2100年2月29日は false', () {
      expect(DateTime(2100, 2, 29).isLeapDay, false);
    });

    test('2400年2月29日は true', () {
      expect(DateTime(2400, 2, 29).isLeapDay, true);
    });
  });
}

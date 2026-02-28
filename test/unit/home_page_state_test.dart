import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kigenkeisann/components/expire_month_input.dart';
import 'package:kigenkeisann/core/procedure_type.dart';
import 'package:kigenkeisann/providers/home_page_notifier.dart';

import '../utils.dart';

void main() {
  group('isInputValid', () {
    test('birthDate が null のとき false', () {
      final container = createContainer();
      expect(container.read(homePageNotifierProvider).isInputValid, false);
    });

    test('birthDate あり・手帳なしのとき true', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier).setBirthDate(DateTime(2000, 1, 1));
      expect(container.read(homePageNotifierProvider).isInputValid, true);
    });

    test('birthDate あり・physicalExpire が isValid=false のとき false', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier)
        ..setBirthDate(DateTime(2000, 1, 1))
        ..setPhysicalExpire(const ExpireMonthInputData()); // date=null, noExpirationDate=false → isValid=false
      expect(container.read(homePageNotifierProvider).isInputValid, false);
    });

    test('birthDate あり・physicalExpire が noExpirationDate=true のとき true', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier)
        ..setBirthDate(DateTime(2000, 1, 1))
        ..setPhysicalExpire(const ExpireMonthInputData(noExpirationDate: true));
      expect(container.read(homePageNotifierProvider).isInputValid, true);
    });
  });

  group('isOver18YearsOld', () {
    test('isInputValid = false のとき null', () {
      final container = createContainer();
      withClock(Clock.fixed(DateTime(2024, 1, 1)), () {
        expect(container.read(homePageNotifierProvider).isAdult, null);
      });
    });

    test('18歳誕生日の翌日のとき true', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier).setBirthDate(DateTime(2000, 6, 1));
      withClock(Clock.fixed(DateTime(2018, 6, 2)), () {
        expect(container.read(homePageNotifierProvider).isAdult, true);
      });
    });

    test('18歳誕生日ちょうどのとき false（誕生日当日はまだ18歳になっていない）', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier).setBirthDate(DateTime(2000, 6, 1));
      withClock(Clock.fixed(DateTime(2018, 6, 1)), () {
        expect(container.read(homePageNotifierProvider).isAdult, false);
      });
    });

    test('17歳のとき false', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier).setBirthDate(DateTime(2000, 6, 1));
      withClock(Clock.fixed(DateTime(2017, 12, 1)), () {
        expect(container.read(homePageNotifierProvider).isAdult, false);
      });
    });
  });

  group('isTodayOver2MonthsBeforeBirthday（false ケース）', () {
    test('誕生日1ヶ月前のとき false', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier)
        ..setProcedureType(ProcedureType.update)
        ..setBirthDate(DateTime(2000, 6, 1));
      withClock(Clock.fixed(DateTime(2024, 5, 1)), () {
        expect(container.read(homePageNotifierProvider).isTodayOver2MonthsBeforeBirthday, false);
      });
    });
  });

  group('isTurns18BeforeExpirationDate（false ケース）', () {
    test('手続き時点で既に18歳超のとき false', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier)
        ..setProcedureType(ProcedureType.newAcquisition)
        ..setBirthDate(DateTime(2000, 2, 1));
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
        expect(container.read(homePageNotifierProvider).becomesAdultBeforeExpirationDate, false);
      });
    });
  });

  group('HomePageNotifier.clear()', () {
    test('setBirthDate 後に clear() で初期状態に戻る', () {
      final container = createContainer();
      container.read(homePageNotifierProvider.notifier).setBirthDate(DateTime(2000, 1, 1));
      expect(container.read(homePageNotifierProvider).birthDate, isNotNull);

      container.read(homePageNotifierProvider.notifier).clear();
      expect(container.read(homePageNotifierProvider).birthDate, null);
    });
  });
}

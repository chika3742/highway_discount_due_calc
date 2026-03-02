import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kigenkeisann/components/expire_month_input.dart';
import 'package:kigenkeisann/core/procedure_type.dart';
import 'package:kigenkeisann/providers/home_page_notifier.dart';

import '../utils.dart';

const _defaultState = HomePageState(
  procedureType: ProcedureType.update,
  birthDate: null,
  physicalExpire: null,
  rehabilitationExpire: null,
  registerVehicle: false,
  useEtc: false,
  leaseVehicle: false,
  isCertType2: false,
  isAgent: false,
);

void main() {
  group('isInputValid', () {
    test('birthDate が null のとき false', () {
      expect(_defaultState.isInputValid, false);
    });

    test('birthDate あり・手帳なしのとき true', () {
      expect(
        _defaultState.copyWith(birthDate: DateTime(2000, 1, 1)).isInputValid,
        true,
      );
    });

    test('birthDate あり・physicalExpire が isValid=false のとき false', () {
      expect(
        _defaultState.copyWith(
          birthDate: DateTime(2000, 1, 1),
          physicalExpire: const ExpireMonthInputData(), // date=null, noExpirationDate=false → isValid=false
        ).isInputValid,
        false,
      );
    });

    test('birthDate あり・physicalExpire が noExpirationDate=true のとき true', () {
      expect(
        _defaultState.copyWith(
          birthDate: DateTime(2000, 1, 1),
          physicalExpire: const ExpireMonthInputData(noExpirationDate: true),
        ).isInputValid,
        true,
      );
    });
  });

  group('isAdult', () {
    test('isInputValid = false のとき null', () {
      withClock(Clock.fixed(DateTime(2024, 1, 1)), () {
        expect(_defaultState.isAdult, null);
      });
    });

    group("2026年4月1日以前", () {
      test('18歳未満のとき false', () {
        final state = _defaultState.copyWith(birthDate: DateTime(2010, 1, 1));
        withClock(Clock.fixed(DateTime(2024, 1, 1)), () {
          expect(state.isAdult, false);
        });
      });

      test('18歳のとき true', () {
        final state = _defaultState.copyWith(birthDate: DateTime(2006, 1, 1));
        withClock(Clock.fixed(DateTime(2024, 1, 1)), () {
          expect(state.isAdult, true);
        });
      });

      test('18歳超のとき true', () {
        final state = _defaultState.copyWith(birthDate: DateTime(2000, 1, 1));
        withClock(Clock.fixed(DateTime(2024, 1, 1)), () {
          expect(state.isAdult, true);
        });
      });
    });

    group("2026年4月1日以後", () {
      test('20歳未満のとき false', () {
        final state = _defaultState.copyWith(birthDate: DateTime(2010, 1, 1));
        withClock(Clock.fixed(DateTime(2026, 4, 1)), () {
          expect(state.isAdult, false);
        });
      });

      test('20歳のとき true', () {
        final state = _defaultState.copyWith(birthDate: DateTime(2006, 4, 1));
        withClock(Clock.fixed(DateTime(2026, 4, 1)), () {
          expect(state.isAdult, true);
        });
      });

      test('20歳超のとき true', () {
        final state = _defaultState.copyWith(birthDate: DateTime(2000, 1, 1));
        withClock(Clock.fixed(DateTime(2026, 4, 1)), () {
          expect(state.isAdult, true);
        });
      });
    });
  });

  group('isTodayOver2MonthsBeforeBirthday', () {
    test('新規/変更申請であるとき、誕生日まで2ヶ月以上前でも false', () {
      final state1 = _defaultState.copyWith(
        procedureType: ProcedureType.newAcquisition,
        birthDate: DateTime(2000, 8, 1),
      );
      withClock(Clock.fixed(DateTime(2024, 5, 1)), () {
        expect(state1.isTodayOver2MonthsBeforeBirthday, false);
      });

      final state2 = _defaultState.copyWith(
        procedureType: ProcedureType.change,
        birthDate: DateTime(2000, 8, 1),
      );
      withClock(Clock.fixed(DateTime(2024, 5, 1)), () {
        expect(state2.isTodayOver2MonthsBeforeBirthday, false);
      });
    });

    test('誕生日1ヶ月前のとき false', () {
      final state = _defaultState.copyWith(birthDate: DateTime(2000, 6, 1));
      withClock(Clock.fixed(DateTime(2024, 5, 1)), () {
        expect(state.isTodayOver2MonthsBeforeBirthday, false);
      });
    });
  });

  group('becomesAdultBeforeExpirationDate', () {
    group("2026年4月1日以前", () {
      test('手続き日から期限までの間に18歳になる場合true', () {
        // 手続き日: 2026/3/31（adultAge=18）
        // 次の誕生日: 2026/4/1 → 期限: 2027/4/1
        // 18歳誕生日: 2027/3/1 → 手続き日より後かつ期限より前 → true
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2009, 3, 1),
        ); // 期限は2027年4月1日
        withClock(Clock.fixed(DateTime(2026, 3, 31)), () {
          expect(state.becomesAdultBeforeExpirationDate, true);
        });
      });

      test('成人誕生日が手続き日当日のとき false', () {
        // 手続き日: 2020/1/1（adultAge=18）
        // 次の誕生日: 2020/2/1 → 期限: 2021/2/1
        // 18歳誕生日: 2020/1/1 = 手続き日 → isAfter(now) false → false
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2002, 1, 1),
        );
        withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
          expect(state.becomesAdultBeforeExpirationDate, false);
        });
      });

      test('成人誕生日が手続き日の翌日のとき true', () {
        // 手続き日: 2019/12/31（adultAge=18）
        // 次の誕生日: 2020/2/1 → 期限: 2021/2/1
        // 18歳誕生日: 2020/1/1 → 手続き日の翌日 → true
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2002, 1, 1),
        );
        withClock(Clock.fixed(DateTime(2019, 12, 31)), () {
          expect(state.becomesAdultBeforeExpirationDate, true);
        });
      });

      test('成人となる年が期限と同年のとき false', () {
        // 手続き日: 2020/1/1（adultAge=18）
        // 次の誕生日: 2020/2/1 → 期限: 2021/2/1
        // 18歳誕生日: 2021/2/1 = 期限 → isBefore(expirationDate) false → false
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2003, 2, 1),
        );
        withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
          expect(state.becomesAdultBeforeExpirationDate, false);
        });
      });

      test('成人となる年が期限の1年前のとき true', () {
        // 手続き日: 2020/1/1（adultAge=18）
        // 次の誕生日: 2020/2/3 → 期限: 2021/2/3
        // 18歳誕生日: 2020/2/2 → 期限の1年前の同月日 → true
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2002, 2, 2),
        );
        withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
          expect(state.becomesAdultBeforeExpirationDate, true);
        });
      });
    });

    group("2026年4月1日以後", () {
      test('手続き日から期限までの間に20歳になる場合 true', () {
        // 手続き日: 2026/4/1（adultAge=20）
        // 次の誕生日: 2026/5/1 → 期限: 2027/5/1
        // 20歳誕生日: 2026/5/1 → 手続き日より後かつ期限より前 → true
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2006, 5, 1),
        );
        withClock(Clock.fixed(DateTime(2026, 4, 1)), () {
          expect(state.becomesAdultBeforeExpirationDate, true);
        });
      });

      test('成人誕生日が手続き日当日のとき false', () {
        // 手続き日: 2026/4/1（adultAge=20）
        // 20歳誕生日: 2026/4/1 = 手続き日 → isAfter(now) false → false
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2006, 4, 1),
        );
        withClock(Clock.fixed(DateTime(2026, 4, 1)), () {
          expect(state.becomesAdultBeforeExpirationDate, false);
        });
      });

      test('成人となる年が期限と同年のとき false', () {
        // 手続き日: 2026/4/1（adultAge=20）
        // 次の誕生日: 2026/5/1 → 期限: 2027/5/1
        // 20歳誕生日: 2027/5/1 = 期限 → isBefore(expirationDate) false → false
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2007, 5, 1),
        );
        withClock(Clock.fixed(DateTime(2026, 4, 1)), () {
          expect(state.becomesAdultBeforeExpirationDate, false);
        });
      });
    });

    test('isInputValid = false のとき false', () {
      // birthDate が null → isInputValid = false → false
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
        expect(_defaultState.becomesAdultBeforeExpirationDate, false);
      });
    });

    test('手続き時点で既に18歳超のとき false', () {
      final state = _defaultState.copyWith(
        procedureType: ProcedureType.newAcquisition,
        birthDate: DateTime(2000, 2, 1),
      );
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
        expect(state.becomesAdultBeforeExpirationDate, false);
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

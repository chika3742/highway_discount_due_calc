import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kigenkeisann/home.dart';
import 'package:kigenkeisann/providers/home_page_notifier.dart';

import '../utils.dart';

void main() {
  test("更新手続き時は、当日から数えて3回目の誕生日が期限", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.update)
      ..setBirthDate(DateTime(2000, 2, 1));

    withClock(
      Clock.fixed(DateTime(2020, 1, 1)),
      () {
        expect(
          container.read(homePageNotifierProvider).expirationDate,
          equals(DateTime(2022, 2, 1)),
        );
      },
    );
  });

  test("新規・変更手続き時は、当日から数えて2回目の誕生日が期限", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.newAcquisition)
      ..setBirthDate(DateTime(2000, 2, 1));

    withClock(
      Clock.fixed(DateTime(2020, 1, 1)),
      () {
        expect(
          container.read(homePageNotifierProvider).expirationDate,
          equals(DateTime(2021, 2, 1)),
        );
      },
    );
  });

  test("誕生日当日の新規・変更申請は、当日の翌日から数えて2回目の誕生日", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.newAcquisition)
      ..setBirthDate(DateTime(2000, 2, 1));

    withClock(
      Clock.fixed(DateTime(2020, 2, 1)),
      () {
        expect(
          container.read(homePageNotifierProvider).expirationDate,
          equals(DateTime(2022, 2, 1)),
        );
      },
    );
  });

  test("誕生日当日の変更申請は、2ヶ月以上前と同じ扱い", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.update)
      ..setBirthDate(DateTime(2000, 2, 1));

    withClock(
      Clock.fixed(DateTime(2020, 2, 1)),
      () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.isTodayOver2MonthsBeforeBirthday,
          equals(true),
        );
        expect(
          state.expirationDate,
          equals(DateTime(2022, 2, 1)),
        );
      },
    );
  });

  test("どちらか片方の手帳の期限がある場合、本来の期限と早い方が期限", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.newAcquisition)
      ..setBirthDate(DateTime(2000, 2, 1))
      ..setHasExpirationDate(true)
      ..setPhysicalExpDate(DateTime(2020, 8, 1));

    withClock(
      Clock.fixed(DateTime(2020, 1, 1)),
      () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.expirationDate,
          equals(DateTime(2020, 8, 1)),
        );
      },
    );

    withClock(
      Clock.fixed(DateTime(2019, 1, 1)),
      () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.expirationDate,
          equals(DateTime(2020, 2, 1)),
        );
      },
    );
  });

  test("両方の手帳の期限がある場合、2つの手帳の期限で遅い方と、本来の期限で早い方が期限", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.newAcquisition)
      ..setBirthDate(DateTime(2000, 2, 1))
      ..setHasExpirationDate(true)
      ..setPhysicalExpDate(DateTime(2020, 8, 1))
      ..setRehabilitationExpDate(DateTime(2020, 12, 1));

    withClock(
      Clock.fixed(DateTime(2020, 1, 1)),
      () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.expirationDate,
          equals(DateTime(2020, 12, 1)),
        );
      },
    );

    withClock(
      Clock.fixed(DateTime(2019, 1, 1)),
      () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.expirationDate,
          equals(DateTime(2020, 2, 1)),
        );
      },
    );
  });

  test("更新手続き時、手続き日が期限の2ヶ月以上前である場合、手続き日から数えて2回目の誕生日が期限", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.update)
      ..setBirthDate(DateTime(2000, 2, 1));

    withClock(
      Clock.fixed(DateTime(2020, 8, 1)),
          () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.isTodayOver2MonthsBeforeBirthday,
          true,
        );
        expect(
          state.expirationDate,
          equals(DateTime(2022, 2, 1)),
        );
      },
    );
  });

  test("手続き日から期限までの間に18歳になる場合、isTurns18BeforeExpirationDateがtrue", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.newAcquisition)
      ..setBirthDate(DateTime(2000, 2, 1));

    withClock(
      Clock.fixed(DateTime(2017, 8, 1)),
          () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.isTurns18BeforeExpirationDate,
          true,
        );
      },
    );
  });

  test("誕生日が閏日の場合の処理", () {
    final container = createContainer();

    container.read(homePageNotifierProvider.notifier)
      ..setProcedureType(ProcedureType.newAcquisition)
      ..setBirthDate(DateTime(2004, 2, 29));

    withClock(
      Clock.fixed(DateTime(2024, 3, 1)),
          () {
        var state = container.read(homePageNotifierProvider);
        expect(
          state.expirationDate,
          equals(DateTime(2026, 2, 28)),
        );
      },
    );
  });
}

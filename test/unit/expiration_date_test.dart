import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:highway_discount_due_calc/components/expire_month_input.dart';
import 'package:highway_discount_due_calc/core/expiration_date_calculator.dart';
import 'package:highway_discount_due_calc/core/procedure_type.dart';

void main() {
  test("更新手続き時は、当日から数えて3回目の誕生日が期限", () {
    withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.update, DateTime(2000, 2, 1), null, null),
        equals(DateTime(2022, 2, 1)),
      );
    });
  });

  test("新規・変更手続き時は、当日から数えて2回目の誕生日が期限", () {
    withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.newAcquisition, DateTime(2000, 2, 1), null, null),
        equals(DateTime(2021, 2, 1)),
      );
    });
  });

  test("誕生日当日の新規・変更申請は、当日の翌日から数えて2回目の誕生日", () {
    withClock(Clock.fixed(DateTime(2020, 2, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.newAcquisition, DateTime(2000, 2, 1), null, null),
        equals(DateTime(2022, 2, 1)),
      );
    });
  });

  test("誕生日当日の更新申請は、2ヶ月以上前と同じ扱い", () {
    withClock(Clock.fixed(DateTime(2020, 2, 1, 0, 0)), () {
      expect(
        calculateExpirationDate(ProcedureType.update, DateTime(2000, 2, 1), null, null),
        equals(DateTime(2022, 2, 1)),
      );
    });

    withClock(Clock.fixed(DateTime(2020, 2, 1, 7, 30)), () {
      expect(
        calculateExpirationDate(ProcedureType.update, DateTime(2000, 2, 1), null, null),
        equals(DateTime(2022, 2, 1)),
      );
    });
  });

  test("更新手続き時、手続き日が誕生日の1ヶ月前である場合、手続き日から数えて3回目の誕生日が期限", () {
    withClock(Clock.fixed(DateTime(2024, 5, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.update, DateTime(2000, 6, 1), null, null),
        equals(DateTime(2027, 6, 1)),
      );
    });
  });

  test("更新手続き時、手続き日が期限の2ヶ月以上前である場合、手続き日から数えて2回目の誕生日が期限", () {
    withClock(Clock.fixed(DateTime(2020, 8, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.update, DateTime(2000, 2, 1), null, null),
        equals(DateTime(2022, 2, 1)),
      );
    });
  });

  test("どちらか片方の手帳を所持していて期限がある場合、本来の期限と比較して早い方が期限", () {
    final physicalExpire = ExpireMonthInputData(date: DateTime(2020, 8, 1));

    withClock(Clock.fixed(DateTime(2019, 1, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.newAcquisition, DateTime(2000, 2, 1), physicalExpire, null),
        equals(DateTime(2020, 2, 1)),
      );
    });

    withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.newAcquisition, DateTime(2000, 2, 1), physicalExpire, null),
        equals(DateTime(2020, 8, 1)),
      );
    });
  });

  test("両方の手帳の期限がある場合、2つの手帳の期限で遅い方と、本来の期限と比較して早い方が期限", () {
    final physicalExpire = ExpireMonthInputData(date: DateTime(2020, 8, 1));
    final rehabilitationExpire = ExpireMonthInputData(date: DateTime(2020, 12, 1));

    withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.newAcquisition, DateTime(2000, 2, 1), physicalExpire, rehabilitationExpire),
        equals(DateTime(2020, 12, 1)),
      );
    });

    withClock(Clock.fixed(DateTime(2019, 1, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.newAcquisition, DateTime(2000, 2, 1), physicalExpire, rehabilitationExpire),
        equals(DateTime(2020, 2, 1)),
      );
    });
  });

  test("両方の手帳を所持していて、1個以上の手帳が無期限の場合、通常の期限と同じ", () {
    withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
      expect(
        calculateExpirationDate(
          ProcedureType.newAcquisition,
          DateTime(2000, 2, 1),
          ExpireMonthInputData(date: DateTime(2020, 8, 1)),
          const ExpireMonthInputData(noExpirationDate: true),
        ),
        equals(DateTime(2021, 2, 1)),
      );

      expect(
        calculateExpirationDate(
          ProcedureType.newAcquisition,
          DateTime(2000, 2, 1),
          const ExpireMonthInputData(noExpirationDate: true),
          ExpireMonthInputData(date: DateTime(2020, 12, 1)),
        ),
        equals(DateTime(2021, 2, 1)),
      );

      expect(
        calculateExpirationDate(
          ProcedureType.newAcquisition,
          DateTime(2000, 2, 1),
          const ExpireMonthInputData(noExpirationDate: true),
          const ExpireMonthInputData(noExpirationDate: true),
        ),
        equals(DateTime(2021, 2, 1)),
      );
    });
  });

  test("誕生日が閏日の場合の処理", () {
    withClock(Clock.fixed(DateTime(2024, 3, 1)), () {
      expect(
        calculateExpirationDate(ProcedureType.newAcquisition, DateTime(2004, 2, 29), null, null),
        equals(DateTime(2026, 2, 28)),
      );
    });
  });
}

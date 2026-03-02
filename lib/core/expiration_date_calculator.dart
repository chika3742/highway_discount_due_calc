import 'package:clock/clock.dart';

import '../components/expire_month_input.dart';
import '../utils.dart';
import 'procedure_type.dart';

int get adultAge {
  final now = clock.now();
  return !now.isBefore(DateTime(2026, 4, 1)) ? 20 : 18;
}

DateTime? calculateExpirationDate(
  ProcedureType procedureType,
  DateTime birthDate,
  ExpireMonthInputData? physicalExpire,
  ExpireMonthInputData? rehabilitationExpire,
) {
  if (physicalExpire?.isValid == false ||
      rehabilitationExpire?.isValid == false) {
    return null;
  }

  final now = clock.now();

  var result = DateTime(
    now.year,
    birthDate.month,
    birthDate.day,
  );
  // 過去の日付になっている場合は、次の年に設定
  if (!result.isAfter(now)) {
    result = Clock.fixed(result).yearsFromNow(1);
  }

  // result: 次の誕生日
  result = Clock.fixed(result).yearsFromNow(
    procedureType.birthdaysBeforeExpirationDate - 1,
  );
  // result: 本来の有効期限日
  // 手続き日が誕生日より２ヶ月以上前である場合は、手続き日から2回目の誕生日
  if (procedureType == ProcedureType.update
      && isMoreThanTwoMonthsAhead(birthDate.month, birthDate.day)) {
    result = Clock.fixed(result).yearsFromNow(-1);
  }

  if ((physicalExpire != null || rehabilitationExpire != null)
      && physicalExpire?.noExpirationDate != true && rehabilitationExpire?.noExpirationDate != true) {
    result = earlierDate(
      result,
      laterDate(
        physicalExpire?.date,
        rehabilitationExpire?.date,
      ),
    );
  }

  return result;
}

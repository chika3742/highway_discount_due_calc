import 'package:clock/clock.dart';
import 'package:kigenkeisann/home.dart';

import '../components/expire_month_input.dart';
import '../utils.dart';

DateTime? calculateExpirationDate(
  ProcedureType procedureType,
  DateTime birthDate,
  ExpireMonthInputData? physicalExpire,
  ExpireMonthInputData? rehabilitationExpire,
) {
  if (physicalExpire?.isValid != false ||
      rehabilitationExpire?.isValid != false) {
    return null;
  }

  final now = clock.now();

  var result = DateTime(
    now.year,
    birthDate.month,
    birthDate.day,
  );
  if (result.isBeforeOrAtSameMomentAs(now)) {
    result = Clock.fixed(result).yearsFromNow(1);
  }

  // result: 次の誕生日
  result = Clock.fixed(result).yearsFromNow(
    procedureType.birthdaysBeforeExpirationDate - 1,
  );
  // result: 本来の有効期限日
  // 手続き日が誕生日より２ヶ月以上前である場合は、手続き日から2回目の誕生日
  if (procedureType == ProcedureType.update
      && _isTodayOver2MonthsBefore(birthDate)) {
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

bool _isTodayOver2MonthsBefore(DateTime dateTime) {
  final now = clock.now();

  var result = DateTime(
    now.year,
    dateTime.month,
    dateTime.day,
  );
  if (result.isBeforeOrAtSameMomentAs(now)) {
    result = result.copyWith(year: result.year + 1);
  }
  result = result.copyWith(month: result.month - 2);
  return now.isBefore(result);
}

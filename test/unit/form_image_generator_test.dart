import "package:clock/clock.dart";
import "package:flutter_test/flutter_test.dart";
import "package:highway_discount_due_calc/components/expire_month_input.dart";
import "package:highway_discount_due_calc/core/form_image_generator.dart";
import "package:highway_discount_due_calc/core/procedure_type.dart";
import "package:highway_discount_due_calc/providers/home_page_notifier.dart";

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

/// `testId` で装飾を引くヘルパー。インデックスに依存せず参照できる。
FormDecoration _byId(String testId) =>
    FormImageGenerator.decorations.firstWhere((d) => d.testId == testId);

void main() {
  // アセット読み込みと Picture.toImage のために必要。
  TestWidgetsFlutterBinding.ensureInitialized();

  group("decorations drawIf", () {
    test("全装飾の testId は一意である", () {
      final ids = FormImageGenerator.decorations.map((d) => d.testId).toList();
      expect(ids.toSet().length, ids.length);
    });

    test("primaryOutline / expirationOutline は状態に関わらず常に true", () {
      final fullyEnabled = _defaultState.copyWith(
        birthDate: DateTime(2000, 1, 1),
        registerVehicle: true,
        useEtc: true,
        isAgent: true,
        isCertType2: true,
      );
      for (final state in [_defaultState, fullyEnabled]) {
        expect(_byId("primaryOutline").drawIf(state), true);
        expect(_byId("expirationOutline").drawIf(state), true);
      }
    });

    test("vehicleOutline は registerVehicle に従う", () {
      expect(_byId("vehicleOutline").drawIf(_defaultState), false);
      expect(
        _byId("vehicleOutline").drawIf(_defaultState.copyWith(registerVehicle: true)),
        true,
      );
    });

    test("etcOutline / etcExpirationOutline は registerVehicle && useEtc のとき true", () {
      expect(_byId("etcOutline").drawIf(_defaultState), false);
      // useEtc だけでは描かない
      expect(
        _byId("etcOutline").drawIf(_defaultState.copyWith(useEtc: true)),
        false,
      );
      final both = _defaultState.copyWith(registerVehicle: true, useEtc: true);
      expect(_byId("etcOutline").drawIf(both), true);
      expect(_byId("etcExpirationOutline").drawIf(both), true);
    });

    test("agentOutline は isAgent に従う", () {
      expect(_byId("agentOutline").drawIf(_defaultState), false);
      expect(
        _byId("agentOutline").drawIf(_defaultState.copyWith(isAgent: true)),
        true,
      );
    });

    test("certType1Checkmark は !isCertType2、certType2Checkmark は isCertType2", () {
      expect(_byId("certType1Checkmark").drawIf(_defaultState), true);
      expect(_byId("certType2Checkmark").drawIf(_defaultState), false);

      final type2 = _defaultState.copyWith(isCertType2: true);
      expect(_byId("certType1Checkmark").drawIf(type2), false);
      expect(_byId("certType2Checkmark").drawIf(type2), true);
    });

    test("noEtcCheckmark は registerVehicle && !useEtc のとき true", () {
      expect(_byId("noEtcCheckmark").drawIf(_defaultState), false);
      expect(
        _byId("noEtcCheckmark").drawIf(_defaultState.copyWith(registerVehicle: true)),
        true,
      );
      expect(
        _byId("noEtcCheckmark")
            .drawIf(_defaultState.copyWith(registerVehicle: true, useEtc: true)),
        false,
      );
    });

    test("noVehicleCheckmark は !registerVehicle のとき true", () {
      expect(_byId("noVehicleCheckmark").drawIf(_defaultState), true);
      expect(
        _byId("noVehicleCheckmark").drawIf(_defaultState.copyWith(registerVehicle: true)),
        false,
      );
    });

    group("certExpirationCheckmark", () {
      final decoration = _byId("certExpirationCheckmark");

      test("手帳の入力が両方 null のとき false", () {
        expect(decoration.drawIf(_defaultState), false);
      });

      test("physicalExpire に期限日があるとき true", () {
        final state = _defaultState.copyWith(
          physicalExpire: ExpireMonthInputData(date: DateTime(2020, 8, 1)),
        );
        expect(decoration.drawIf(state), true);
      });

      test("physicalExpire のみ無期限（rehab null）のとき true", () {
        final state = _defaultState.copyWith(
          physicalExpire: const ExpireMonthInputData(noExpirationDate: true),
        );
        expect(decoration.drawIf(state), true);
      });

      test("rehabilitationExpire に期限日があるとき true", () {
        final state = _defaultState.copyWith(
          rehabilitationExpire: ExpireMonthInputData(date: DateTime(2020, 8, 1)),
        );
        expect(decoration.drawIf(state), true);
      });

      test("rehabilitationExpire のみ無期限（physical null）のとき true", () {
        final state = _defaultState.copyWith(
          rehabilitationExpire: const ExpireMonthInputData(noExpirationDate: true),
        );
        expect(decoration.drawIf(state), true);
      });

      test("両方とも無期限のとき false", () {
        final state = _defaultState.copyWith(
          physicalExpire: const ExpireMonthInputData(noExpirationDate: true),
          rehabilitationExpire: const ExpireMonthInputData(noExpirationDate: true),
        );
        expect(decoration.drawIf(state), false);
      });
    });

    group("dueToExpirationText", () {
      final decoration = _byId("dueToExpirationText");

      test("入力が無効で isDueToExpiration が null のとき false", () {
        expect(decoration.drawIf(_defaultState), false);
      });

      test("手帳の期限が本来の期限より早く isDueToExpiration が true のとき true", () {
        // 手続き日 2020/1/1・新規・誕生日 2000/2/1 → 本来の期限 2021/2/1。
        // physicalExpire 2020/8/1 が早いため isDueToExpiration = true。
        final state = _defaultState.copyWith(
          procedureType: ProcedureType.newAcquisition,
          birthDate: DateTime(2000, 2, 1),
          physicalExpire: ExpireMonthInputData(date: DateTime(2020, 8, 1)),
        );
        withClock(Clock.fixed(DateTime(2020, 1, 1)), () {
          expect(state.isDueToExpiration, true);
          expect(decoration.drawIf(state), true);
        });
      });
    });
  });

  group("generate()", () {
    test("デフォルト状態で 2400x3437 の画像を返す", () async {
      final image = await FormImageGenerator(state: _defaultState).generate();
      addTearDown(image.dispose);
      expect(image.width, 2400);
      expect(image.height, 3437);
    });

    test("全装飾が描かれる状態でも例外なく 2400x3437 を返す", () async {
      // すべての枠線・チェックマーク・テキストの分岐を通す状態。
      final state = _defaultState.copyWith(
        procedureType: ProcedureType.newAcquisition,
        birthDate: DateTime(2000, 2, 1),
        physicalExpire: ExpireMonthInputData(date: DateTime(2020, 8, 1)),
        registerVehicle: true,
        useEtc: true,
        isAgent: true,
        isCertType2: true,
      );
      await withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        // テキスト装飾の分岐も通ることを確認。
        expect(_byId("dueToExpirationText").drawIf(state), true);
        final image = await FormImageGenerator(state: state).generate();
        addTearDown(image.dispose);
        expect(image.width, 2400);
        expect(image.height, 3437);
      });
    });
  });
}

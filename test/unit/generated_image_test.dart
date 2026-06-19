import "dart:ui";

import "package:flutter_test/flutter_test.dart";
import "package:highway_discount_due_calc/providers/generated_image.dart";
import "package:highway_discount_due_calc/providers/home_page_notifier.dart";

import "../utils.dart";

void main() {
  // generate() がアセットを読み込むために必要。
  TestWidgetsFlutterBinding.ensureInitialized();

  group("generatedImageProvider", () {
    test("描画内容が変わる状態変更では画像が再生成される", () async {
      final container = createContainer();
      // autoDispose provider を生かし、内部の ref.listen を有効に保つ。
      container.listen(generatedImageProvider, (_, __) {});
      final Image first = await container.read(generatedImageProvider.future);
      addTearDown(first.dispose);

      // registerVehicle は複数の装飾の drawIf に影響する → 再生成されるべき。
      container.read(homePageProvider.notifier).setRegisterVehicle(true);
      final Image second = await container.read(generatedImageProvider.future);
      addTearDown(second.dispose);

      expect(identical(first, second), false);
    });

    test("描画内容が変わらない状態変更では再生成されない", () async {
      final container = createContainer();
      // autoDispose provider を生かし、内部の ref.listen を有効に保つ。
      container.listen(generatedImageProvider, (_, __) {});
      final Image first = await container.read(generatedImageProvider.future);
      addTearDown(first.dispose);

      // leaseVehicle はどの装飾の drawIf でも参照されない → 再生成されないべき。
      container.read(homePageProvider.notifier).setLeaseVehicle(true);
      final Image second = await container.read(generatedImageProvider.future);
      // first と同一インスタンスを返すことが本テストの期待。dispose 重複を避けるため addTearDown は first のみ。

      expect(identical(first, second), true);
    });
  });
}

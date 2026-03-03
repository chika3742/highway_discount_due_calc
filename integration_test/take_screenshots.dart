import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kigenkeisann/main.dart' as app;

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  const ssNameBase = String.fromEnvironment("SCREENSHOT_NAME_BASE");

  testWidgets("take screenshots", (tester) async {
    app.main();

    if (Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
    }

    await tester.pumpAndSettle();

    await tester.tap(find.text("新規"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("元号"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("平成"));
    await tester.pumpAndSettle();

    await tester.enterText(find.ancestor(
      of: find.text("年").at(0),
      matching: find.byType(TextField),
    ), "15");
    await tester.pump(const Duration(milliseconds: 100));

    await tester.tap(find.text("月").at(0));
    await tester.pumpAndSettle();
    await tester.tap(find.text("1月"));
    await tester.pumpAndSettle();

    await tester.enterText(find.ancestor(
      of: find.text("日").at(0),
      matching: find.byType(TextField),
    ), "1");
    await tester.pump(const Duration(milliseconds: 100));

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(const Duration(seconds: 1));

    await binding.takeScreenshot("${ssNameBase}_1");

    await tester.scrollUntilVisible(find.text("手帳"), 10, scrollable: find.byType(Scrollable).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text("2種"));
    await tester.pumpAndSettle();
    await tester.tap(find.text("あり").at(0));
    await tester.pumpAndSettle();
    await tester.tap(find.text("あり").at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.text("あり").at(2));
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(find.text("申請者"), find.byType(SingleChildScrollView), const Offset(0, -100));
    await tester.pumpAndSettle();

    await binding.takeScreenshot("${ssNameBase}_2");
  });
}

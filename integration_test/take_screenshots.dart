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

    await tester.pump(const Duration(seconds: 5));

    await tester.tap(find.text("新規・変更"));
    await pump100ms(tester);

    await tester.tap(find.text("元号"));
    await pump100ms(tester);
    await tester.tap(find.text("平成"));
    await pump100ms(tester);

    await tester.enterText(find.byType(TextFormField).at(0), "15");
    await pump100ms(tester);

    await tester.tap(find.text("月").first);
    await pump100ms(tester);
    await tester.tap(find.text("1月"));
    await pump100ms(tester);

    await tester.enterText(find.byType(TextFormField).at(1), "1");
    await pump100ms(tester);

    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(const Duration(seconds: 1));

    await binding.takeScreenshot("${ssNameBase}_1");

    await tester.tap(find.text("2種"));
    await pump100ms(tester);
    await tester.tap(find.text("あり").at(1));
    await pump100ms(tester);
    await tester.dragUntilVisible(find.text("必要書類"), find.byType(SingleChildScrollView), const Offset(0, -100));
    await pump100ms(tester);
    await tester.tap(find.text("あり").at(2));
    await pump100ms(tester);
    await tester.tap(find.text("あり").at(3));
    await pump100ms(tester);

    await tester.dragUntilVisible(find.text("必要書類"), find.byType(SingleChildScrollView), const Offset(0, -100));
    await pump100ms(tester);

    await binding.takeScreenshot("${ssNameBase}_2");
  });
}

Future<void> pump100ms(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 100));
}

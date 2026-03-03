import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:integration_test/integration_test_driver_extended.dart';

void main() async {
  try {
    await integrationDriver(
      onScreenshot: (
        String screenshotName,
        List<int> screenshotBytes, [
        Map<String, Object?>? args,
      ]) async {
        final cmd = img.Command()
          ..decodePng(Uint8List.fromList(screenshotBytes))
          ..convert(numChannels: 3)
          ..writeToFile('$screenshotName.png');
        await cmd.execute();
        return true;
      },
    );
  } catch (e) {
    // ignore: avoid_print
    print("Error occurred: $e");
  }
}

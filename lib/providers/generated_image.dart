import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kigenkeisann/core/form_image_generator.dart';
import 'package:kigenkeisann/providers/home_page_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated_image.g.dart';

@riverpod
Future<Uint8List> generatedImage(Ref ref) async {
  ref.listen(homePageNotifierProvider, (previous, next) {
    if (previous == null) return;

    final shouldInvalidate = FormImageGenerator.decorations.any((decoration) {
      return decoration.drawIf(previous) != decoration.drawIf(next);
    });
    if (shouldInvalidate) {
      ref.invalidateSelf();
    }
  });
  final homePageState = ref.read(homePageNotifierProvider);
  return await FormImageGenerator(state: homePageState).generate();
}

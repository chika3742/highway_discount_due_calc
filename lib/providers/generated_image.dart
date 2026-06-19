import 'dart:ui';

import 'package:highway_discount_due_calc/core/form_image_generator.dart';
import 'package:highway_discount_due_calc/providers/home_page_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated_image.g.dart';

@riverpod
Future<Image> generatedImage(Ref ref) async {
  ref.listen(homePageProvider, (previous, next) {
    if (previous == null) return;

    final shouldInvalidate = FormImageGenerator.decorations.any((decoration) {
      return decoration.drawIf(previous) != decoration.drawIf(next);
    });
    if (shouldInvalidate) {
      ref.invalidateSelf();
    }
  });
  final homePageState = ref.read(homePageProvider);
  return await FormImageGenerator(state: homePageState).generate();
}

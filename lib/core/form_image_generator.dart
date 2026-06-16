import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

import '../providers/home_page_notifier.dart';

class FormImageGenerator {
  static final List<FormDecoration> decorations = [
    FormDecoration( // primary form outline
      drawIf: (state) => true, // always
      type: FormDecorationType.outline,
      p1: const Offset(181, 354),
      p2: const Offset(2255, 1108),
      color: Colors.red,
    ),
    FormDecoration( // vehicle registration form outline
      drawIf: (state) => state.registerVehicle,
      type: FormDecorationType.outline,
      p1: const Offset(185, 1354),
      p2: const Offset(2255, 1512),
      color: Colors.red,
    ),
    FormDecoration( // ETC registration form outline
      drawIf: (state) => state.registerVehicle && state.useEtc,
      type: FormDecorationType.outline,
      p1: const Offset(186, 1713),
      p2: const Offset(2257, 2191),
      color: Colors.red,
    ),
    FormDecoration( // agent form outline
      drawIf: (state) => state.isAgent,
      type: FormDecorationType.outline,
      p1: const Offset(185, 2246),
      p2: const Offset(2255, 2413),
      color: Colors.red,
    ),
    FormDecoration( // certificate type 1 checkmark
      drawIf: (state) => !state.isCertType2,
      type: FormDecorationType.checkmark,
      p1: const Offset(803, 1189),
      color: Colors.blueAccent,
    ),
    FormDecoration( // certificate type 2 checkmark
      drawIf: (state) => state.isCertType2,
      type: FormDecorationType.checkmark,
      p1: const Offset(803, 1153),
      color: Colors.blueAccent,
    ),
    FormDecoration( // no ETC checkmark
      drawIf: (state) => state.registerVehicle && !state.useEtc,
      type: FormDecorationType.checkmark,
      p1: const Offset(570, 1557),
      color: Colors.red,
    ),
    FormDecoration( // no vehicle registration checkmark
      drawIf: (state) => !state.registerVehicle,
      type: FormDecorationType.checkmark,
      p1: const Offset(585, 1259),
      color: Colors.red,
    ),
    FormDecoration( // has certificate expiration date checkmark
      drawIf: (state) => (state.physicalExpire != null || state.rehabilitationExpire != null)
          && state.physicalExpire?.noExpirationDate != true && state.rehabilitationExpire?.noExpirationDate != true,
      type: FormDecorationType.checkmark,
      p1: const Offset(1460, 2520),
      color: Colors.blue,
    ),
    FormDecoration( // ETC expiration date form outline
      drawIf: (state) => state.registerVehicle && state.useEtc,
      type: FormDecorationType.outline,
      p1: const Offset(187, 2471),
      p2: const Offset(1152, 2556),
      color: Colors.blue,
    ),
    FormDecoration( // expiration date form outline
      drawIf: (state) => true,
      type: FormDecorationType.outline,
      p1: const Offset(187, 2555),
      p2: const Offset(2255, 2639),
      color: Colors.blue,
    ),
  ];

  FormImageGenerator({required this.state});

  final HomePageState state;

  Canvas? _canvas;

  Future<Image> generate() async {
    final buffer = await ImmutableBuffer.fromAsset("assets/img/form_base.jpg");
    final descriptor = await ImageDescriptor.encoded(buffer);
    final codec = await descriptor.instantiateCodec();
    final image = (await codec.getNextFrame()).image;

    final recorder = PictureRecorder();
    _canvas = Canvas(recorder);
    _canvas!.drawImage(image, Offset.zero, Paint());

    for (final decoration in decorations) {
      if (decoration.drawIf(state)) {
        switch (decoration.type) {
          case FormDecorationType.outline:
            _drawFormOutline(decoration.p1, decoration.p2!, decoration.color);
            break;
          case FormDecorationType.checkmark:
            _drawCheckmark(decoration.p1, decoration.color);
            break;
        }
      }
    }

    _canvas = null;

    final picture = recorder.endRecording();
    return await picture.toImage(2400, 3437);
  }

  void _drawFormOutline(Offset p1, Offset p2, Color color) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..color = color;

    _canvas?.drawRect(
      Rect.fromPoints(p1, p2),
      paint,
    );
  }

  void _drawCheckmark(Offset offset, Color color) {
    final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 20;

    const markSize = 70;

    final path = Path()
      ..moveTo(offset.dx - markSize * 0.25, offset.dy - markSize * 0.35)
      ..lineTo(offset.dx, offset.dy)
      ..relativeLineTo(markSize * 0.65, -markSize * 0.55);

    _canvas?.drawPath(path, paint);
  }
}

class FormDecoration {
  final bool Function(HomePageState state) drawIf;
  final FormDecorationType type;
  final Offset p1;
  final Offset? p2;
  final Color color;

  const FormDecoration({
    required this.drawIf,
    required this.type,
    required this.p1,
    this.p2,
    required this.color,
  });
}

enum FormDecorationType {
  outline,
  checkmark,
}

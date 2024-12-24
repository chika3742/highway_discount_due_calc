import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../providers/home_page_notifier.dart';

class FormImageGenerator {
  static final List<FormDecoration> decorations = [
    FormDecoration( // primary form outline
      drawIf: (state) => true, // always
      type: FormDecorationType.outline,
      p1: const Offset(92, 108),
      p2: const Offset(503, 257),
      color: Colors.red,
    ),
    FormDecoration( // vehicle registration form outline
      drawIf: (state) => state.registerVehicle,
      type: FormDecorationType.outline,
      p1: const Offset(91.5, 305.5),
      p2: const Offset(503.5, 336.5),
      color: Colors.red,
    ),
    FormDecoration( // ETC registration form outline
      drawIf: (state) => state.registerVehicle && state.useEtc,
      type: FormDecorationType.outline,
      p1: const Offset(91.5, 377.5),
      p2: const Offset(503.5, 471.5),
      color: Colors.red,
    ),
    FormDecoration( // agent form outline
      drawIf: (state) => state.isAgent,
      type: FormDecorationType.outline,
      p1: const Offset(91.5, 482.5),
      p2: const Offset(503.5, 515.5),
      color: Colors.red,
    ),
    FormDecoration( // certificate type 1 checkmark
      drawIf: (state) => !state.isCertType2,
      type: FormDecorationType.checkmark,
      p1: const Offset(215, 274),
      color: Colors.blue,
    ),
    FormDecoration( // certificate type 2 checkmark
      drawIf: (state) => state.isCertType2,
      type: FormDecorationType.checkmark,
      p1: const Offset(215, 267.5),
      color: Colors.blue,
    ),
    FormDecoration( // no ETC checkmark
      drawIf: (state) => state.registerVehicle && !state.useEtc,
      type: FormDecorationType.checkmark,
      p1: const Offset(168, 348),
      color: Colors.red,
    ),
    FormDecoration( // no vehicle registration checkmark
      drawIf: (state) => !state.registerVehicle,
      type: FormDecorationType.checkmark,
      p1: const Offset(172, 288),
      color: Colors.red,
    ),
    FormDecoration( // has certificate expiration date checkmark
      drawIf: (state) => state.physicalExpire?.noExpirationDate == true
          || state.rehabilitationExpire?.noExpirationDate == true,
      type: FormDecorationType.checkmark,
      p1: const Offset(345, 538.5),
      color: Colors.blue,
    ),
    FormDecoration( // ETC expiration date form outline
      drawIf: (state) => state.registerVehicle && state.useEtc,
      type: FormDecorationType.outline,
      p1: const Offset(91.5, 527.5),
      p2: const Offset(284.5, 544.5),
      color: Colors.blue,
    ),
    FormDecoration( // expiration date form outline
      drawIf: (state) => true,
      type: FormDecorationType.outline,
      p1: const Offset(91.5, 544.5),
      p2: const Offset(503.5, 561),
      color: Colors.blue,
    ),
  ];

  FormImageGenerator({required this.state});

  final HomePageState state;

  Canvas? _canvas;

  Future<Uint8List> generate() async {
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
    final generatedImage = await picture.toImage(595, 841);

    return (await generatedImage.toByteData(format: ImageByteFormat.png))!
        .buffer.asUint8List();
  }

  _drawFormOutline(Offset p1, Offset p2, Color color) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..color = color;

    _canvas?.drawRect(
      Rect.fromPoints(p1, p2),
      paint,
    );
  }

  _drawCheckmark(Offset offset, Color color) {
    final paint = Paint()
        ..color = color
        ..strokeWidth = 3;

    _canvas?.drawLine(offset, offset.translate(-4, -6), paint);
    _canvas?.drawLine(offset, offset.translate(8, -10), paint);
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

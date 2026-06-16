import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiImageProvider extends ImageProvider<UiImageProvider> {
  const UiImageProvider(this.image, {this.scale = 1.0});

  final ui.Image image;
  final double scale;

  @override
  Future<UiImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<UiImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
      UiImageProvider key,
      ImageDecoderCallback decode,
  ) {
    return OneFrameImageStreamCompleter(
      SynchronousFuture<ImageInfo>(
        ImageInfo(image: image.clone(), scale: scale),
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      other is UiImageProvider &&
          other.image.isCloneOf(image) &&
          other.scale == scale;

  @override
  int get hashCode => Object.hash(image, scale);
}

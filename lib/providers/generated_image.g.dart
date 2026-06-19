// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generated_image.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(generatedImage)
final generatedImageProvider = GeneratedImageProvider._();

final class GeneratedImageProvider
    extends $FunctionalProvider<AsyncValue<Image>, Image, FutureOr<Image>>
    with $FutureModifier<Image>, $FutureProvider<Image> {
  GeneratedImageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'generatedImageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$generatedImageHash();

  @$internal
  @override
  $FutureProviderElement<Image> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Image> create(Ref ref) {
    return generatedImage(ref);
  }
}

String _$generatedImageHash() => r'564a7ecf59929b85034ef4918cfd110fff022464';

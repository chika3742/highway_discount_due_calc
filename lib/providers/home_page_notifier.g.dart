// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomePageNotifier)
final homePageProvider = HomePageNotifierProvider._();

final class HomePageNotifierProvider
    extends $NotifierProvider<HomePageNotifier, HomePageState> {
  HomePageNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'homePageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$homePageNotifierHash();

  @$internal
  @override
  HomePageNotifier create() => HomePageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomePageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomePageState>(value),
    );
  }
}

String _$homePageNotifierHash() => r'81e18861f8f683dc8dd96e0c17970526969bdcb1';

abstract class _$HomePageNotifier extends $Notifier<HomePageState> {
  HomePageState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<HomePageState, HomePageState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<HomePageState, HomePageState>,
        HomePageState,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}

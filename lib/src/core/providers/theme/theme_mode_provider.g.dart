// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_mode_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controls the app's [ThemeMode].
///
/// Defaults to [ThemeMode.system] so the app follows the device's
/// light/dark setting out of the box. Exposed as a controller so a
/// settings screen can later override it to light/dark/system explicitly.

@ProviderFor(ThemeModeController)
final themeModeControllerProvider = ThemeModeControllerProvider._();

/// Controls the app's [ThemeMode].
///
/// Defaults to [ThemeMode.system] so the app follows the device's
/// light/dark setting out of the box. Exposed as a controller so a
/// settings screen can later override it to light/dark/system explicitly.
final class ThemeModeControllerProvider
    extends $NotifierProvider<ThemeModeController, ThemeMode> {
  /// Controls the app's [ThemeMode].
  ///
  /// Defaults to [ThemeMode.system] so the app follows the device's
  /// light/dark setting out of the box. Exposed as a controller so a
  /// settings screen can later override it to light/dark/system explicitly.
  ThemeModeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeControllerHash();

  @$internal
  @override
  ThemeModeController create() => ThemeModeController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeModeControllerHash() =>
    r'ee72799fe1ee5b7413848d01e7575694ef722480';

/// Controls the app's [ThemeMode].
///
/// Defaults to [ThemeMode.system] so the app follows the device's
/// light/dark setting out of the box. Exposed as a controller so a
/// settings screen can later override it to light/dark/system explicitly.

abstract class _$ThemeModeController extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

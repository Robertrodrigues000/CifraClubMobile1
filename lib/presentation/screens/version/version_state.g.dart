// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionStateCWProxy {
  VersionState version(VersionData? version);

  VersionState isLoading(bool isLoading);

  VersionState error(RequestError? error);

  VersionState sections(List<Section> sections);

  VersionState isChordListPinned(bool isChordListPinned);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionState call({
    VersionData? version,
    bool? isLoading,
    RequestError? error,
    List<Section>? sections,
    bool? isChordListPinned,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersionState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersionState.copyWith.fieldName(...)`
class _$VersionStateCWProxyImpl implements _$VersionStateCWProxy {
  const _$VersionStateCWProxyImpl(this._value);

  final VersionState _value;

  @override
  VersionState version(VersionData? version) => this(version: version);

  @override
  VersionState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  VersionState error(RequestError? error) => this(error: error);

  @override
  VersionState sections(List<Section> sections) => this(sections: sections);

  @override
  VersionState isChordListPinned(bool isChordListPinned) => this(isChordListPinned: isChordListPinned);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionState call({
    Object? version = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? sections = const $CopyWithPlaceholder(),
    Object? isChordListPinned = const $CopyWithPlaceholder(),
  }) {
    return VersionState(
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as VersionData?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      sections: sections == const $CopyWithPlaceholder() || sections == null
          ? _value.sections
          // ignore: cast_nullable_to_non_nullable
          : sections as List<Section>,
      isChordListPinned: isChordListPinned == const $CopyWithPlaceholder() || isChordListPinned == null
          ? _value.isChordListPinned
          // ignore: cast_nullable_to_non_nullable
          : isChordListPinned as bool,
    );
  }
}

extension $VersionStateCopyWith on VersionState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionState.copyWith(...)` or like so:`instanceOfVersionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionStateCWProxy get copyWith => _$VersionStateCWProxyImpl(this);
}

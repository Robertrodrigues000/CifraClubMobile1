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

  VersionState isYouTubeVisible(bool isYouTubeVisible);

  VersionState versionHeaderState(VersionHeaderState versionHeaderState);

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
    bool? isYouTubeVisible,
    VersionHeaderState? versionHeaderState,
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
  VersionState isYouTubeVisible(bool isYouTubeVisible) => this(isYouTubeVisible: isYouTubeVisible);

  @override
  VersionState versionHeaderState(VersionHeaderState versionHeaderState) =>
      this(versionHeaderState: versionHeaderState);

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
    Object? isYouTubeVisible = const $CopyWithPlaceholder(),
    Object? versionHeaderState = const $CopyWithPlaceholder(),
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
      isYouTubeVisible: isYouTubeVisible == const $CopyWithPlaceholder() || isYouTubeVisible == null
          ? _value.isYouTubeVisible
          // ignore: cast_nullable_to_non_nullable
          : isYouTubeVisible as bool,
      versionHeaderState: versionHeaderState == const $CopyWithPlaceholder() || versionHeaderState == null
          ? _value.versionHeaderState
          // ignore: cast_nullable_to_non_nullable
          : versionHeaderState as VersionHeaderState,
    );
  }
}

extension $VersionStateCopyWith on VersionState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionState.copyWith(...)` or like so:`instanceOfVersionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionStateCWProxy get copyWith => _$VersionStateCWProxyImpl(this);
}

abstract class _$VersionHeaderStateCWProxy {
  VersionHeaderState isFavorite(bool? isFavorite);

  VersionHeaderState selectedVersionLabel(String? selectedVersionLabel);

  VersionHeaderState versionLabels(List<String> versionLabels);

  VersionHeaderState artistName(String artistName);

  VersionHeaderState songName(String songName);

  VersionHeaderState artistUrl(String? artistUrl);

  VersionHeaderState songUrl(String? songUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionHeaderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionHeaderState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionHeaderState call({
    bool? isFavorite,
    String? selectedVersionLabel,
    List<String>? versionLabels,
    String? artistName,
    String? songName,
    String? artistUrl,
    String? songUrl,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersionHeaderState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersionHeaderState.copyWith.fieldName(...)`
class _$VersionHeaderStateCWProxyImpl implements _$VersionHeaderStateCWProxy {
  const _$VersionHeaderStateCWProxyImpl(this._value);

  final VersionHeaderState _value;

  @override
  VersionHeaderState isFavorite(bool? isFavorite) => this(isFavorite: isFavorite);

  @override
  VersionHeaderState selectedVersionLabel(String? selectedVersionLabel) =>
      this(selectedVersionLabel: selectedVersionLabel);

  @override
  VersionHeaderState versionLabels(List<String> versionLabels) => this(versionLabels: versionLabels);

  @override
  VersionHeaderState artistName(String artistName) => this(artistName: artistName);

  @override
  VersionHeaderState songName(String songName) => this(songName: songName);

  @override
  VersionHeaderState artistUrl(String? artistUrl) => this(artistUrl: artistUrl);

  @override
  VersionHeaderState songUrl(String? songUrl) => this(songUrl: songUrl);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionHeaderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionHeaderState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionHeaderState call({
    Object? isFavorite = const $CopyWithPlaceholder(),
    Object? selectedVersionLabel = const $CopyWithPlaceholder(),
    Object? versionLabels = const $CopyWithPlaceholder(),
    Object? artistName = const $CopyWithPlaceholder(),
    Object? songName = const $CopyWithPlaceholder(),
    Object? artistUrl = const $CopyWithPlaceholder(),
    Object? songUrl = const $CopyWithPlaceholder(),
  }) {
    return VersionHeaderState(
      isFavorite: isFavorite == const $CopyWithPlaceholder()
          ? _value.isFavorite
          // ignore: cast_nullable_to_non_nullable
          : isFavorite as bool?,
      selectedVersionLabel: selectedVersionLabel == const $CopyWithPlaceholder()
          ? _value.selectedVersionLabel
          // ignore: cast_nullable_to_non_nullable
          : selectedVersionLabel as String?,
      versionLabels: versionLabels == const $CopyWithPlaceholder() || versionLabels == null
          ? _value.versionLabels
          // ignore: cast_nullable_to_non_nullable
          : versionLabels as List<String>,
      artistName: artistName == const $CopyWithPlaceholder() || artistName == null
          ? _value.artistName
          // ignore: cast_nullable_to_non_nullable
          : artistName as String,
      songName: songName == const $CopyWithPlaceholder() || songName == null
          ? _value.songName
          // ignore: cast_nullable_to_non_nullable
          : songName as String,
      artistUrl: artistUrl == const $CopyWithPlaceholder()
          ? _value.artistUrl
          // ignore: cast_nullable_to_non_nullable
          : artistUrl as String?,
      songUrl: songUrl == const $CopyWithPlaceholder()
          ? _value.songUrl
          // ignore: cast_nullable_to_non_nullable
          : songUrl as String?,
    );
  }
}

extension $VersionHeaderStateCopyWith on VersionHeaderState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionHeaderState.copyWith(...)` or like so:`instanceOfVersionHeaderState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionHeaderStateCWProxy get copyWith => _$VersionHeaderStateCWProxyImpl(this);
}

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

  VersionState fontSizeState(FontSizeState fontSizeState);

  VersionState isChordListPinned(bool isChordListPinned);

  VersionState isYouTubeVisible(bool isYouTubeVisible);

  VersionState versionHeaderState(VersionHeaderState versionHeaderState);

  VersionState autoScrollState(AutoScrollState autoScrollState);

  VersionState chordState(ChordState chordState);

  VersionState floatingFooterBarState(FloatingFooterBarState floatingFooterBarState);

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
    FontSizeState? fontSizeState,
    bool? isChordListPinned,
    bool? isYouTubeVisible,
    VersionHeaderState? versionHeaderState,
    AutoScrollState? autoScrollState,
    ChordState? chordState,
    FloatingFooterBarState? floatingFooterBarState,
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
  VersionState fontSizeState(FontSizeState fontSizeState) => this(fontSizeState: fontSizeState);

  @override
  VersionState isChordListPinned(bool isChordListPinned) => this(isChordListPinned: isChordListPinned);

  @override
  VersionState isYouTubeVisible(bool isYouTubeVisible) => this(isYouTubeVisible: isYouTubeVisible);

  @override
  VersionState versionHeaderState(VersionHeaderState versionHeaderState) =>
      this(versionHeaderState: versionHeaderState);

  @override
  VersionState autoScrollState(AutoScrollState autoScrollState) => this(autoScrollState: autoScrollState);

  @override
  VersionState chordState(ChordState chordState) => this(chordState: chordState);

  @override
  VersionState floatingFooterBarState(FloatingFooterBarState floatingFooterBarState) =>
      this(floatingFooterBarState: floatingFooterBarState);

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
    Object? fontSizeState = const $CopyWithPlaceholder(),
    Object? isChordListPinned = const $CopyWithPlaceholder(),
    Object? isYouTubeVisible = const $CopyWithPlaceholder(),
    Object? versionHeaderState = const $CopyWithPlaceholder(),
    Object? autoScrollState = const $CopyWithPlaceholder(),
    Object? chordState = const $CopyWithPlaceholder(),
    Object? floatingFooterBarState = const $CopyWithPlaceholder(),
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
      fontSizeState: fontSizeState == const $CopyWithPlaceholder() || fontSizeState == null
          ? _value.fontSizeState
          // ignore: cast_nullable_to_non_nullable
          : fontSizeState as FontSizeState,
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
      autoScrollState: autoScrollState == const $CopyWithPlaceholder() || autoScrollState == null
          ? _value.autoScrollState
          // ignore: cast_nullable_to_non_nullable
          : autoScrollState as AutoScrollState,
      chordState: chordState == const $CopyWithPlaceholder() || chordState == null
          ? _value.chordState
          // ignore: cast_nullable_to_non_nullable
          : chordState as ChordState,
      floatingFooterBarState: floatingFooterBarState == const $CopyWithPlaceholder() || floatingFooterBarState == null
          ? _value.floatingFooterBarState
          // ignore: cast_nullable_to_non_nullable
          : floatingFooterBarState as FloatingFooterBarState,
    );
  }
}

extension $VersionStateCopyWith on VersionState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionState.copyWith(...)` or like so:`instanceOfVersionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionStateCWProxy get copyWith => _$VersionStateCWProxyImpl(this);
}

abstract class _$VersionHeaderStateCWProxy {
  VersionHeaderState selectedInstrument(Instrument? selectedInstrument);

  VersionHeaderState isFavorite(bool isFavorite);

  VersionHeaderState selectedVersionFilter(VersionFilter? selectedVersionFilter);

  VersionHeaderState versionFilters(List<VersionFilter> versionFilters);

  VersionHeaderState artistName(String artistName);

  VersionHeaderState songName(String songName);

  VersionHeaderState artistUrl(String artistUrl);

  VersionHeaderState songUrl(String songUrl);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionHeaderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionHeaderState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionHeaderState call({
    Instrument? selectedInstrument,
    bool? isFavorite,
    VersionFilter? selectedVersionFilter,
    List<VersionFilter>? versionFilters,
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
  VersionHeaderState selectedInstrument(Instrument? selectedInstrument) => this(selectedInstrument: selectedInstrument);

  @override
  VersionHeaderState isFavorite(bool isFavorite) => this(isFavorite: isFavorite);

  @override
  VersionHeaderState selectedVersionFilter(VersionFilter? selectedVersionFilter) =>
      this(selectedVersionFilter: selectedVersionFilter);

  @override
  VersionHeaderState versionFilters(List<VersionFilter> versionFilters) => this(versionFilters: versionFilters);

  @override
  VersionHeaderState artistName(String artistName) => this(artistName: artistName);

  @override
  VersionHeaderState songName(String songName) => this(songName: songName);

  @override
  VersionHeaderState artistUrl(String artistUrl) => this(artistUrl: artistUrl);

  @override
  VersionHeaderState songUrl(String songUrl) => this(songUrl: songUrl);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionHeaderState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionHeaderState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionHeaderState call({
    Object? selectedInstrument = const $CopyWithPlaceholder(),
    Object? isFavorite = const $CopyWithPlaceholder(),
    Object? selectedVersionFilter = const $CopyWithPlaceholder(),
    Object? versionFilters = const $CopyWithPlaceholder(),
    Object? artistName = const $CopyWithPlaceholder(),
    Object? songName = const $CopyWithPlaceholder(),
    Object? artistUrl = const $CopyWithPlaceholder(),
    Object? songUrl = const $CopyWithPlaceholder(),
  }) {
    return VersionHeaderState(
      selectedInstrument: selectedInstrument == const $CopyWithPlaceholder()
          ? _value.selectedInstrument
          // ignore: cast_nullable_to_non_nullable
          : selectedInstrument as Instrument?,
      isFavorite: isFavorite == const $CopyWithPlaceholder() || isFavorite == null
          ? _value.isFavorite
          // ignore: cast_nullable_to_non_nullable
          : isFavorite as bool,
      selectedVersionFilter: selectedVersionFilter == const $CopyWithPlaceholder()
          ? _value.selectedVersionFilter
          // ignore: cast_nullable_to_non_nullable
          : selectedVersionFilter as VersionFilter?,
      versionFilters: versionFilters == const $CopyWithPlaceholder() || versionFilters == null
          ? _value.versionFilters
          // ignore: cast_nullable_to_non_nullable
          : versionFilters as List<VersionFilter>,
      artistName: artistName == const $CopyWithPlaceholder() || artistName == null
          ? _value.artistName
          // ignore: cast_nullable_to_non_nullable
          : artistName as String,
      songName: songName == const $CopyWithPlaceholder() || songName == null
          ? _value.songName
          // ignore: cast_nullable_to_non_nullable
          : songName as String,
      artistUrl: artistUrl == const $CopyWithPlaceholder() || artistUrl == null
          ? _value.artistUrl
          // ignore: cast_nullable_to_non_nullable
          : artistUrl as String,
      songUrl: songUrl == const $CopyWithPlaceholder() || songUrl == null
          ? _value.songUrl
          // ignore: cast_nullable_to_non_nullable
          : songUrl as String,
    );
  }
}

extension $VersionHeaderStateCopyWith on VersionHeaderState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionHeaderState.copyWith(...)` or like so:`instanceOfVersionHeaderState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionHeaderStateCWProxy get copyWith => _$VersionHeaderStateCWProxyImpl(this);
}

abstract class _$AutoScrollStateCWProxy {
  AutoScrollState isAutoScrollRunning(bool isAutoScrollRunning);

  AutoScrollState speedFactor(double speedFactor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AutoScrollState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AutoScrollState(...).copyWith(id: 12, name: "My name")
  /// ````
  AutoScrollState call({
    bool? isAutoScrollRunning,
    double? speedFactor,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAutoScrollState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAutoScrollState.copyWith.fieldName(...)`
class _$AutoScrollStateCWProxyImpl implements _$AutoScrollStateCWProxy {
  const _$AutoScrollStateCWProxyImpl(this._value);

  final AutoScrollState _value;

  @override
  AutoScrollState isAutoScrollRunning(bool isAutoScrollRunning) => this(isAutoScrollRunning: isAutoScrollRunning);

  @override
  AutoScrollState speedFactor(double speedFactor) => this(speedFactor: speedFactor);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AutoScrollState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AutoScrollState(...).copyWith(id: 12, name: "My name")
  /// ````
  AutoScrollState call({
    Object? isAutoScrollRunning = const $CopyWithPlaceholder(),
    Object? speedFactor = const $CopyWithPlaceholder(),
  }) {
    return AutoScrollState(
      isAutoScrollRunning: isAutoScrollRunning == const $CopyWithPlaceholder() || isAutoScrollRunning == null
          ? _value.isAutoScrollRunning
          // ignore: cast_nullable_to_non_nullable
          : isAutoScrollRunning as bool,
      speedFactor: speedFactor == const $CopyWithPlaceholder() || speedFactor == null
          ? _value.speedFactor
          // ignore: cast_nullable_to_non_nullable
          : speedFactor as double,
    );
  }
}

extension $AutoScrollStateCopyWith on AutoScrollState {
  /// Returns a callable class that can be used as follows: `instanceOfAutoScrollState.copyWith(...)` or like so:`instanceOfAutoScrollState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AutoScrollStateCWProxy get copyWith => _$AutoScrollStateCWProxyImpl(this);
}

abstract class _$ChordStateCWProxy {
  ChordState chordRepresentations(List<ChordRepresentation> chordRepresentations);

  ChordState selectedChord(String? selectedChord);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChordState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChordState(...).copyWith(id: 12, name: "My name")
  /// ````
  ChordState call({
    List<ChordRepresentation>? chordRepresentations,
    String? selectedChord,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfChordState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfChordState.copyWith.fieldName(...)`
class _$ChordStateCWProxyImpl implements _$ChordStateCWProxy {
  const _$ChordStateCWProxyImpl(this._value);

  final ChordState _value;

  @override
  ChordState chordRepresentations(List<ChordRepresentation> chordRepresentations) =>
      this(chordRepresentations: chordRepresentations);

  @override
  ChordState selectedChord(String? selectedChord) => this(selectedChord: selectedChord);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ChordState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ChordState(...).copyWith(id: 12, name: "My name")
  /// ````
  ChordState call({
    Object? chordRepresentations = const $CopyWithPlaceholder(),
    Object? selectedChord = const $CopyWithPlaceholder(),
  }) {
    return ChordState(
      chordRepresentations: chordRepresentations == const $CopyWithPlaceholder() || chordRepresentations == null
          ? _value.chordRepresentations
          // ignore: cast_nullable_to_non_nullable
          : chordRepresentations as List<ChordRepresentation>,
      selectedChord: selectedChord == const $CopyWithPlaceholder()
          ? _value.selectedChord
          // ignore: cast_nullable_to_non_nullable
          : selectedChord as String?,
    );
  }
}

extension $ChordStateCopyWith on ChordState {
  /// Returns a callable class that can be used as follows: `instanceOfChordState.copyWith(...)` or like so:`instanceOfChordState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ChordStateCWProxy get copyWith => _$ChordStateCWProxyImpl(this);
}

abstract class _$FloatingFooterBarStateCWProxy {
  FloatingFooterBarState mode(FloatingFooterBarMode mode);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FloatingFooterBarState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FloatingFooterBarState(...).copyWith(id: 12, name: "My name")
  /// ````
  FloatingFooterBarState call({
    FloatingFooterBarMode? mode,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFloatingFooterBarState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFloatingFooterBarState.copyWith.fieldName(...)`
class _$FloatingFooterBarStateCWProxyImpl implements _$FloatingFooterBarStateCWProxy {
  const _$FloatingFooterBarStateCWProxyImpl(this._value);

  final FloatingFooterBarState _value;

  @override
  FloatingFooterBarState mode(FloatingFooterBarMode mode) => this(mode: mode);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FloatingFooterBarState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FloatingFooterBarState(...).copyWith(id: 12, name: "My name")
  /// ````
  FloatingFooterBarState call({
    Object? mode = const $CopyWithPlaceholder(),
  }) {
    return FloatingFooterBarState(
      mode: mode == const $CopyWithPlaceholder() || mode == null
          ? _value.mode
          // ignore: cast_nullable_to_non_nullable
          : mode as FloatingFooterBarMode,
    );
  }
}

extension $FloatingFooterBarStateCopyWith on FloatingFooterBarState {
  /// Returns a callable class that can be used as follows: `instanceOfFloatingFooterBarState.copyWith(...)` or like so:`instanceOfFloatingFooterBarState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FloatingFooterBarStateCWProxy get copyWith => _$FloatingFooterBarStateCWProxyImpl(this);
}

abstract class _$FontSizeStateCWProxy {
  FontSizeState fontSize(int fontSize);

  FontSizeState isIncreaseEnabled(bool isIncreaseEnabled);

  FontSizeState isDecreaseEnabled(bool isDecreaseEnabled);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FontSizeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FontSizeState(...).copyWith(id: 12, name: "My name")
  /// ````
  FontSizeState call({
    int? fontSize,
    bool? isIncreaseEnabled,
    bool? isDecreaseEnabled,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFontSizeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFontSizeState.copyWith.fieldName(...)`
class _$FontSizeStateCWProxyImpl implements _$FontSizeStateCWProxy {
  const _$FontSizeStateCWProxyImpl(this._value);

  final FontSizeState _value;

  @override
  FontSizeState fontSize(int fontSize) => this(fontSize: fontSize);

  @override
  FontSizeState isIncreaseEnabled(bool isIncreaseEnabled) => this(isIncreaseEnabled: isIncreaseEnabled);

  @override
  FontSizeState isDecreaseEnabled(bool isDecreaseEnabled) => this(isDecreaseEnabled: isDecreaseEnabled);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `FontSizeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// FontSizeState(...).copyWith(id: 12, name: "My name")
  /// ````
  FontSizeState call({
    Object? fontSize = const $CopyWithPlaceholder(),
    Object? isIncreaseEnabled = const $CopyWithPlaceholder(),
    Object? isDecreaseEnabled = const $CopyWithPlaceholder(),
  }) {
    return FontSizeState(
      fontSize: fontSize == const $CopyWithPlaceholder() || fontSize == null
          ? _value.fontSize
          // ignore: cast_nullable_to_non_nullable
          : fontSize as int,
      isIncreaseEnabled: isIncreaseEnabled == const $CopyWithPlaceholder() || isIncreaseEnabled == null
          ? _value.isIncreaseEnabled
          // ignore: cast_nullable_to_non_nullable
          : isIncreaseEnabled as bool,
      isDecreaseEnabled: isDecreaseEnabled == const $CopyWithPlaceholder() || isDecreaseEnabled == null
          ? _value.isDecreaseEnabled
          // ignore: cast_nullable_to_non_nullable
          : isDecreaseEnabled as bool,
    );
  }
}

extension $FontSizeStateCopyWith on FontSizeState {
  /// Returns a callable class that can be used as follows: `instanceOfFontSizeState.copyWith(...)` or like so:`instanceOfFontSizeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FontSizeStateCWProxy get copyWith => _$FontSizeStateCWProxyImpl(this);
}

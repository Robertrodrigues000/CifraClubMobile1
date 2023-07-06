// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ArtistStateCWProxy {
  ArtistState isLoading(bool isLoading);

  ArtistState error(RequestError? error);

  ArtistState selectedInstrument(Instrument? selectedInstrument);

  ArtistState instruments(List<Instrument> instruments);

  ArtistState artistInfo(ArtistInfo? artistInfo);

  ArtistState songs(List<ArtistSong> songs);

  ArtistState albums(List<Album> albums);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistState call({
    bool? isLoading,
    RequestError? error,
    Instrument? selectedInstrument,
    List<Instrument>? instruments,
    ArtistInfo? artistInfo,
    List<ArtistSong>? songs,
    List<Album>? albums,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfArtistState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfArtistState.copyWith.fieldName(...)`
class _$ArtistStateCWProxyImpl implements _$ArtistStateCWProxy {
  const _$ArtistStateCWProxyImpl(this._value);

  final ArtistState _value;

  @override
  ArtistState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  ArtistState error(RequestError? error) => this(error: error);

  @override
  ArtistState selectedInstrument(Instrument? selectedInstrument) => this(selectedInstrument: selectedInstrument);

  @override
  ArtistState instruments(List<Instrument> instruments) => this(instruments: instruments);

  @override
  ArtistState artistInfo(ArtistInfo? artistInfo) => this(artistInfo: artistInfo);

  @override
  ArtistState songs(List<ArtistSong> songs) => this(songs: songs);

  @override
  ArtistState albums(List<Album> albums) => this(albums: albums);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? selectedInstrument = const $CopyWithPlaceholder(),
    Object? instruments = const $CopyWithPlaceholder(),
    Object? artistInfo = const $CopyWithPlaceholder(),
    Object? songs = const $CopyWithPlaceholder(),
    Object? albums = const $CopyWithPlaceholder(),
  }) {
    return ArtistState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      selectedInstrument: selectedInstrument == const $CopyWithPlaceholder()
          ? _value.selectedInstrument
          // ignore: cast_nullable_to_non_nullable
          : selectedInstrument as Instrument?,
      instruments: instruments == const $CopyWithPlaceholder() || instruments == null
          ? _value.instruments
          // ignore: cast_nullable_to_non_nullable
          : instruments as List<Instrument>,
      artistInfo: artistInfo == const $CopyWithPlaceholder()
          ? _value.artistInfo
          // ignore: cast_nullable_to_non_nullable
          : artistInfo as ArtistInfo?,
      songs: songs == const $CopyWithPlaceholder() || songs == null
          ? _value.songs
          // ignore: cast_nullable_to_non_nullable
          : songs as List<ArtistSong>,
      albums: albums == const $CopyWithPlaceholder() || albums == null
          ? _value.albums
          // ignore: cast_nullable_to_non_nullable
          : albums as List<Album>,
    );
  }
}

extension $ArtistStateCopyWith on ArtistState {
  /// Returns a callable class that can be used as follows: `instanceOfArtistState.copyWith(...)` or like so:`instanceOfArtistState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ArtistStateCWProxy get copyWith => _$ArtistStateCWProxyImpl(this);
}

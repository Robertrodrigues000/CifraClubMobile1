// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ArtistStateCWProxy {
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
    Object? artistInfo = const $CopyWithPlaceholder(),
    Object? songs = const $CopyWithPlaceholder(),
    Object? albums = const $CopyWithPlaceholder(),
  }) {
    return ArtistState(
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

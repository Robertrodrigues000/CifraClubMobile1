// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_songs_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ArtistSongsStateCWProxy {
  ArtistSongsState songs(List<String> songs);

  ArtistSongsState videoLessons(List<String> videoLessons);

  ArtistSongsState artistName(String artistName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSongsState call({
    List<String>? songs,
    List<String>? videoLessons,
    String? artistName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfArtistSongsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfArtistSongsState.copyWith.fieldName(...)`
class _$ArtistSongsStateCWProxyImpl implements _$ArtistSongsStateCWProxy {
  const _$ArtistSongsStateCWProxyImpl(this._value);

  final ArtistSongsState _value;

  @override
  ArtistSongsState songs(List<String> songs) => this(songs: songs);

  @override
  ArtistSongsState videoLessons(List<String> videoLessons) => this(videoLessons: videoLessons);

  @override
  ArtistSongsState artistName(String artistName) => this(artistName: artistName);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSongsState call({
    Object? songs = const $CopyWithPlaceholder(),
    Object? videoLessons = const $CopyWithPlaceholder(),
    Object? artistName = const $CopyWithPlaceholder(),
  }) {
    return ArtistSongsState(
      songs: songs == const $CopyWithPlaceholder() || songs == null
          ? _value.songs
          // ignore: cast_nullable_to_non_nullable
          : songs as List<String>,
      videoLessons: videoLessons == const $CopyWithPlaceholder() || videoLessons == null
          ? _value.videoLessons
          // ignore: cast_nullable_to_non_nullable
          : videoLessons as List<String>,
      artistName: artistName == const $CopyWithPlaceholder() || artistName == null
          ? _value.artistName
          // ignore: cast_nullable_to_non_nullable
          : artistName as String,
    );
  }
}

extension $ArtistSongsStateCopyWith on ArtistSongsState {
  /// Returns a callable class that can be used as follows: `instanceOfArtistSongsState.copyWith(...)` or like so:`instanceOfArtistSongsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ArtistSongsStateCWProxy get copyWith => _$ArtistSongsStateCWProxyImpl(this);
}

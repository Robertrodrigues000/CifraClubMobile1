// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_songs_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ArtistSongsStateCWProxy {
  ArtistSongsState songs(List<ArtistSong> songs);

  ArtistSongsState prefixes(List<String> prefixes);

  ArtistSongsState videoLessons(List<VideoLesson> videoLessons);

  ArtistSongsState songsError(RequestError? songsError);

  ArtistSongsState videoLessonsError(RequestError? videoLessonsError);

  ArtistSongsState instrument(Instrument? instrument);

  ArtistSongsState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSongsState call({
    List<ArtistSong>? songs,
    List<String>? prefixes,
    List<VideoLesson>? videoLessons,
    RequestError? songsError,
    RequestError? videoLessonsError,
    Instrument? instrument,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfArtistSongsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfArtistSongsState.copyWith.fieldName(...)`
class _$ArtistSongsStateCWProxyImpl implements _$ArtistSongsStateCWProxy {
  const _$ArtistSongsStateCWProxyImpl(this._value);

  final ArtistSongsState _value;

  @override
  ArtistSongsState songs(List<ArtistSong> songs) => this(songs: songs);

  @override
  ArtistSongsState prefixes(List<String> prefixes) => this(prefixes: prefixes);

  @override
  ArtistSongsState videoLessons(List<VideoLesson> videoLessons) => this(videoLessons: videoLessons);

  @override
  ArtistSongsState songsError(RequestError? songsError) => this(songsError: songsError);

  @override
  ArtistSongsState videoLessonsError(RequestError? videoLessonsError) => this(videoLessonsError: videoLessonsError);

  @override
  ArtistSongsState instrument(Instrument? instrument) => this(instrument: instrument);

  @override
  ArtistSongsState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSongsState call({
    Object? songs = const $CopyWithPlaceholder(),
    Object? prefixes = const $CopyWithPlaceholder(),
    Object? videoLessons = const $CopyWithPlaceholder(),
    Object? songsError = const $CopyWithPlaceholder(),
    Object? videoLessonsError = const $CopyWithPlaceholder(),
    Object? instrument = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return ArtistSongsState(
      songs: songs == const $CopyWithPlaceholder() || songs == null
          ? _value.songs
          // ignore: cast_nullable_to_non_nullable
          : songs as List<ArtistSong>,
      prefixes: prefixes == const $CopyWithPlaceholder() || prefixes == null
          ? _value.prefixes
          // ignore: cast_nullable_to_non_nullable
          : prefixes as List<String>,
      videoLessons: videoLessons == const $CopyWithPlaceholder() || videoLessons == null
          ? _value.videoLessons
          // ignore: cast_nullable_to_non_nullable
          : videoLessons as List<VideoLesson>,
      songsError: songsError == const $CopyWithPlaceholder()
          ? _value.songsError
          // ignore: cast_nullable_to_non_nullable
          : songsError as RequestError?,
      videoLessonsError: videoLessonsError == const $CopyWithPlaceholder()
          ? _value.videoLessonsError
          // ignore: cast_nullable_to_non_nullable
          : videoLessonsError as RequestError?,
      instrument: instrument == const $CopyWithPlaceholder()
          ? _value.instrument
          // ignore: cast_nullable_to_non_nullable
          : instrument as Instrument?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $ArtistSongsStateCopyWith on ArtistSongsState {
  /// Returns a callable class that can be used as follows: `instanceOfArtistSongsState.copyWith(...)` or like so:`instanceOfArtistSongsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ArtistSongsStateCWProxy get copyWith => _$ArtistSongsStateCWProxyImpl(this);
}

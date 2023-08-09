// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_songs_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ArtistSongsStateCWProxy {
  ArtistSongsState songs(List<ArtistSong> songs);

  ArtistSongsState songsFilteredBySearch(List<ArtistSong> songsFilteredBySearch);

  ArtistSongsState alphabeticalPrefixes(List<String> alphabeticalPrefixes);

  ArtistSongsState rankingPrefixes(List<String> rankingPrefixes);

  ArtistSongsState videoLessons(List<VideoLesson> videoLessons);

  ArtistSongsState videoLessonsFilteredBySearch(List<VideoLesson> videoLessonsFilteredBySearch);

  ArtistSongsState instrument(Instrument? instrument);

  ArtistSongsState songsError(RequestError? songsError);

  ArtistSongsState videoLessonsError(RequestError? videoLessonsError);

  ArtistSongsState isLoading(bool isLoading);

  ArtistSongsState shouldShowSearch(bool shouldShowSearch);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSongsState call({
    List<ArtistSong>? songs,
    List<ArtistSong>? songsFilteredBySearch,
    List<String>? alphabeticalPrefixes,
    List<String>? rankingPrefixes,
    List<VideoLesson>? videoLessons,
    List<VideoLesson>? videoLessonsFilteredBySearch,
    Instrument? instrument,
    RequestError? songsError,
    RequestError? videoLessonsError,
    bool? isLoading,
    bool? shouldShowSearch,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfArtistSongsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfArtistSongsState.copyWith.fieldName(...)`
class _$ArtistSongsStateCWProxyImpl implements _$ArtistSongsStateCWProxy {
  const _$ArtistSongsStateCWProxyImpl(this._value);

  final ArtistSongsState _value;

  @override
  ArtistSongsState songs(List<ArtistSong> songs) => this(songs: songs);

  @override
  ArtistSongsState songsFilteredBySearch(List<ArtistSong> songsFilteredBySearch) =>
      this(songsFilteredBySearch: songsFilteredBySearch);

  @override
  ArtistSongsState alphabeticalPrefixes(List<String> alphabeticalPrefixes) =>
      this(alphabeticalPrefixes: alphabeticalPrefixes);

  @override
  ArtistSongsState rankingPrefixes(List<String> rankingPrefixes) => this(rankingPrefixes: rankingPrefixes);

  @override
  ArtistSongsState videoLessons(List<VideoLesson> videoLessons) => this(videoLessons: videoLessons);

  @override
  ArtistSongsState videoLessonsFilteredBySearch(List<VideoLesson> videoLessonsFilteredBySearch) =>
      this(videoLessonsFilteredBySearch: videoLessonsFilteredBySearch);

  @override
  ArtistSongsState instrument(Instrument? instrument) => this(instrument: instrument);

  @override
  ArtistSongsState songsError(RequestError? songsError) => this(songsError: songsError);

  @override
  ArtistSongsState videoLessonsError(RequestError? videoLessonsError) => this(videoLessonsError: videoLessonsError);

  @override
  ArtistSongsState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  ArtistSongsState shouldShowSearch(bool shouldShowSearch) => this(shouldShowSearch: shouldShowSearch);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistSongsState call({
    Object? songs = const $CopyWithPlaceholder(),
    Object? songsFilteredBySearch = const $CopyWithPlaceholder(),
    Object? alphabeticalPrefixes = const $CopyWithPlaceholder(),
    Object? rankingPrefixes = const $CopyWithPlaceholder(),
    Object? videoLessons = const $CopyWithPlaceholder(),
    Object? videoLessonsFilteredBySearch = const $CopyWithPlaceholder(),
    Object? instrument = const $CopyWithPlaceholder(),
    Object? songsError = const $CopyWithPlaceholder(),
    Object? videoLessonsError = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? shouldShowSearch = const $CopyWithPlaceholder(),
  }) {
    return ArtistSongsState(
      songs: songs == const $CopyWithPlaceholder() || songs == null
          ? _value.songs
          // ignore: cast_nullable_to_non_nullable
          : songs as List<ArtistSong>,
      songsFilteredBySearch: songsFilteredBySearch == const $CopyWithPlaceholder() || songsFilteredBySearch == null
          ? _value.songsFilteredBySearch
          // ignore: cast_nullable_to_non_nullable
          : songsFilteredBySearch as List<ArtistSong>,
      alphabeticalPrefixes: alphabeticalPrefixes == const $CopyWithPlaceholder() || alphabeticalPrefixes == null
          ? _value.alphabeticalPrefixes
          // ignore: cast_nullable_to_non_nullable
          : alphabeticalPrefixes as List<String>,
      rankingPrefixes: rankingPrefixes == const $CopyWithPlaceholder() || rankingPrefixes == null
          ? _value.rankingPrefixes
          // ignore: cast_nullable_to_non_nullable
          : rankingPrefixes as List<String>,
      videoLessons: videoLessons == const $CopyWithPlaceholder() || videoLessons == null
          ? _value.videoLessons
          // ignore: cast_nullable_to_non_nullable
          : videoLessons as List<VideoLesson>,
      videoLessonsFilteredBySearch:
          videoLessonsFilteredBySearch == const $CopyWithPlaceholder() || videoLessonsFilteredBySearch == null
              ? _value.videoLessonsFilteredBySearch
              // ignore: cast_nullable_to_non_nullable
              : videoLessonsFilteredBySearch as List<VideoLesson>,
      instrument: instrument == const $CopyWithPlaceholder()
          ? _value.instrument
          // ignore: cast_nullable_to_non_nullable
          : instrument as Instrument?,
      songsError: songsError == const $CopyWithPlaceholder()
          ? _value.songsError
          // ignore: cast_nullable_to_non_nullable
          : songsError as RequestError?,
      videoLessonsError: videoLessonsError == const $CopyWithPlaceholder()
          ? _value.videoLessonsError
          // ignore: cast_nullable_to_non_nullable
          : videoLessonsError as RequestError?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      shouldShowSearch: shouldShowSearch == const $CopyWithPlaceholder() || shouldShowSearch == null
          ? _value.shouldShowSearch
          // ignore: cast_nullable_to_non_nullable
          : shouldShowSearch as bool,
    );
  }
}

extension $ArtistSongsStateCopyWith on ArtistSongsState {
  /// Returns a callable class that can be used as follows: `instanceOfArtistSongsState.copyWith(...)` or like so:`instanceOfArtistSongsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ArtistSongsStateCWProxy get copyWith => _$ArtistSongsStateCWProxyImpl(this);
}

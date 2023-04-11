// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_songs_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TopSongsStateCWProxy {
  TopSongsState selectedGenre(String? selectedGenre);

  TopSongsState genres(List<Genre> genres);

  TopSongsState topSongs(List<Song> topSongs);

  TopSongsState error(RequestError? error);

  TopSongsState isLoadingSongs(bool isLoadingSongs);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TopSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TopSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  TopSongsState call({
    String? selectedGenre,
    List<Genre>? genres,
    List<Song>? topSongs,
    RequestError? error,
    bool? isLoadingSongs,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTopSongsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTopSongsState.copyWith.fieldName(...)`
class _$TopSongsStateCWProxyImpl implements _$TopSongsStateCWProxy {
  const _$TopSongsStateCWProxyImpl(this._value);

  final TopSongsState _value;

  @override
  TopSongsState selectedGenre(String? selectedGenre) => this(selectedGenre: selectedGenre);

  @override
  TopSongsState genres(List<Genre> genres) => this(genres: genres);

  @override
  TopSongsState topSongs(List<Song> topSongs) => this(topSongs: topSongs);

  @override
  TopSongsState error(RequestError? error) => this(error: error);

  @override
  TopSongsState isLoadingSongs(bool isLoadingSongs) => this(isLoadingSongs: isLoadingSongs);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TopSongsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TopSongsState(...).copyWith(id: 12, name: "My name")
  /// ````
  TopSongsState call({
    Object? selectedGenre = const $CopyWithPlaceholder(),
    Object? genres = const $CopyWithPlaceholder(),
    Object? topSongs = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? isLoadingSongs = const $CopyWithPlaceholder(),
  }) {
    return TopSongsState(
      selectedGenre: selectedGenre == const $CopyWithPlaceholder()
          ? _value.selectedGenre
          // ignore: cast_nullable_to_non_nullable
          : selectedGenre as String?,
      genres: genres == const $CopyWithPlaceholder() || genres == null
          ? _value.genres
          // ignore: cast_nullable_to_non_nullable
          : genres as List<Genre>,
      topSongs: topSongs == const $CopyWithPlaceholder() || topSongs == null
          ? _value.topSongs
          // ignore: cast_nullable_to_non_nullable
          : topSongs as List<Song>,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      isLoadingSongs: isLoadingSongs == const $CopyWithPlaceholder() || isLoadingSongs == null
          ? _value.isLoadingSongs
          // ignore: cast_nullable_to_non_nullable
          : isLoadingSongs as bool,
    );
  }
}

extension $TopSongsStateCopyWith on TopSongsState {
  /// Returns a callable class that can be used as follows: `instanceOfTopSongsState.copyWith(...)` or like so:`instanceOfTopSongsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TopSongsStateCWProxy get copyWith => _$TopSongsStateCWProxyImpl(this);
}

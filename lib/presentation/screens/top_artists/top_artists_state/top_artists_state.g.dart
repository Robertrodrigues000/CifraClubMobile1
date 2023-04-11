// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_artists_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TopArtistsStateCWProxy {
  TopArtistsState selectedGenre(String? selectedGenre);

  TopArtistsState genres(List<Genre> genres);

  TopArtistsState topArtists(List<Artist> topArtists);

  TopArtistsState error(RequestError? error);

  TopArtistsState isLoadingArtists(bool isLoadingArtists);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TopArtistsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TopArtistsState(...).copyWith(id: 12, name: "My name")
  /// ````
  TopArtistsState call({
    String? selectedGenre,
    List<Genre>? genres,
    List<Artist>? topArtists,
    RequestError? error,
    bool? isLoadingArtists,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTopArtistsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTopArtistsState.copyWith.fieldName(...)`
class _$TopArtistsStateCWProxyImpl implements _$TopArtistsStateCWProxy {
  const _$TopArtistsStateCWProxyImpl(this._value);

  final TopArtistsState _value;

  @override
  TopArtistsState selectedGenre(String? selectedGenre) => this(selectedGenre: selectedGenre);

  @override
  TopArtistsState genres(List<Genre> genres) => this(genres: genres);

  @override
  TopArtistsState topArtists(List<Artist> topArtists) => this(topArtists: topArtists);

  @override
  TopArtistsState error(RequestError? error) => this(error: error);

  @override
  TopArtistsState isLoadingArtists(bool isLoadingArtists) => this(isLoadingArtists: isLoadingArtists);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TopArtistsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TopArtistsState(...).copyWith(id: 12, name: "My name")
  /// ````
  TopArtistsState call({
    Object? selectedGenre = const $CopyWithPlaceholder(),
    Object? genres = const $CopyWithPlaceholder(),
    Object? topArtists = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? isLoadingArtists = const $CopyWithPlaceholder(),
  }) {
    return TopArtistsState(
      selectedGenre: selectedGenre == const $CopyWithPlaceholder()
          ? _value.selectedGenre
          // ignore: cast_nullable_to_non_nullable
          : selectedGenre as String?,
      genres: genres == const $CopyWithPlaceholder() || genres == null
          ? _value.genres
          // ignore: cast_nullable_to_non_nullable
          : genres as List<Genre>,
      topArtists: topArtists == const $CopyWithPlaceholder() || topArtists == null
          ? _value.topArtists
          // ignore: cast_nullable_to_non_nullable
          : topArtists as List<Artist>,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      isLoadingArtists: isLoadingArtists == const $CopyWithPlaceholder() || isLoadingArtists == null
          ? _value.isLoadingArtists
          // ignore: cast_nullable_to_non_nullable
          : isLoadingArtists as bool,
    );
  }
}

extension $TopArtistsStateCopyWith on TopArtistsState {
  /// Returns a callable class that can be used as follows: `instanceOfTopArtistsState.copyWith(...)` or like so:`instanceOfTopArtistsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TopArtistsStateCWProxy get copyWith => _$TopArtistsStateCWProxyImpl(this);
}

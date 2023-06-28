// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomeStateCWProxy {
  HomeState highlights(List<Highlight>? highlights);

  HomeState topSongs(List<Song> topSongs);

  HomeState topArtists(List<Artist> topArtists);

  HomeState videoLessons(List<VideoLesson>? videoLessons);

  HomeState blog(List<News> blog);

  HomeState selectedGenre(String? selectedGenre);

  HomeState genres(List<Genre> genres);

  HomeState user(User? user);

  HomeState isPro(bool isPro);

  HomeState isLoading(bool isLoading);

  HomeState error(RequestError? error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    List<Highlight>? highlights,
    List<Song>? topSongs,
    List<Artist>? topArtists,
    List<VideoLesson>? videoLessons,
    List<News>? blog,
    String? selectedGenre,
    List<Genre>? genres,
    User? user,
    bool? isPro,
    bool? isLoading,
    RequestError? error,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomeState.copyWith.fieldName(...)`
class _$HomeStateCWProxyImpl implements _$HomeStateCWProxy {
  const _$HomeStateCWProxyImpl(this._value);

  final HomeState _value;

  @override
  HomeState highlights(List<Highlight>? highlights) => this(highlights: highlights);

  @override
  HomeState topSongs(List<Song> topSongs) => this(topSongs: topSongs);

  @override
  HomeState topArtists(List<Artist> topArtists) => this(topArtists: topArtists);

  @override
  HomeState videoLessons(List<VideoLesson>? videoLessons) => this(videoLessons: videoLessons);

  @override
  HomeState blog(List<News> blog) => this(blog: blog);

  @override
  HomeState selectedGenre(String? selectedGenre) => this(selectedGenre: selectedGenre);

  @override
  HomeState genres(List<Genre> genres) => this(genres: genres);

  @override
  HomeState user(User? user) => this(user: user);

  @override
  HomeState isPro(bool isPro) => this(isPro: isPro);

  @override
  HomeState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  HomeState error(RequestError? error) => this(error: error);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomeState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomeState call({
    Object? highlights = const $CopyWithPlaceholder(),
    Object? topSongs = const $CopyWithPlaceholder(),
    Object? topArtists = const $CopyWithPlaceholder(),
    Object? videoLessons = const $CopyWithPlaceholder(),
    Object? blog = const $CopyWithPlaceholder(),
    Object? selectedGenre = const $CopyWithPlaceholder(),
    Object? genres = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? isPro = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
  }) {
    return HomeState(
      highlights: highlights == const $CopyWithPlaceholder()
          ? _value.highlights
          // ignore: cast_nullable_to_non_nullable
          : highlights as List<Highlight>?,
      topSongs: topSongs == const $CopyWithPlaceholder() || topSongs == null
          ? _value.topSongs
          // ignore: cast_nullable_to_non_nullable
          : topSongs as List<Song>,
      topArtists: topArtists == const $CopyWithPlaceholder() || topArtists == null
          ? _value.topArtists
          // ignore: cast_nullable_to_non_nullable
          : topArtists as List<Artist>,
      videoLessons: videoLessons == const $CopyWithPlaceholder()
          ? _value.videoLessons
          // ignore: cast_nullable_to_non_nullable
          : videoLessons as List<VideoLesson>?,
      blog: blog == const $CopyWithPlaceholder() || blog == null
          ? _value.blog
          // ignore: cast_nullable_to_non_nullable
          : blog as List<News>,
      selectedGenre: selectedGenre == const $CopyWithPlaceholder()
          ? _value.selectedGenre
          // ignore: cast_nullable_to_non_nullable
          : selectedGenre as String?,
      genres: genres == const $CopyWithPlaceholder() || genres == null
          ? _value.genres
          // ignore: cast_nullable_to_non_nullable
          : genres as List<Genre>,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
      isPro: isPro == const $CopyWithPlaceholder() || isPro == null
          ? _value.isPro
          // ignore: cast_nullable_to_non_nullable
          : isPro as bool,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
    );
  }
}

extension $HomeStateCopyWith on HomeState {
  /// Returns a callable class that can be used as follows: `instanceOfHomeState.copyWith(...)` or like so:`instanceOfHomeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomeStateCWProxy get copyWith => _$HomeStateCWProxyImpl(this);
}

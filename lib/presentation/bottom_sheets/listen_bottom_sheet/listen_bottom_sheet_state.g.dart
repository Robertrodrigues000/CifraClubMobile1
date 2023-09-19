// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen_bottom_sheet_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListenBottomSheetStateCWProxy {
  ListenBottomSheetState youtubeVideos(List<YouTubeVideo> youtubeVideos);

  ListenBottomSheetState isLoadingYoutube(bool isLoadingYoutube);

  ListenBottomSheetState youtubeError(RequestError? youtubeError);

  ListenBottomSheetState localSongs(List<LocalSong>? localSongs);

  ListenBottomSheetState isLoadingLocalSongs(bool isLoadingLocalSongs);

  ListenBottomSheetState localSongsError(LocalSongError? localSongsError);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListenBottomSheetState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListenBottomSheetState(...).copyWith(id: 12, name: "My name")
  /// ````
  ListenBottomSheetState call({
    List<YouTubeVideo>? youtubeVideos,
    bool? isLoadingYoutube,
    RequestError? youtubeError,
    List<LocalSong>? localSongs,
    bool? isLoadingLocalSongs,
    LocalSongError? localSongsError,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfListenBottomSheetState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfListenBottomSheetState.copyWith.fieldName(...)`
class _$ListenBottomSheetStateCWProxyImpl implements _$ListenBottomSheetStateCWProxy {
  const _$ListenBottomSheetStateCWProxyImpl(this._value);

  final ListenBottomSheetState _value;

  @override
  ListenBottomSheetState youtubeVideos(List<YouTubeVideo> youtubeVideos) => this(youtubeVideos: youtubeVideos);

  @override
  ListenBottomSheetState isLoadingYoutube(bool isLoadingYoutube) => this(isLoadingYoutube: isLoadingYoutube);

  @override
  ListenBottomSheetState youtubeError(RequestError? youtubeError) => this(youtubeError: youtubeError);

  @override
  ListenBottomSheetState localSongs(List<LocalSong>? localSongs) => this(localSongs: localSongs);

  @override
  ListenBottomSheetState isLoadingLocalSongs(bool isLoadingLocalSongs) =>
      this(isLoadingLocalSongs: isLoadingLocalSongs);

  @override
  ListenBottomSheetState localSongsError(LocalSongError? localSongsError) => this(localSongsError: localSongsError);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListenBottomSheetState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListenBottomSheetState(...).copyWith(id: 12, name: "My name")
  /// ````
  ListenBottomSheetState call({
    Object? youtubeVideos = const $CopyWithPlaceholder(),
    Object? isLoadingYoutube = const $CopyWithPlaceholder(),
    Object? youtubeError = const $CopyWithPlaceholder(),
    Object? localSongs = const $CopyWithPlaceholder(),
    Object? isLoadingLocalSongs = const $CopyWithPlaceholder(),
    Object? localSongsError = const $CopyWithPlaceholder(),
  }) {
    return ListenBottomSheetState(
      youtubeVideos: youtubeVideos == const $CopyWithPlaceholder() || youtubeVideos == null
          ? _value.youtubeVideos
          // ignore: cast_nullable_to_non_nullable
          : youtubeVideos as List<YouTubeVideo>,
      isLoadingYoutube: isLoadingYoutube == const $CopyWithPlaceholder() || isLoadingYoutube == null
          ? _value.isLoadingYoutube
          // ignore: cast_nullable_to_non_nullable
          : isLoadingYoutube as bool,
      youtubeError: youtubeError == const $CopyWithPlaceholder()
          ? _value.youtubeError
          // ignore: cast_nullable_to_non_nullable
          : youtubeError as RequestError?,
      localSongs: localSongs == const $CopyWithPlaceholder()
          ? _value.localSongs
          // ignore: cast_nullable_to_non_nullable
          : localSongs as List<LocalSong>?,
      isLoadingLocalSongs: isLoadingLocalSongs == const $CopyWithPlaceholder() || isLoadingLocalSongs == null
          ? _value.isLoadingLocalSongs
          // ignore: cast_nullable_to_non_nullable
          : isLoadingLocalSongs as bool,
      localSongsError: localSongsError == const $CopyWithPlaceholder()
          ? _value.localSongsError
          // ignore: cast_nullable_to_non_nullable
          : localSongsError as LocalSongError?,
    );
  }
}

extension $ListenBottomSheetStateCopyWith on ListenBottomSheetState {
  /// Returns a callable class that can be used as follows: `instanceOfListenBottomSheetState.copyWith(...)` or like so:`instanceOfListenBottomSheetState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListenBottomSheetStateCWProxy get copyWith => _$ListenBottomSheetStateCWProxyImpl(this);
}

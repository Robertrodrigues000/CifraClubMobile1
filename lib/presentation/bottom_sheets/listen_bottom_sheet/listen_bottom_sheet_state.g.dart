// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listen_bottom_sheet_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListenBottomSheetStateCWProxy {
  ListenBottomSheetState youtubeVideos(List<YouTubeVideo> youtubeVideos);

  ListenBottomSheetState isLoadingYoutube(bool isLoadingYoutube);

  ListenBottomSheetState youtubeError(RequestError? youtubeError);

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
    );
  }
}

extension $ListenBottomSheetStateCopyWith on ListenBottomSheetState {
  /// Returns a callable class that can be used as follows: `instanceOfListenBottomSheetState.copyWith(...)` or like so:`instanceOfListenBottomSheetState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListenBottomSheetStateCWProxy get copyWith => _$ListenBottomSheetStateCWProxyImpl(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AlbumStateCWProxy {
  AlbumState discs(List<AlbumDisc> discs);

  AlbumState album(AlbumDetail? album);

  AlbumState isLoading(bool isLoading);

  AlbumState error(RequestError? error);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AlbumState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AlbumState(...).copyWith(id: 12, name: "My name")
  /// ````
  AlbumState call({
    List<AlbumDisc>? discs,
    AlbumDetail? album,
    bool? isLoading,
    RequestError? error,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAlbumState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAlbumState.copyWith.fieldName(...)`
class _$AlbumStateCWProxyImpl implements _$AlbumStateCWProxy {
  const _$AlbumStateCWProxyImpl(this._value);

  final AlbumState _value;

  @override
  AlbumState discs(List<AlbumDisc> discs) => this(discs: discs);

  @override
  AlbumState album(AlbumDetail? album) => this(album: album);

  @override
  AlbumState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  AlbumState error(RequestError? error) => this(error: error);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AlbumState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AlbumState(...).copyWith(id: 12, name: "My name")
  /// ````
  AlbumState call({
    Object? discs = const $CopyWithPlaceholder(),
    Object? album = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
  }) {
    return AlbumState(
      discs: discs == const $CopyWithPlaceholder() || discs == null
          ? _value.discs
          // ignore: cast_nullable_to_non_nullable
          : discs as List<AlbumDisc>,
      album: album == const $CopyWithPlaceholder()
          ? _value.album
          // ignore: cast_nullable_to_non_nullable
          : album as AlbumDetail?,
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

extension $AlbumStateCopyWith on AlbumState {
  /// Returns a callable class that can be used as follows: `instanceOfAlbumState.copyWith(...)` or like so:`instanceOfAlbumState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AlbumStateCWProxy get copyWith => _$AlbumStateCWProxyImpl(this);
}

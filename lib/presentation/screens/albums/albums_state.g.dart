// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albums_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AlbumsStateCWProxy {
  AlbumsState error(RequestError? error);

  AlbumsState albums(List<Album> albums);

  AlbumsState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AlbumsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AlbumsState(...).copyWith(id: 12, name: "My name")
  /// ````
  AlbumsState call({
    RequestError? error,
    List<Album>? albums,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAlbumsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAlbumsState.copyWith.fieldName(...)`
class _$AlbumsStateCWProxyImpl implements _$AlbumsStateCWProxy {
  const _$AlbumsStateCWProxyImpl(this._value);

  final AlbumsState _value;

  @override
  AlbumsState error(RequestError? error) => this(error: error);

  @override
  AlbumsState albums(List<Album> albums) => this(albums: albums);

  @override
  AlbumsState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AlbumsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AlbumsState(...).copyWith(id: 12, name: "My name")
  /// ````
  AlbumsState call({
    Object? error = const $CopyWithPlaceholder(),
    Object? albums = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return AlbumsState(
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      albums: albums == const $CopyWithPlaceholder() || albums == null
          ? _value.albums
          // ignore: cast_nullable_to_non_nullable
          : albums as List<Album>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $AlbumsStateCopyWith on AlbumsState {
  /// Returns a callable class that can be used as follows: `instanceOfAlbumsState.copyWith(...)` or like so:`instanceOfAlbumsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AlbumsStateCWProxy get copyWith => _$AlbumsStateCWProxyImpl(this);
}

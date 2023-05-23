// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ArtistStateCWProxy {
  ArtistState songs(List<int> songs);

  ArtistState albuns(List<int> albuns);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistState call({
    List<int>? songs,
    List<int>? albuns,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfArtistState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfArtistState.copyWith.fieldName(...)`
class _$ArtistStateCWProxyImpl implements _$ArtistStateCWProxy {
  const _$ArtistStateCWProxyImpl(this._value);

  final ArtistState _value;

  @override
  ArtistState songs(List<int> songs) => this(songs: songs);

  @override
  ArtistState albuns(List<int> albuns) => this(albuns: albuns);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ArtistState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ArtistState(...).copyWith(id: 12, name: "My name")
  /// ````
  ArtistState call({
    Object? songs = const $CopyWithPlaceholder(),
    Object? albuns = const $CopyWithPlaceholder(),
  }) {
    return ArtistState(
      songs: songs == const $CopyWithPlaceholder() || songs == null
          ? _value.songs
          // ignore: cast_nullable_to_non_nullable
          : songs as List<int>,
      albuns: albuns == const $CopyWithPlaceholder() || albuns == null
          ? _value.albuns
          // ignore: cast_nullable_to_non_nullable
          : albuns as List<int>,
    );
  }
}

extension $ArtistStateCopyWith on ArtistState {
  /// Returns a callable class that can be used as follows: `instanceOfArtistState.copyWith(...)` or like so:`instanceOfArtistState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ArtistStateCWProxy get copyWith => _$ArtistStateCWProxyImpl(this);
}

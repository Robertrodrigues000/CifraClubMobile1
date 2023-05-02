// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SongbookStateCWProxy {
  SongbookState selectedSongbook(Songbook? selectedSongbook);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SongbookState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SongbookState(...).copyWith(id: 12, name: "My name")
  /// ````
  SongbookState call({
    Songbook? selectedSongbook,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSongbookState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSongbookState.copyWith.fieldName(...)`
class _$SongbookStateCWProxyImpl implements _$SongbookStateCWProxy {
  const _$SongbookStateCWProxyImpl(this._value);

  final SongbookState _value;

  @override
  SongbookState selectedSongbook(Songbook? selectedSongbook) => this(selectedSongbook: selectedSongbook);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SongbookState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SongbookState(...).copyWith(id: 12, name: "My name")
  /// ````
  SongbookState call({
    Object? selectedSongbook = const $CopyWithPlaceholder(),
  }) {
    return SongbookState(
      selectedSongbook: selectedSongbook == const $CopyWithPlaceholder()
          ? _value.selectedSongbook
          // ignore: cast_nullable_to_non_nullable
          : selectedSongbook as Songbook?,
    );
  }
}

extension $SongbookStateCopyWith on SongbookState {
  /// Returns a callable class that can be used as follows: `instanceOfSongbookState.copyWith(...)` or like so:`instanceOfSongbookState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SongbookStateCWProxy get copyWith => _$SongbookStateCWProxyImpl(this);
}

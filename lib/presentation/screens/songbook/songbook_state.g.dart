// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SongbookStateCWProxy {
  SongbookState selectedSongbookId(int? selectedSongbookId);

  SongbookState userCredential(UserCredential? userCredential);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SongbookState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SongbookState(...).copyWith(id: 12, name: "My name")
  /// ````
  SongbookState call({
    int? selectedSongbookId,
    UserCredential? userCredential,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSongbookState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSongbookState.copyWith.fieldName(...)`
class _$SongbookStateCWProxyImpl implements _$SongbookStateCWProxy {
  const _$SongbookStateCWProxyImpl(this._value);

  final SongbookState _value;

  @override
  SongbookState selectedSongbookId(int? selectedSongbookId) => this(selectedSongbookId: selectedSongbookId);

  @override
  SongbookState userCredential(UserCredential? userCredential) => this(userCredential: userCredential);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SongbookState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SongbookState(...).copyWith(id: 12, name: "My name")
  /// ````
  SongbookState call({
    Object? selectedSongbookId = const $CopyWithPlaceholder(),
    Object? userCredential = const $CopyWithPlaceholder(),
  }) {
    return SongbookState(
      selectedSongbookId: selectedSongbookId == const $CopyWithPlaceholder()
          ? _value.selectedSongbookId
          // ignore: cast_nullable_to_non_nullable
          : selectedSongbookId as int?,
      userCredential: userCredential == const $CopyWithPlaceholder()
          ? _value.userCredential
          // ignore: cast_nullable_to_non_nullable
          : userCredential as UserCredential?,
    );
  }
}

extension $SongbookStateCopyWith on SongbookState {
  /// Returns a callable class that can be used as follows: `instanceOfSongbookState.copyWith(...)` or like so:`instanceOfSongbookState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SongbookStateCWProxy get copyWith => _$SongbookStateCWProxyImpl(this);
}

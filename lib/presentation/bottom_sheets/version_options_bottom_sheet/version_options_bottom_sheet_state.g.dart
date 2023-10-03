// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_options_bottom_sheet_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionOptionsBottomSheetStateCWProxy {
  VersionOptionsBottomSheetState isLoggedIn(bool isLoggedIn);

  VersionOptionsBottomSheetState isFavorite(bool isFavorite);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionOptionsBottomSheetState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionOptionsBottomSheetState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionOptionsBottomSheetState call({
    bool? isLoggedIn,
    bool? isFavorite,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersionOptionsBottomSheetState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersionOptionsBottomSheetState.copyWith.fieldName(...)`
class _$VersionOptionsBottomSheetStateCWProxyImpl implements _$VersionOptionsBottomSheetStateCWProxy {
  const _$VersionOptionsBottomSheetStateCWProxyImpl(this._value);

  final VersionOptionsBottomSheetState _value;

  @override
  VersionOptionsBottomSheetState isLoggedIn(bool isLoggedIn) => this(isLoggedIn: isLoggedIn);

  @override
  VersionOptionsBottomSheetState isFavorite(bool isFavorite) => this(isFavorite: isFavorite);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionOptionsBottomSheetState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionOptionsBottomSheetState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionOptionsBottomSheetState call({
    Object? isLoggedIn = const $CopyWithPlaceholder(),
    Object? isFavorite = const $CopyWithPlaceholder(),
  }) {
    return VersionOptionsBottomSheetState(
      isLoggedIn: isLoggedIn == const $CopyWithPlaceholder() || isLoggedIn == null
          ? _value.isLoggedIn
          // ignore: cast_nullable_to_non_nullable
          : isLoggedIn as bool,
      isFavorite: isFavorite == const $CopyWithPlaceholder() || isFavorite == null
          ? _value.isFavorite
          // ignore: cast_nullable_to_non_nullable
          : isFavorite as bool,
    );
  }
}

extension $VersionOptionsBottomSheetStateCopyWith on VersionOptionsBottomSheetState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionOptionsBottomSheetState.copyWith(...)` or like so:`instanceOfVersionOptionsBottomSheetState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionOptionsBottomSheetStateCWProxy get copyWith => _$VersionOptionsBottomSheetStateCWProxyImpl(this);
}

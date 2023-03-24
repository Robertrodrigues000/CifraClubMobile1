// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MoreStateCWProxy {
  MoreState user(User? user);

  MoreState installedApps(List<AppItem> installedApps);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MoreState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MoreState(...).copyWith(id: 12, name: "My name")
  /// ````
  MoreState call({
    User? user,
    List<AppItem>? installedApps,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMoreState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMoreState.copyWith.fieldName(...)`
class _$MoreStateCWProxyImpl implements _$MoreStateCWProxy {
  const _$MoreStateCWProxyImpl(this._value);

  final MoreState _value;

  @override
  MoreState user(User? user) => this(user: user);

  @override
  MoreState installedApps(List<AppItem> installedApps) => this(installedApps: installedApps);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MoreState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MoreState(...).copyWith(id: 12, name: "My name")
  /// ````
  MoreState call({
    Object? user = const $CopyWithPlaceholder(),
    Object? installedApps = const $CopyWithPlaceholder(),
  }) {
    return MoreState(
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
      installedApps: installedApps == const $CopyWithPlaceholder() || installedApps == null
          ? _value.installedApps
          // ignore: cast_nullable_to_non_nullable
          : installedApps as List<AppItem>,
    );
  }
}

extension $MoreStateCopyWith on MoreState {
  /// Returns a callable class that can be used as follows: `instanceOfMoreState.copyWith(...)` or like so:`instanceOfMoreState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MoreStateCWProxy get copyWith => _$MoreStateCWProxyImpl(this);
}

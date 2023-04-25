// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListsStateCWProxy {
  ListsState userLists(List<Songbook> userLists);

  ListsState specialLists(List<Songbook> specialLists);

  ListsState isSyncing(bool isSyncing);

  ListsState user(User? user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ListsState call({
    List<Songbook>? userLists,
    List<Songbook>? specialLists,
    bool? isSyncing,
    User? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfListsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfListsState.copyWith.fieldName(...)`
class _$ListsStateCWProxyImpl implements _$ListsStateCWProxy {
  const _$ListsStateCWProxyImpl(this._value);

  final ListsState _value;

  @override
  ListsState userLists(List<Songbook> userLists) => this(userLists: userLists);

  @override
  ListsState specialLists(List<Songbook> specialLists) => this(specialLists: specialLists);

  @override
  ListsState isSyncing(bool isSyncing) => this(isSyncing: isSyncing);

  @override
  ListsState user(User? user) => this(user: user);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ListsState call({
    Object? userLists = const $CopyWithPlaceholder(),
    Object? specialLists = const $CopyWithPlaceholder(),
    Object? isSyncing = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return ListsState(
      userLists: userLists == const $CopyWithPlaceholder() || userLists == null
          ? _value.userLists
          // ignore: cast_nullable_to_non_nullable
          : userLists as List<Songbook>,
      specialLists: specialLists == const $CopyWithPlaceholder() || specialLists == null
          ? _value.specialLists
          // ignore: cast_nullable_to_non_nullable
          : specialLists as List<Songbook>,
      isSyncing: isSyncing == const $CopyWithPlaceholder() || isSyncing == null
          ? _value.isSyncing
          // ignore: cast_nullable_to_non_nullable
          : isSyncing as bool,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
    );
  }
}

extension $ListsStateCopyWith on ListsState {
  /// Returns a callable class that can be used as follows: `instanceOfListsState.copyWith(...)` or like so:`instanceOfListsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListsStateCWProxy get copyWith => _$ListsStateCWProxyImpl(this);
}

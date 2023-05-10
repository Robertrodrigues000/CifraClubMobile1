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

  ListsState isError(bool? isError);

  ListsState isPro(bool isPro);

  ListsState listCount(int listCount);

  ListsState listLimit(int listLimit);

  ListsState listState(ListLimitState listState);

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
    bool? isError,
    bool? isPro,
    int? listCount,
    int? listLimit,
    ListLimitState? listState,
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
  ListsState isError(bool? isError) => this(isError: isError);

  @override
  ListsState isPro(bool isPro) => this(isPro: isPro);

  @override
  ListsState listCount(int listCount) => this(listCount: listCount);

  @override
  ListsState listLimit(int listLimit) => this(listLimit: listLimit);

  @override
  ListsState listState(ListLimitState listState) => this(listState: listState);

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
    Object? isError = const $CopyWithPlaceholder(),
    Object? isPro = const $CopyWithPlaceholder(),
    Object? listCount = const $CopyWithPlaceholder(),
    Object? listLimit = const $CopyWithPlaceholder(),
    Object? listState = const $CopyWithPlaceholder(),
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
      isError: isError == const $CopyWithPlaceholder()
          ? _value.isError
          // ignore: cast_nullable_to_non_nullable
          : isError as bool?,
      isPro: isPro == const $CopyWithPlaceholder() || isPro == null
          ? _value.isPro
          // ignore: cast_nullable_to_non_nullable
          : isPro as bool,
      listCount: listCount == const $CopyWithPlaceholder() || listCount == null
          ? _value.listCount
          // ignore: cast_nullable_to_non_nullable
          : listCount as int,
      listLimit: listLimit == const $CopyWithPlaceholder() || listLimit == null
          ? _value.listLimit
          // ignore: cast_nullable_to_non_nullable
          : listLimit as int,
      listState: listState == const $CopyWithPlaceholder() || listState == null
          ? _value.listState
          // ignore: cast_nullable_to_non_nullable
          : listState as ListLimitState,
    );
  }
}

extension $ListsStateCopyWith on ListsState {
  /// Returns a callable class that can be used as follows: `instanceOfListsState.copyWith(...)` or like so:`instanceOfListsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListsStateCWProxy get copyWith => _$ListsStateCWProxyImpl(this);
}

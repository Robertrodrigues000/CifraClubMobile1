// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lists_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ListsStateCWProxy {
  ListsState userLists(List<String> userLists);

  ListsState specialLists(List<String> specialLists);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ListsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ListsState(...).copyWith(id: 12, name: "My name")
  /// ````
  ListsState call({
    List<String>? userLists,
    List<String>? specialLists,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfListsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfListsState.copyWith.fieldName(...)`
class _$ListsStateCWProxyImpl implements _$ListsStateCWProxy {
  const _$ListsStateCWProxyImpl(this._value);

  final ListsState _value;

  @override
  ListsState userLists(List<String> userLists) => this(userLists: userLists);

  @override
  ListsState specialLists(List<String> specialLists) => this(specialLists: specialLists);

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
  }) {
    return ListsState(
      userLists: userLists == const $CopyWithPlaceholder() || userLists == null
          ? _value.userLists
          // ignore: cast_nullable_to_non_nullable
          : userLists as List<String>,
      specialLists: specialLists == const $CopyWithPlaceholder() || specialLists == null
          ? _value.specialLists
          // ignore: cast_nullable_to_non_nullable
          : specialLists as List<String>,
    );
  }
}

extension $ListsStateCopyWith on ListsState {
  /// Returns a callable class that can be used as follows: `instanceOfListsState.copyWith(...)` or like so:`instanceOfListsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ListsStateCWProxy get copyWith => _$ListsStateCWProxyImpl(this);
}

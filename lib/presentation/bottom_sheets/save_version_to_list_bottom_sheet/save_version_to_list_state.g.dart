// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_version_to_list_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SaveVersionToListStateCWProxy {
  SaveVersionToListState isLoading(bool isLoading);

  SaveVersionToListState isPro(bool isPro);

  SaveVersionToListState error(RequestError? error);

  SaveVersionToListState listState(ListLimitState listState);

  SaveVersionToListState specialLists(List<Songbook> specialLists);

  SaveVersionToListState userLists(List<Songbook> userLists);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SaveVersionToListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SaveVersionToListState(...).copyWith(id: 12, name: "My name")
  /// ````
  SaveVersionToListState call({
    bool? isLoading,
    bool? isPro,
    RequestError? error,
    ListLimitState? listState,
    List<Songbook>? specialLists,
    List<Songbook>? userLists,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSaveVersionToListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSaveVersionToListState.copyWith.fieldName(...)`
class _$SaveVersionToListStateCWProxyImpl implements _$SaveVersionToListStateCWProxy {
  const _$SaveVersionToListStateCWProxyImpl(this._value);

  final SaveVersionToListState _value;

  @override
  SaveVersionToListState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  SaveVersionToListState isPro(bool isPro) => this(isPro: isPro);

  @override
  SaveVersionToListState error(RequestError? error) => this(error: error);

  @override
  SaveVersionToListState listState(ListLimitState listState) => this(listState: listState);

  @override
  SaveVersionToListState specialLists(List<Songbook> specialLists) => this(specialLists: specialLists);

  @override
  SaveVersionToListState userLists(List<Songbook> userLists) => this(userLists: userLists);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SaveVersionToListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SaveVersionToListState(...).copyWith(id: 12, name: "My name")
  /// ````
  SaveVersionToListState call({
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? isPro = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? listState = const $CopyWithPlaceholder(),
    Object? specialLists = const $CopyWithPlaceholder(),
    Object? userLists = const $CopyWithPlaceholder(),
  }) {
    return SaveVersionToListState(
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      isPro: isPro == const $CopyWithPlaceholder() || isPro == null
          ? _value.isPro
          // ignore: cast_nullable_to_non_nullable
          : isPro as bool,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      listState: listState == const $CopyWithPlaceholder() || listState == null
          ? _value.listState
          // ignore: cast_nullable_to_non_nullable
          : listState as ListLimitState,
      specialLists: specialLists == const $CopyWithPlaceholder() || specialLists == null
          ? _value.specialLists
          // ignore: cast_nullable_to_non_nullable
          : specialLists as List<Songbook>,
      userLists: userLists == const $CopyWithPlaceholder() || userLists == null
          ? _value.userLists
          // ignore: cast_nullable_to_non_nullable
          : userLists as List<Songbook>,
    );
  }
}

extension $SaveVersionToListStateCopyWith on SaveVersionToListState {
  /// Returns a callable class that can be used as follows: `instanceOfSaveVersionToListState.copyWith(...)` or like so:`instanceOfSaveVersionToListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SaveVersionToListStateCWProxy get copyWith => _$SaveVersionToListStateCWProxyImpl(this);
}

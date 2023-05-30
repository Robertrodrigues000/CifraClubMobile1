// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cifras_to_list_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddCifrasToListStateCWProxy {
  AddCifrasToListState songs(List<SongSearch> songs);

  AddCifrasToListState isPro(bool isPro);

  AddCifrasToListState tabsLimit(int tabsLimit);

  AddCifrasToListState tabsCount(int tabsCount);

  AddCifrasToListState limitState(ListLimitState limitState);

  AddCifrasToListState selectedCifras(List<SongSearch> selectedCifras);

  AddCifrasToListState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddCifrasToListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddCifrasToListState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddCifrasToListState call({
    List<SongSearch>? songs,
    bool? isPro,
    int? tabsLimit,
    int? tabsCount,
    ListLimitState? limitState,
    List<SongSearch>? selectedCifras,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddCifrasToListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddCifrasToListState.copyWith.fieldName(...)`
class _$AddCifrasToListStateCWProxyImpl implements _$AddCifrasToListStateCWProxy {
  const _$AddCifrasToListStateCWProxyImpl(this._value);

  final AddCifrasToListState _value;

  @override
  AddCifrasToListState songs(List<SongSearch> songs) => this(songs: songs);

  @override
  AddCifrasToListState isPro(bool isPro) => this(isPro: isPro);

  @override
  AddCifrasToListState tabsLimit(int tabsLimit) => this(tabsLimit: tabsLimit);

  @override
  AddCifrasToListState tabsCount(int tabsCount) => this(tabsCount: tabsCount);

  @override
  AddCifrasToListState limitState(ListLimitState limitState) => this(limitState: limitState);

  @override
  AddCifrasToListState selectedCifras(List<SongSearch> selectedCifras) => this(selectedCifras: selectedCifras);

  @override
  AddCifrasToListState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddCifrasToListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddCifrasToListState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddCifrasToListState call({
    Object? songs = const $CopyWithPlaceholder(),
    Object? isPro = const $CopyWithPlaceholder(),
    Object? tabsLimit = const $CopyWithPlaceholder(),
    Object? tabsCount = const $CopyWithPlaceholder(),
    Object? limitState = const $CopyWithPlaceholder(),
    Object? selectedCifras = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return AddCifrasToListState(
      songs: songs == const $CopyWithPlaceholder() || songs == null
          ? _value.songs
          // ignore: cast_nullable_to_non_nullable
          : songs as List<SongSearch>,
      isPro: isPro == const $CopyWithPlaceholder() || isPro == null
          ? _value.isPro
          // ignore: cast_nullable_to_non_nullable
          : isPro as bool,
      tabsLimit: tabsLimit == const $CopyWithPlaceholder() || tabsLimit == null
          ? _value.tabsLimit
          // ignore: cast_nullable_to_non_nullable
          : tabsLimit as int,
      tabsCount: tabsCount == const $CopyWithPlaceholder() || tabsCount == null
          ? _value.tabsCount
          // ignore: cast_nullable_to_non_nullable
          : tabsCount as int,
      limitState: limitState == const $CopyWithPlaceholder() || limitState == null
          ? _value.limitState
          // ignore: cast_nullable_to_non_nullable
          : limitState as ListLimitState,
      selectedCifras: selectedCifras == const $CopyWithPlaceholder() || selectedCifras == null
          ? _value.selectedCifras
          // ignore: cast_nullable_to_non_nullable
          : selectedCifras as List<SongSearch>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $AddCifrasToListStateCopyWith on AddCifrasToListState {
  /// Returns a callable class that can be used as follows: `instanceOfAddCifrasToListState.copyWith(...)` or like so:`instanceOfAddCifrasToListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddCifrasToListStateCWProxy get copyWith => _$AddCifrasToListStateCWProxyImpl(this);
}

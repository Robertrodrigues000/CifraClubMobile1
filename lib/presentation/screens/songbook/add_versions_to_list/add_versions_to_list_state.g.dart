// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_versions_to_list_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AddVersionsToListStateCWProxy {
  AddVersionsToListState songs(List<SongSearch> songs);

  AddVersionsToListState isPro(bool isPro);

  AddVersionsToListState versionsLimit(int versionsLimit);

  AddVersionsToListState versionsCount(int versionsCount);

  AddVersionsToListState limitState(ListLimitState limitState);

  AddVersionsToListState selectedVersions(List<SongSearch> selectedVersions);

  AddVersionsToListState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddVersionsToListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddVersionsToListState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddVersionsToListState call({
    List<SongSearch>? songs,
    bool? isPro,
    int? versionsLimit,
    int? versionsCount,
    ListLimitState? limitState,
    List<SongSearch>? selectedVersions,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddVersionsToListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddVersionsToListState.copyWith.fieldName(...)`
class _$AddVersionsToListStateCWProxyImpl implements _$AddVersionsToListStateCWProxy {
  const _$AddVersionsToListStateCWProxyImpl(this._value);

  final AddVersionsToListState _value;

  @override
  AddVersionsToListState songs(List<SongSearch> songs) => this(songs: songs);

  @override
  AddVersionsToListState isPro(bool isPro) => this(isPro: isPro);

  @override
  AddVersionsToListState versionsLimit(int versionsLimit) => this(versionsLimit: versionsLimit);

  @override
  AddVersionsToListState versionsCount(int versionsCount) => this(versionsCount: versionsCount);

  @override
  AddVersionsToListState limitState(ListLimitState limitState) => this(limitState: limitState);

  @override
  AddVersionsToListState selectedVersions(List<SongSearch> selectedVersions) =>
      this(selectedVersions: selectedVersions);

  @override
  AddVersionsToListState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddVersionsToListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddVersionsToListState(...).copyWith(id: 12, name: "My name")
  /// ````
  AddVersionsToListState call({
    Object? songs = const $CopyWithPlaceholder(),
    Object? isPro = const $CopyWithPlaceholder(),
    Object? versionsLimit = const $CopyWithPlaceholder(),
    Object? versionsCount = const $CopyWithPlaceholder(),
    Object? limitState = const $CopyWithPlaceholder(),
    Object? selectedVersions = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return AddVersionsToListState(
      songs: songs == const $CopyWithPlaceholder() || songs == null
          ? _value.songs
          // ignore: cast_nullable_to_non_nullable
          : songs as List<SongSearch>,
      isPro: isPro == const $CopyWithPlaceholder() || isPro == null
          ? _value.isPro
          // ignore: cast_nullable_to_non_nullable
          : isPro as bool,
      versionsLimit: versionsLimit == const $CopyWithPlaceholder() || versionsLimit == null
          ? _value.versionsLimit
          // ignore: cast_nullable_to_non_nullable
          : versionsLimit as int,
      versionsCount: versionsCount == const $CopyWithPlaceholder() || versionsCount == null
          ? _value.versionsCount
          // ignore: cast_nullable_to_non_nullable
          : versionsCount as int,
      limitState: limitState == const $CopyWithPlaceholder() || limitState == null
          ? _value.limitState
          // ignore: cast_nullable_to_non_nullable
          : limitState as ListLimitState,
      selectedVersions: selectedVersions == const $CopyWithPlaceholder() || selectedVersions == null
          ? _value.selectedVersions
          // ignore: cast_nullable_to_non_nullable
          : selectedVersions as List<SongSearch>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $AddVersionsToListStateCopyWith on AddVersionsToListState {
  /// Returns a callable class that can be used as follows: `instanceOfAddVersionsToListState.copyWith(...)` or like so:`instanceOfAddVersionsToListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddVersionsToListStateCWProxy get copyWith => _$AddVersionsToListStateCWProxyImpl(this);
}

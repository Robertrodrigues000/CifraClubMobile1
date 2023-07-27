// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_list_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EditListStateCWProxy {
  EditListState versions(List<Version> versions);

  EditListState deletedVersions(List<Version> deletedVersions);

  EditListState hasChanges(bool hasChanges);

  EditListState songbookId(int songbookId);

  EditListState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EditListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EditListState(...).copyWith(id: 12, name: "My name")
  /// ````
  EditListState call({
    List<Version>? versions,
    List<Version>? deletedVersions,
    bool? hasChanges,
    int? songbookId,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEditListState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEditListState.copyWith.fieldName(...)`
class _$EditListStateCWProxyImpl implements _$EditListStateCWProxy {
  const _$EditListStateCWProxyImpl(this._value);

  final EditListState _value;

  @override
  EditListState versions(List<Version> versions) => this(versions: versions);

  @override
  EditListState deletedVersions(List<Version> deletedVersions) => this(deletedVersions: deletedVersions);

  @override
  EditListState hasChanges(bool hasChanges) => this(hasChanges: hasChanges);

  @override
  EditListState songbookId(int songbookId) => this(songbookId: songbookId);

  @override
  EditListState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EditListState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EditListState(...).copyWith(id: 12, name: "My name")
  /// ````
  EditListState call({
    Object? versions = const $CopyWithPlaceholder(),
    Object? deletedVersions = const $CopyWithPlaceholder(),
    Object? hasChanges = const $CopyWithPlaceholder(),
    Object? songbookId = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return EditListState(
      versions: versions == const $CopyWithPlaceholder() || versions == null
          ? _value.versions
          // ignore: cast_nullable_to_non_nullable
          : versions as List<Version>,
      deletedVersions: deletedVersions == const $CopyWithPlaceholder() || deletedVersions == null
          ? _value.deletedVersions
          // ignore: cast_nullable_to_non_nullable
          : deletedVersions as List<Version>,
      hasChanges: hasChanges == const $CopyWithPlaceholder() || hasChanges == null
          ? _value.hasChanges
          // ignore: cast_nullable_to_non_nullable
          : hasChanges as bool,
      songbookId: songbookId == const $CopyWithPlaceholder() || songbookId == null
          ? _value.songbookId
          // ignore: cast_nullable_to_non_nullable
          : songbookId as int,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $EditListStateCopyWith on EditListState {
  /// Returns a callable class that can be used as follows: `instanceOfEditListState.copyWith(...)` or like so:`instanceOfEditListState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EditListStateCWProxy get copyWith => _$EditListStateCWProxyImpl(this);
}

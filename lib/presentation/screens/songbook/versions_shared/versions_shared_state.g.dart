// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versions_shared_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionsSharedStateCWProxy {
  VersionsSharedState versions(List<Version> versions);

  VersionsSharedState songbook(Songbook? songbook);

  VersionsSharedState error(RequestError? error);

  VersionsSharedState selectedListOrderType(ListOrderType selectedListOrderType);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionsSharedState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionsSharedState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionsSharedState call({
    List<Version>? versions,
    Songbook? songbook,
    RequestError? error,
    ListOrderType? selectedListOrderType,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersionsSharedState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersionsSharedState.copyWith.fieldName(...)`
class _$VersionsSharedStateCWProxyImpl implements _$VersionsSharedStateCWProxy {
  const _$VersionsSharedStateCWProxyImpl(this._value);

  final VersionsSharedState _value;

  @override
  VersionsSharedState versions(List<Version> versions) => this(versions: versions);

  @override
  VersionsSharedState songbook(Songbook? songbook) => this(songbook: songbook);

  @override
  VersionsSharedState error(RequestError? error) => this(error: error);

  @override
  VersionsSharedState selectedListOrderType(ListOrderType selectedListOrderType) =>
      this(selectedListOrderType: selectedListOrderType);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionsSharedState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionsSharedState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionsSharedState call({
    Object? versions = const $CopyWithPlaceholder(),
    Object? songbook = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? selectedListOrderType = const $CopyWithPlaceholder(),
  }) {
    return VersionsSharedState(
      versions: versions == const $CopyWithPlaceholder() || versions == null
          ? _value.versions
          // ignore: cast_nullable_to_non_nullable
          : versions as List<Version>,
      songbook: songbook == const $CopyWithPlaceholder()
          ? _value.songbook
          // ignore: cast_nullable_to_non_nullable
          : songbook as Songbook?,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      selectedListOrderType: selectedListOrderType == const $CopyWithPlaceholder() || selectedListOrderType == null
          ? _value.selectedListOrderType
          // ignore: cast_nullable_to_non_nullable
          : selectedListOrderType as ListOrderType,
    );
  }
}

extension $VersionsSharedStateCopyWith on VersionsSharedState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionsSharedState.copyWith(...)` or like so:`instanceOfVersionsSharedState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionsSharedStateCWProxy get copyWith => _$VersionsSharedStateCWProxyImpl(this);
}

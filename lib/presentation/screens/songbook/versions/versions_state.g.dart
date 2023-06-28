// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versions_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionsStateCWProxy {
  VersionsState versions(List<Version> versions);

  VersionsState isPublic(bool isPublic);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionsState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionsState call({
    List<Version>? versions,
    bool? isPublic,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersionsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersionsState.copyWith.fieldName(...)`
class _$VersionsStateCWProxyImpl implements _$VersionsStateCWProxy {
  const _$VersionsStateCWProxyImpl(this._value);

  final VersionsState _value;

  @override
  VersionsState versions(List<Version> versions) => this(versions: versions);

  @override
  VersionsState isPublic(bool isPublic) => this(isPublic: isPublic);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionsState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionsState call({
    Object? versions = const $CopyWithPlaceholder(),
    Object? isPublic = const $CopyWithPlaceholder(),
  }) {
    return VersionsState(
      versions: versions == const $CopyWithPlaceholder() || versions == null
          ? _value.versions
          // ignore: cast_nullable_to_non_nullable
          : versions as List<Version>,
      isPublic: isPublic == const $CopyWithPlaceholder() || isPublic == null
          ? _value.isPublic
          // ignore: cast_nullable_to_non_nullable
          : isPublic as bool,
    );
  }
}

extension $VersionsStateCopyWith on VersionsState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionsState.copyWith(...)` or like so:`instanceOfVersionsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionsStateCWProxy get copyWith => _$VersionsStateCWProxyImpl(this);
}

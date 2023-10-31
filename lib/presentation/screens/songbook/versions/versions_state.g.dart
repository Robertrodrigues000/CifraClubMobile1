// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'versions_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionsStateCWProxy {
  VersionsState versions(List<Version> versions);

  VersionsState songbook(Songbook? songbook);

  VersionsState versionLimitState(ListLimitState versionLimitState);

  VersionsState isPro(bool isPro);

  VersionsState versionsLimit(int versionsLimit);

  VersionsState versionsCount(int versionsCount);

  VersionsState selectedListOrderType(ListOrderType selectedListOrderType);

  VersionsState proLimit(int proLimit);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionsState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionsState call({
    List<Version>? versions,
    Songbook? songbook,
    ListLimitState? versionLimitState,
    bool? isPro,
    int? versionsLimit,
    int? versionsCount,
    ListOrderType? selectedListOrderType,
    int? proLimit,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersionsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersionsState.copyWith.fieldName(...)`
class _$VersionsStateCWProxyImpl implements _$VersionsStateCWProxy {
  const _$VersionsStateCWProxyImpl(this._value);

  final VersionsState _value;

  @override
  VersionsState versions(List<Version> versions) => this(versions: versions);

  @override
  VersionsState songbook(Songbook? songbook) => this(songbook: songbook);

  @override
  VersionsState versionLimitState(ListLimitState versionLimitState) => this(versionLimitState: versionLimitState);

  @override
  VersionsState isPro(bool isPro) => this(isPro: isPro);

  @override
  VersionsState versionsLimit(int versionsLimit) => this(versionsLimit: versionsLimit);

  @override
  VersionsState versionsCount(int versionsCount) => this(versionsCount: versionsCount);

  @override
  VersionsState selectedListOrderType(ListOrderType selectedListOrderType) =>
      this(selectedListOrderType: selectedListOrderType);

  @override
  VersionsState proLimit(int proLimit) => this(proLimit: proLimit);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VersionsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VersionsState(...).copyWith(id: 12, name: "My name")
  /// ````
  VersionsState call({
    Object? versions = const $CopyWithPlaceholder(),
    Object? songbook = const $CopyWithPlaceholder(),
    Object? versionLimitState = const $CopyWithPlaceholder(),
    Object? isPro = const $CopyWithPlaceholder(),
    Object? versionsLimit = const $CopyWithPlaceholder(),
    Object? versionsCount = const $CopyWithPlaceholder(),
    Object? selectedListOrderType = const $CopyWithPlaceholder(),
    Object? proLimit = const $CopyWithPlaceholder(),
  }) {
    return VersionsState(
      versions: versions == const $CopyWithPlaceholder() || versions == null
          ? _value.versions
          // ignore: cast_nullable_to_non_nullable
          : versions as List<Version>,
      songbook: songbook == const $CopyWithPlaceholder()
          ? _value.songbook
          // ignore: cast_nullable_to_non_nullable
          : songbook as Songbook?,
      versionLimitState: versionLimitState == const $CopyWithPlaceholder() || versionLimitState == null
          ? _value.versionLimitState
          // ignore: cast_nullable_to_non_nullable
          : versionLimitState as ListLimitState,
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
      selectedListOrderType: selectedListOrderType == const $CopyWithPlaceholder() || selectedListOrderType == null
          ? _value.selectedListOrderType
          // ignore: cast_nullable_to_non_nullable
          : selectedListOrderType as ListOrderType,
      proLimit: proLimit == const $CopyWithPlaceholder() || proLimit == null
          ? _value.proLimit
          // ignore: cast_nullable_to_non_nullable
          : proLimit as int,
    );
  }
}

extension $VersionsStateCopyWith on VersionsState {
  /// Returns a callable class that can be used as follows: `instanceOfVersionsState.copyWith(...)` or like so:`instanceOfVersionsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionsStateCWProxy get copyWith => _$VersionsStateCWProxyImpl(this);
}

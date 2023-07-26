// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchStateCWProxy {
  SearchState versions(List<Version> versions);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    List<Version>? versions,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearchState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearchState.copyWith.fieldName(...)`
class _$SearchStateCWProxyImpl implements _$SearchStateCWProxy {
  const _$SearchStateCWProxyImpl(this._value);

  final SearchState _value;

  @override
  SearchState versions(List<Version> versions) => this(versions: versions);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    Object? versions = const $CopyWithPlaceholder(),
  }) {
    return SearchState(
      versions: versions == const $CopyWithPlaceholder() || versions == null
          ? _value.versions
          // ignore: cast_nullable_to_non_nullable
          : versions as List<Version>,
    );
  }
}

extension $SearchStateCopyWith on SearchState {
  /// Returns a callable class that can be used as follows: `instanceOfSearchState.copyWith(...)` or like so:`instanceOfSearchState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SearchStateCWProxy get copyWith => _$SearchStateCWProxyImpl(this);
}

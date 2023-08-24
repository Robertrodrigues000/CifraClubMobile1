// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SearchStateCWProxy {
  SearchState recent(List<Version> recent);

  SearchState result(List<Search> result);

  SearchState error(RequestError? error);

  SearchState isLoading(bool isLoading);

  SearchState shouldShowRecent(bool shouldShowRecent);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    List<Version>? recent,
    List<Search>? result,
    RequestError? error,
    bool? isLoading,
    bool? shouldShowRecent,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSearchState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSearchState.copyWith.fieldName(...)`
class _$SearchStateCWProxyImpl implements _$SearchStateCWProxy {
  const _$SearchStateCWProxyImpl(this._value);

  final SearchState _value;

  @override
  SearchState recent(List<Version> recent) => this(recent: recent);

  @override
  SearchState result(List<Search> result) => this(result: result);

  @override
  SearchState error(RequestError? error) => this(error: error);

  @override
  SearchState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override
  SearchState shouldShowRecent(bool shouldShowRecent) => this(shouldShowRecent: shouldShowRecent);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SearchState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SearchState(...).copyWith(id: 12, name: "My name")
  /// ````
  SearchState call({
    Object? recent = const $CopyWithPlaceholder(),
    Object? result = const $CopyWithPlaceholder(),
    Object? error = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
    Object? shouldShowRecent = const $CopyWithPlaceholder(),
  }) {
    return SearchState(
      recent: recent == const $CopyWithPlaceholder() || recent == null
          ? _value.recent
          // ignore: cast_nullable_to_non_nullable
          : recent as List<Version>,
      result: result == const $CopyWithPlaceholder() || result == null
          ? _value.result
          // ignore: cast_nullable_to_non_nullable
          : result as List<Search>,
      error: error == const $CopyWithPlaceholder()
          ? _value.error
          // ignore: cast_nullable_to_non_nullable
          : error as RequestError?,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
      shouldShowRecent: shouldShowRecent == const $CopyWithPlaceholder() || shouldShowRecent == null
          ? _value.shouldShowRecent
          // ignore: cast_nullable_to_non_nullable
          : shouldShowRecent as bool,
    );
  }
}

extension $SearchStateCopyWith on SearchState {
  /// Returns a callable class that can be used as follows: `instanceOfSearchState.copyWith(...)` or like so:`instanceOfSearchState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SearchStateCWProxy get copyWith => _$SearchStateCWProxyImpl(this);
}

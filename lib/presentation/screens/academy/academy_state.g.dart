// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academy_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AcademyStateCWProxy {
  AcademyState isAcademyInstalled(bool isAcademyInstalled);

  AcademyState instructors(List<String> instructors);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AcademyState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AcademyState(...).copyWith(id: 12, name: "My name")
  /// ````
  AcademyState call({
    bool? isAcademyInstalled,
    List<String>? instructors,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAcademyState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAcademyState.copyWith.fieldName(...)`
class _$AcademyStateCWProxyImpl implements _$AcademyStateCWProxy {
  const _$AcademyStateCWProxyImpl(this._value);

  final AcademyState _value;

  @override
  AcademyState isAcademyInstalled(bool isAcademyInstalled) => this(isAcademyInstalled: isAcademyInstalled);

  @override
  AcademyState instructors(List<String> instructors) => this(instructors: instructors);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AcademyState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AcademyState(...).copyWith(id: 12, name: "My name")
  /// ````
  AcademyState call({
    Object? isAcademyInstalled = const $CopyWithPlaceholder(),
    Object? instructors = const $CopyWithPlaceholder(),
  }) {
    return AcademyState(
      isAcademyInstalled: isAcademyInstalled == const $CopyWithPlaceholder() || isAcademyInstalled == null
          ? _value.isAcademyInstalled
          // ignore: cast_nullable_to_non_nullable
          : isAcademyInstalled as bool,
      instructors: instructors == const $CopyWithPlaceholder() || instructors == null
          ? _value.instructors
          // ignore: cast_nullable_to_non_nullable
          : instructors as List<String>,
    );
  }
}

extension $AcademyStateCopyWith on AcademyState {
  /// Returns a callable class that can be used as follows: `instanceOfAcademyState.copyWith(...)` or like so:`instanceOfAcademyState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AcademyStateCWProxy get copyWith => _$AcademyStateCWProxyImpl(this);
}

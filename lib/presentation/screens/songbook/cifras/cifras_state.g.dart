// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cifras_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CifrasStateCWProxy {
  CifrasState cifras(List<Cifra> cifras);

  CifrasState isPublic(bool isPublic);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CifrasState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CifrasState(...).copyWith(id: 12, name: "My name")
  /// ````
  CifrasState call({
    List<Cifra>? cifras,
    bool? isPublic,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCifrasState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCifrasState.copyWith.fieldName(...)`
class _$CifrasStateCWProxyImpl implements _$CifrasStateCWProxy {
  const _$CifrasStateCWProxyImpl(this._value);

  final CifrasState _value;

  @override
  CifrasState cifras(List<Cifra> cifras) => this(cifras: cifras);

  @override
  CifrasState isPublic(bool isPublic) => this(isPublic: isPublic);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CifrasState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CifrasState(...).copyWith(id: 12, name: "My name")
  /// ````
  CifrasState call({
    Object? cifras = const $CopyWithPlaceholder(),
    Object? isPublic = const $CopyWithPlaceholder(),
  }) {
    return CifrasState(
      cifras: cifras == const $CopyWithPlaceholder() || cifras == null
          ? _value.cifras
          // ignore: cast_nullable_to_non_nullable
          : cifras as List<Cifra>,
      isPublic: isPublic == const $CopyWithPlaceholder() || isPublic == null
          ? _value.isPublic
          // ignore: cast_nullable_to_non_nullable
          : isPublic as bool,
    );
  }
}

extension $CifrasStateCopyWith on CifrasState {
  /// Returns a callable class that can be used as follows: `instanceOfCifrasState.copyWith(...)` or like so:`instanceOfCifrasState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CifrasStateCWProxy get copyWith => _$CifrasStateCWProxyImpl(this);
}

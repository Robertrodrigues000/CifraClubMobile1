// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cifras_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CifrasStateCWProxy {
  CifrasState cifras(List<Cifra> cifras);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CifrasState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CifrasState(...).copyWith(id: 12, name: "My name")
  /// ````
  CifrasState call({
    List<Cifra>? cifras,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCifrasState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCifrasState.copyWith.fieldName(...)`
class _$CifrasStateCWProxyImpl implements _$CifrasStateCWProxy {
  const _$CifrasStateCWProxyImpl(this._value);

  final CifrasState _value;

  @override
  CifrasState cifras(List<Cifra> cifras) => this(cifras: cifras);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CifrasState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CifrasState(...).copyWith(id: 12, name: "My name")
  /// ````
  CifrasState call({
    Object? cifras = const $CopyWithPlaceholder(),
  }) {
    return CifrasState(
      cifras: cifras == const $CopyWithPlaceholder() || cifras == null
          ? _value.cifras
          // ignore: cast_nullable_to_non_nullable
          : cifras as List<Cifra>,
    );
  }
}

extension $CifrasStateCopyWith on CifrasState {
  /// Returns a callable class that can be used as follows: `instanceOfCifrasState.copyWith(...)` or like so:`instanceOfCifrasState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CifrasStateCWProxy get copyWith => _$CifrasStateCWProxyImpl(this);
}

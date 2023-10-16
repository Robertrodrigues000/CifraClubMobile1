// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instrument_version.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InstrumentVersionCWProxy {
  InstrumentVersion id(int id);

  InstrumentVersion versionName(String versionName);

  InstrumentVersion versionUrl(String versionUrl);

  InstrumentVersion videoLesson(VersionDataVideoLesson? videoLesson);

  InstrumentVersion completePath(String completePath);

  InstrumentVersion isVerified(bool isVerified);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InstrumentVersion(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InstrumentVersion(...).copyWith(id: 12, name: "My name")
  /// ````
  InstrumentVersion call({
    int? id,
    String? versionName,
    String? versionUrl,
    VersionDataVideoLesson? videoLesson,
    String? completePath,
    bool? isVerified,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInstrumentVersion.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInstrumentVersion.copyWith.fieldName(...)`
class _$InstrumentVersionCWProxyImpl implements _$InstrumentVersionCWProxy {
  const _$InstrumentVersionCWProxyImpl(this._value);

  final InstrumentVersion _value;

  @override
  InstrumentVersion id(int id) => this(id: id);

  @override
  InstrumentVersion versionName(String versionName) => this(versionName: versionName);

  @override
  InstrumentVersion versionUrl(String versionUrl) => this(versionUrl: versionUrl);

  @override
  InstrumentVersion videoLesson(VersionDataVideoLesson? videoLesson) => this(videoLesson: videoLesson);

  @override
  InstrumentVersion completePath(String completePath) => this(completePath: completePath);

  @override
  InstrumentVersion isVerified(bool isVerified) => this(isVerified: isVerified);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InstrumentVersion(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InstrumentVersion(...).copyWith(id: 12, name: "My name")
  /// ````
  InstrumentVersion call({
    Object? id = const $CopyWithPlaceholder(),
    Object? versionName = const $CopyWithPlaceholder(),
    Object? versionUrl = const $CopyWithPlaceholder(),
    Object? videoLesson = const $CopyWithPlaceholder(),
    Object? completePath = const $CopyWithPlaceholder(),
    Object? isVerified = const $CopyWithPlaceholder(),
  }) {
    return InstrumentVersion(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      versionName: versionName == const $CopyWithPlaceholder() || versionName == null
          ? _value.versionName
          // ignore: cast_nullable_to_non_nullable
          : versionName as String,
      versionUrl: versionUrl == const $CopyWithPlaceholder() || versionUrl == null
          ? _value.versionUrl
          // ignore: cast_nullable_to_non_nullable
          : versionUrl as String,
      videoLesson: videoLesson == const $CopyWithPlaceholder()
          ? _value.videoLesson
          // ignore: cast_nullable_to_non_nullable
          : videoLesson as VersionDataVideoLesson?,
      completePath: completePath == const $CopyWithPlaceholder() || completePath == null
          ? _value.completePath
          // ignore: cast_nullable_to_non_nullable
          : completePath as String,
      isVerified: isVerified == const $CopyWithPlaceholder() || isVerified == null
          ? _value.isVerified
          // ignore: cast_nullable_to_non_nullable
          : isVerified as bool,
    );
  }
}

extension $InstrumentVersionCopyWith on InstrumentVersion {
  /// Returns a callable class that can be used as follows: `instanceOfInstrumentVersion.copyWith(...)` or like so:`instanceOfInstrumentVersion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InstrumentVersionCWProxy get copyWith => _$InstrumentVersionCWProxyImpl(this);
}

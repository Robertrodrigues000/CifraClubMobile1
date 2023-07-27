// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionCWProxy {
  Version localDatabaseID(int? localDatabaseID);

  Version remoteDatabaseID(int? remoteDatabaseID);

  Version songId(int songId);

  Version versionId(int versionId);

  Version type(int type);

  Version name(String name);

  Version songUrl(String songUrl);

  Version tone(String? tone);

  Version stdTone(String? stdTone);

  Version capo(int? capo);

  Version tuning(String? tuning);

  Version artist(Artist artist);

  Version order(int order);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Version(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Version(...).copyWith(id: 12, name: "My name")
  /// ````
  Version call({
    int? localDatabaseID,
    int? remoteDatabaseID,
    int? songId,
    int? versionId,
    int? type,
    String? name,
    String? songUrl,
    String? tone,
    String? stdTone,
    int? capo,
    String? tuning,
    Artist? artist,
    int? order,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVersion.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVersion.copyWith.fieldName(...)`
class _$VersionCWProxyImpl implements _$VersionCWProxy {
  const _$VersionCWProxyImpl(this._value);

  final Version _value;

  @override
  Version localDatabaseID(int? localDatabaseID) => this(localDatabaseID: localDatabaseID);

  @override
  Version remoteDatabaseID(int? remoteDatabaseID) => this(remoteDatabaseID: remoteDatabaseID);

  @override
  Version songId(int songId) => this(songId: songId);

  @override
  Version versionId(int versionId) => this(versionId: versionId);

  @override
  Version type(int type) => this(type: type);

  @override
  Version name(String name) => this(name: name);

  @override
  Version songUrl(String songUrl) => this(songUrl: songUrl);

  @override
  Version tone(String? tone) => this(tone: tone);

  @override
  Version stdTone(String? stdTone) => this(stdTone: stdTone);

  @override
  Version capo(int? capo) => this(capo: capo);

  @override
  Version tuning(String? tuning) => this(tuning: tuning);

  @override
  Version artist(Artist artist) => this(artist: artist);

  @override
  Version order(int order) => this(order: order);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Version(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Version(...).copyWith(id: 12, name: "My name")
  /// ````
  Version call({
    Object? localDatabaseID = const $CopyWithPlaceholder(),
    Object? remoteDatabaseID = const $CopyWithPlaceholder(),
    Object? songId = const $CopyWithPlaceholder(),
    Object? versionId = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? songUrl = const $CopyWithPlaceholder(),
    Object? tone = const $CopyWithPlaceholder(),
    Object? stdTone = const $CopyWithPlaceholder(),
    Object? capo = const $CopyWithPlaceholder(),
    Object? tuning = const $CopyWithPlaceholder(),
    Object? artist = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return Version(
      localDatabaseID: localDatabaseID == const $CopyWithPlaceholder()
          ? _value.localDatabaseID
          // ignore: cast_nullable_to_non_nullable
          : localDatabaseID as int?,
      remoteDatabaseID: remoteDatabaseID == const $CopyWithPlaceholder()
          ? _value.remoteDatabaseID
          // ignore: cast_nullable_to_non_nullable
          : remoteDatabaseID as int?,
      songId: songId == const $CopyWithPlaceholder() || songId == null
          ? _value.songId
          // ignore: cast_nullable_to_non_nullable
          : songId as int,
      versionId: versionId == const $CopyWithPlaceholder() || versionId == null
          ? _value.versionId
          // ignore: cast_nullable_to_non_nullable
          : versionId as int,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      songUrl: songUrl == const $CopyWithPlaceholder() || songUrl == null
          ? _value.songUrl
          // ignore: cast_nullable_to_non_nullable
          : songUrl as String,
      tone: tone == const $CopyWithPlaceholder()
          ? _value.tone
          // ignore: cast_nullable_to_non_nullable
          : tone as String?,
      stdTone: stdTone == const $CopyWithPlaceholder()
          ? _value.stdTone
          // ignore: cast_nullable_to_non_nullable
          : stdTone as String?,
      capo: capo == const $CopyWithPlaceholder()
          ? _value.capo
          // ignore: cast_nullable_to_non_nullable
          : capo as int?,
      tuning: tuning == const $CopyWithPlaceholder()
          ? _value.tuning
          // ignore: cast_nullable_to_non_nullable
          : tuning as String?,
      artist: artist == const $CopyWithPlaceholder() || artist == null
          ? _value.artist
          // ignore: cast_nullable_to_non_nullable
          : artist as Artist,
      order: order == const $CopyWithPlaceholder() || order == null
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as int,
    );
  }
}

extension $VersionCopyWith on Version {
  /// Returns a callable class that can be used as follows: `instanceOfVersion.copyWith(...)` or like so:`instanceOfVersion.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VersionCWProxy get copyWith => _$VersionCWProxyImpl(this);
}

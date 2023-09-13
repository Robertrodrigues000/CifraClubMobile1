// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VersionCWProxy {
  Version localDatabaseId(int? localDatabaseId);

  Version remoteDatabaseId(int? remoteDatabaseId);

  Version lastUpdate(DateTime? lastUpdate);

  Version songId(int songId);

  Version versionId(int versionId);

  Version instrument(Instrument instrument);

  Version name(String name);

  Version songUrl(String songUrl);

  Version key(String? key);

  Version stdKey(String? stdKey);

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
    int? localDatabaseId,
    int? remoteDatabaseId,
    DateTime? lastUpdate,
    int? songId,
    int? versionId,
    Instrument? instrument,
    String? name,
    String? songUrl,
    String? key,
    String? stdKey,
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
  Version localDatabaseId(int? localDatabaseId) => this(localDatabaseId: localDatabaseId);

  @override
  Version remoteDatabaseId(int? remoteDatabaseId) => this(remoteDatabaseId: remoteDatabaseId);

  @override
  Version lastUpdate(DateTime? lastUpdate) => this(lastUpdate: lastUpdate);

  @override
  Version songId(int songId) => this(songId: songId);

  @override
  Version versionId(int versionId) => this(versionId: versionId);

  @override
  Version instrument(Instrument instrument) => this(instrument: instrument);

  @override
  Version name(String name) => this(name: name);

  @override
  Version songUrl(String songUrl) => this(songUrl: songUrl);

  @override
  Version key(String? key) => this(key: key);

  @override
  Version stdKey(String? stdKey) => this(stdKey: stdKey);

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
    Object? localDatabaseId = const $CopyWithPlaceholder(),
    Object? remoteDatabaseId = const $CopyWithPlaceholder(),
    Object? lastUpdate = const $CopyWithPlaceholder(),
    Object? songId = const $CopyWithPlaceholder(),
    Object? versionId = const $CopyWithPlaceholder(),
    Object? instrument = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? songUrl = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? stdKey = const $CopyWithPlaceholder(),
    Object? capo = const $CopyWithPlaceholder(),
    Object? tuning = const $CopyWithPlaceholder(),
    Object? artist = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return Version(
      localDatabaseId: localDatabaseId == const $CopyWithPlaceholder()
          ? _value.localDatabaseId
          // ignore: cast_nullable_to_non_nullable
          : localDatabaseId as int?,
      remoteDatabaseId: remoteDatabaseId == const $CopyWithPlaceholder()
          ? _value.remoteDatabaseId
          // ignore: cast_nullable_to_non_nullable
          : remoteDatabaseId as int?,
      lastUpdate: lastUpdate == const $CopyWithPlaceholder()
          ? _value.lastUpdate
          // ignore: cast_nullable_to_non_nullable
          : lastUpdate as DateTime?,
      songId: songId == const $CopyWithPlaceholder() || songId == null
          ? _value.songId
          // ignore: cast_nullable_to_non_nullable
          : songId as int,
      versionId: versionId == const $CopyWithPlaceholder() || versionId == null
          ? _value.versionId
          // ignore: cast_nullable_to_non_nullable
          : versionId as int,
      instrument: instrument == const $CopyWithPlaceholder() || instrument == null
          ? _value.instrument
          // ignore: cast_nullable_to_non_nullable
          : instrument as Instrument,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      songUrl: songUrl == const $CopyWithPlaceholder() || songUrl == null
          ? _value.songUrl
          // ignore: cast_nullable_to_non_nullable
          : songUrl as String,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String?,
      stdKey: stdKey == const $CopyWithPlaceholder()
          ? _value.stdKey
          // ignore: cast_nullable_to_non_nullable
          : stdKey as String?,
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

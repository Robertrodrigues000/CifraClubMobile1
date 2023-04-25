// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'songbook.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SongbookCWProxy {
  Songbook id(int? id);

  Songbook name(String name);

  Songbook userName(String? userName);

  Songbook userId(int? userId);

  Songbook thumb(String? thumb);

  Songbook isPublic(bool isPublic);

  Songbook status(int? status);

  Songbook createdAt(DateTime createdAt);

  Songbook lastUpdated(DateTime? lastUpdated);

  Songbook cifras(List<Cifra>? cifras);

  Songbook totalSongs(int totalSongs);

  Songbook type(ListType type);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Songbook(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Songbook(...).copyWith(id: 12, name: "My name")
  /// ````
  Songbook call({
    int? id,
    String? name,
    String? userName,
    int? userId,
    String? thumb,
    bool? isPublic,
    int? status,
    DateTime? createdAt,
    DateTime? lastUpdated,
    List<Cifra>? cifras,
    int? totalSongs,
    ListType? type,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSongbook.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSongbook.copyWith.fieldName(...)`
class _$SongbookCWProxyImpl implements _$SongbookCWProxy {
  const _$SongbookCWProxyImpl(this._value);

  final Songbook _value;

  @override
  Songbook id(int? id) => this(id: id);

  @override
  Songbook name(String name) => this(name: name);

  @override
  Songbook userName(String? userName) => this(userName: userName);

  @override
  Songbook userId(int? userId) => this(userId: userId);

  @override
  Songbook thumb(String? thumb) => this(thumb: thumb);

  @override
  Songbook isPublic(bool isPublic) => this(isPublic: isPublic);

  @override
  Songbook status(int? status) => this(status: status);

  @override
  Songbook createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  Songbook lastUpdated(DateTime? lastUpdated) => this(lastUpdated: lastUpdated);

  @override
  Songbook cifras(List<Cifra>? cifras) => this(cifras: cifras);

  @override
  Songbook totalSongs(int totalSongs) => this(totalSongs: totalSongs);

  @override
  Songbook type(ListType type) => this(type: type);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Songbook(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Songbook(...).copyWith(id: 12, name: "My name")
  /// ````
  Songbook call({
    Object? id = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? userName = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? thumb = const $CopyWithPlaceholder(),
    Object? isPublic = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? lastUpdated = const $CopyWithPlaceholder(),
    Object? cifras = const $CopyWithPlaceholder(),
    Object? totalSongs = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
  }) {
    return Songbook(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int?,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      userName: userName == const $CopyWithPlaceholder()
          ? _value.userName
          // ignore: cast_nullable_to_non_nullable
          : userName as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as int?,
      thumb: thumb == const $CopyWithPlaceholder()
          ? _value.thumb
          // ignore: cast_nullable_to_non_nullable
          : thumb as String?,
      isPublic: isPublic == const $CopyWithPlaceholder() || isPublic == null
          ? _value.isPublic
          // ignore: cast_nullable_to_non_nullable
          : isPublic as bool,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int?,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      lastUpdated: lastUpdated == const $CopyWithPlaceholder()
          ? _value.lastUpdated
          // ignore: cast_nullable_to_non_nullable
          : lastUpdated as DateTime?,
      cifras: cifras == const $CopyWithPlaceholder()
          ? _value.cifras
          // ignore: cast_nullable_to_non_nullable
          : cifras as List<Cifra>?,
      totalSongs: totalSongs == const $CopyWithPlaceholder() || totalSongs == null
          ? _value.totalSongs
          // ignore: cast_nullable_to_non_nullable
          : totalSongs as int,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ListType,
    );
  }
}

extension $SongbookCopyWith on Songbook {
  /// Returns a callable class that can be used as follows: `instanceOfSongbook.copyWith(...)` or like so:`instanceOfSongbook.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SongbookCWProxy get copyWith => _$SongbookCWProxyImpl(this);
}

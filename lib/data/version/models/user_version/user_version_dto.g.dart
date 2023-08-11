// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_version_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserVersionDtoCWProxy {
  UserVersionDto songUrl(String songUrl);

  UserVersionDto key(String? key);

  UserVersionDto type(int type);

  UserVersionDto name(String name);

  UserVersionDto songbookId(int songbookId);

  UserVersionDto capo(int? capo);

  UserVersionDto stdKey(String? stdKey);

  UserVersionDto tuning(String? tuning);

  UserVersionDto id(int id);

  UserVersionDto songId(int songId);

  UserVersionDto artist(UserVersionArtistDto artist);

  UserVersionDto artistImage(String? artistImage);

  UserVersionDto versionId(int versionId);

  UserVersionDto order(int order);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserVersionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserVersionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserVersionDto call({
    String? songUrl,
    String? key,
    int? type,
    String? name,
    int? songbookId,
    int? capo,
    String? stdKey,
    String? tuning,
    int? id,
    int? songId,
    UserVersionArtistDto? artist,
    String? artistImage,
    int? versionId,
    int? order,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserVersionDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserVersionDto.copyWith.fieldName(...)`
class _$UserVersionDtoCWProxyImpl implements _$UserVersionDtoCWProxy {
  const _$UserVersionDtoCWProxyImpl(this._value);

  final UserVersionDto _value;

  @override
  UserVersionDto songUrl(String songUrl) => this(songUrl: songUrl);

  @override
  UserVersionDto key(String? key) => this(key: key);

  @override
  UserVersionDto type(int type) => this(type: type);

  @override
  UserVersionDto name(String name) => this(name: name);

  @override
  UserVersionDto songbookId(int songbookId) => this(songbookId: songbookId);

  @override
  UserVersionDto capo(int? capo) => this(capo: capo);

  @override
  UserVersionDto stdKey(String? stdKey) => this(stdKey: stdKey);

  @override
  UserVersionDto tuning(String? tuning) => this(tuning: tuning);

  @override
  UserVersionDto id(int id) => this(id: id);

  @override
  UserVersionDto songId(int songId) => this(songId: songId);

  @override
  UserVersionDto artist(UserVersionArtistDto artist) => this(artist: artist);

  @override
  UserVersionDto artistImage(String? artistImage) => this(artistImage: artistImage);

  @override
  UserVersionDto versionId(int versionId) => this(versionId: versionId);

  @override
  UserVersionDto order(int order) => this(order: order);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserVersionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserVersionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserVersionDto call({
    Object? songUrl = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? songbookId = const $CopyWithPlaceholder(),
    Object? capo = const $CopyWithPlaceholder(),
    Object? stdKey = const $CopyWithPlaceholder(),
    Object? tuning = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? songId = const $CopyWithPlaceholder(),
    Object? artist = const $CopyWithPlaceholder(),
    Object? artistImage = const $CopyWithPlaceholder(),
    Object? versionId = const $CopyWithPlaceholder(),
    Object? order = const $CopyWithPlaceholder(),
  }) {
    return UserVersionDto(
      songUrl: songUrl == const $CopyWithPlaceholder() || songUrl == null
          ? _value.songUrl
          // ignore: cast_nullable_to_non_nullable
          : songUrl as String,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String?,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as int,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      songbookId: songbookId == const $CopyWithPlaceholder() || songbookId == null
          ? _value.songbookId
          // ignore: cast_nullable_to_non_nullable
          : songbookId as int,
      capo: capo == const $CopyWithPlaceholder()
          ? _value.capo
          // ignore: cast_nullable_to_non_nullable
          : capo as int?,
      stdKey: stdKey == const $CopyWithPlaceholder()
          ? _value.stdKey
          // ignore: cast_nullable_to_non_nullable
          : stdKey as String?,
      tuning: tuning == const $CopyWithPlaceholder()
          ? _value.tuning
          // ignore: cast_nullable_to_non_nullable
          : tuning as String?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      songId: songId == const $CopyWithPlaceholder() || songId == null
          ? _value.songId
          // ignore: cast_nullable_to_non_nullable
          : songId as int,
      artist: artist == const $CopyWithPlaceholder() || artist == null
          ? _value.artist
          // ignore: cast_nullable_to_non_nullable
          : artist as UserVersionArtistDto,
      artistImage: artistImage == const $CopyWithPlaceholder()
          ? _value.artistImage
          // ignore: cast_nullable_to_non_nullable
          : artistImage as String?,
      versionId: versionId == const $CopyWithPlaceholder() || versionId == null
          ? _value.versionId
          // ignore: cast_nullable_to_non_nullable
          : versionId as int,
      order: order == const $CopyWithPlaceholder() || order == null
          ? _value.order
          // ignore: cast_nullable_to_non_nullable
          : order as int,
    );
  }
}

extension $UserVersionDtoCopyWith on UserVersionDto {
  /// Returns a callable class that can be used as follows: `instanceOfUserVersionDto.copyWith(...)` or like so:`instanceOfUserVersionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserVersionDtoCWProxy get copyWith => _$UserVersionDtoCWProxyImpl(this);
}

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserVersionDtoCollection on Isar {
  IsarCollection<UserVersionDto> get userVersionDtos => this.collection();
}

const UserVersionDtoSchema = CollectionSchema(
  name: r'UserVersionDto',
  id: -7198883187160384376,
  properties: {
    r'artist': PropertySchema(
      id: 0,
      name: r'artist',
      type: IsarType.object,
      target: r'UserVersionArtistDto',
    ),
    r'artistImage': PropertySchema(
      id: 1,
      name: r'artistImage',
      type: IsarType.string,
    ),
    r'capo': PropertySchema(
      id: 2,
      name: r'capo',
      type: IsarType.long,
    ),
    r'key': PropertySchema(
      id: 3,
      name: r'key',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 4,
      name: r'name',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 5,
      name: r'order',
      type: IsarType.long,
    ),
    r'songId': PropertySchema(
      id: 6,
      name: r'songId',
      type: IsarType.long,
    ),
    r'songUrl': PropertySchema(
      id: 7,
      name: r'songUrl',
      type: IsarType.string,
    ),
    r'songbookId': PropertySchema(
      id: 8,
      name: r'songbookId',
      type: IsarType.long,
    ),
    r'stdKey': PropertySchema(
      id: 9,
      name: r'stdKey',
      type: IsarType.string,
    ),
    r'tuning': PropertySchema(
      id: 10,
      name: r'tuning',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 11,
      name: r'type',
      type: IsarType.long,
    ),
    r'versionId': PropertySchema(
      id: 12,
      name: r'versionId',
      type: IsarType.long,
    )
  },
  estimateSize: _userVersionDtoEstimateSize,
  serialize: _userVersionDtoSerialize,
  deserialize: _userVersionDtoDeserialize,
  deserializeProp: _userVersionDtoDeserializeProp,
  idName: r'id',
  indexes: {
    r'artistImage': IndexSchema(
      id: 897173347989801551,
      name: r'artistImage',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'artistImage',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'songbookId_artistImage': IndexSchema(
      id: -8465361773570508882,
      name: r'songbookId_artistImage',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'songbookId',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'artistImage',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'songbookId': IndexSchema(
      id: 4470184368099356442,
      name: r'songbookId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'songbookId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'UserVersionArtistDto': UserVersionArtistDtoSchema},
  getId: _userVersionDtoGetId,
  getLinks: _userVersionDtoGetLinks,
  attach: _userVersionDtoAttach,
  version: '3.1.0+1',
);

int _userVersionDtoEstimateSize(
  UserVersionDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount +=
      3 + UserVersionArtistDtoSchema.estimateSize(object.artist, allOffsets[UserVersionArtistDto]!, allOffsets);
  {
    final value = object.artistImage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.key;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.songUrl.length * 3;
  {
    final value = object.stdKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tuning;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userVersionDtoSerialize(
  UserVersionDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<UserVersionArtistDto>(
    offsets[0],
    allOffsets,
    UserVersionArtistDtoSchema.serialize,
    object.artist,
  );
  writer.writeString(offsets[1], object.artistImage);
  writer.writeLong(offsets[2], object.capo);
  writer.writeString(offsets[3], object.key);
  writer.writeString(offsets[4], object.name);
  writer.writeLong(offsets[5], object.order);
  writer.writeLong(offsets[6], object.songId);
  writer.writeString(offsets[7], object.songUrl);
  writer.writeLong(offsets[8], object.songbookId);
  writer.writeString(offsets[9], object.stdKey);
  writer.writeString(offsets[10], object.tuning);
  writer.writeLong(offsets[11], object.type);
  writer.writeLong(offsets[12], object.versionId);
}

UserVersionDto _userVersionDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserVersionDto(
    artist: reader.readObjectOrNull<UserVersionArtistDto>(
          offsets[0],
          UserVersionArtistDtoSchema.deserialize,
          allOffsets,
        ) ??
        UserVersionArtistDto(),
    artistImage: reader.readStringOrNull(offsets[1]),
    capo: reader.readLongOrNull(offsets[2]),
    id: id,
    key: reader.readStringOrNull(offsets[3]),
    name: reader.readString(offsets[4]),
    order: reader.readLong(offsets[5]),
    songId: reader.readLong(offsets[6]),
    songUrl: reader.readString(offsets[7]),
    songbookId: reader.readLong(offsets[8]),
    stdKey: reader.readStringOrNull(offsets[9]),
    tuning: reader.readStringOrNull(offsets[10]),
    type: reader.readLong(offsets[11]),
    versionId: reader.readLong(offsets[12]),
  );
  return object;
}

P _userVersionDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<UserVersionArtistDto>(
            offset,
            UserVersionArtistDtoSchema.deserialize,
            allOffsets,
          ) ??
          UserVersionArtistDto()) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userVersionDtoGetId(UserVersionDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userVersionDtoGetLinks(UserVersionDto object) {
  return [];
}

void _userVersionDtoAttach(IsarCollection<dynamic> col, Id id, UserVersionDto object) {}

extension UserVersionDtoQueryWhereSort on QueryBuilder<UserVersionDto, UserVersionDto, QWhere> {
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhere> anySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'songbookId'),
      );
    });
  }
}

extension UserVersionDtoQueryWhere on QueryBuilder<UserVersionDto, UserVersionDto, QWhereClause> {
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> artistImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'artistImage',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> artistImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'artistImage',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> artistImageEqualTo(String? artistImage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'artistImage',
        value: [artistImage],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> artistImageNotEqualTo(String? artistImage) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistImage',
              lower: [],
              upper: [artistImage],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistImage',
              lower: [artistImage],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistImage',
              lower: [artistImage],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'artistImage',
              lower: [],
              upper: [artistImage],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdEqualToAnyArtistImage(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId_artistImage',
        value: [songbookId],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdNotEqualToAnyArtistImage(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [],
              upper: [songbookId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [songbookId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [songbookId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [],
              upper: [songbookId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdGreaterThanAnyArtistImage(
    int songbookId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songbookId_artistImage',
        lower: [songbookId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdLessThanAnyArtistImage(
    int songbookId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songbookId_artistImage',
        lower: [],
        upper: [songbookId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdBetweenAnyArtistImage(
    int lowerSongbookId,
    int upperSongbookId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songbookId_artistImage',
        lower: [lowerSongbookId],
        includeLower: includeLower,
        upper: [upperSongbookId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdEqualToArtistImageIsNull(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId_artistImage',
        value: [songbookId, null],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdEqualToArtistImageIsNotNull(
      int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songbookId_artistImage',
        lower: [songbookId, null],
        includeLower: false,
        upper: [
          songbookId,
        ],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdArtistImageEqualTo(
      int songbookId, String? artistImage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId_artistImage',
        value: [songbookId, artistImage],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdEqualToArtistImageNotEqualTo(
      int songbookId, String? artistImage) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [songbookId],
              upper: [songbookId, artistImage],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [songbookId, artistImage],
              includeLower: false,
              upper: [songbookId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [songbookId, artistImage],
              includeLower: false,
              upper: [songbookId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId_artistImage',
              lower: [songbookId],
              upper: [songbookId, artistImage],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdEqualTo(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId',
        value: [songbookId],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdNotEqualTo(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId',
              lower: [],
              upper: [songbookId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId',
              lower: [songbookId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId',
              lower: [songbookId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'songbookId',
              lower: [],
              upper: [songbookId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdGreaterThan(
    int songbookId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songbookId',
        lower: [songbookId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdLessThan(
    int songbookId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songbookId',
        lower: [],
        upper: [songbookId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> songbookIdBetween(
    int lowerSongbookId,
    int upperSongbookId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'songbookId',
        lower: [lowerSongbookId],
        includeLower: includeLower,
        upper: [upperSongbookId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserVersionDtoQueryFilter on QueryBuilder<UserVersionDto, UserVersionDto, QFilterCondition> {
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artistImage',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artistImage',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'artistImage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artistImage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistImage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artistImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artistImage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> capoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'capo',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> capoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'capo',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> capoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> capoGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'capo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> capoLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'capo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> capoBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'capo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> orderEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> orderGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> orderLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> orderBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songbookIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songbookId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songbookIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songbookId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songbookIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songbookId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> songbookIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songbookId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stdKey',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stdKey',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stdKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stdKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stdKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tuning',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tuning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> tuningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> typeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> typeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> typeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> typeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> versionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> versionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> versionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> versionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserVersionDtoQueryObject on QueryBuilder<UserVersionDto, UserVersionDto, QFilterCondition> {
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> artist(FilterQuery<UserVersionArtistDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'artist');
    });
  }
}

extension UserVersionDtoQueryLinks on QueryBuilder<UserVersionDto, UserVersionDto, QFilterCondition> {}

extension UserVersionDtoQuerySortBy on QueryBuilder<UserVersionDto, UserVersionDto, QSortBy> {
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByArtistImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByArtistImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortBySongUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortBySongUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortBySongbookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByStdKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByStdKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }
}

extension UserVersionDtoQuerySortThenBy on QueryBuilder<UserVersionDto, UserVersionDto, QSortThenBy> {
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByArtistImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByArtistImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'order', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenBySongUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenBySongUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenBySongbookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByStdKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByStdKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }
}

extension UserVersionDtoQueryWhereDistinct on QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> {
  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByArtistImage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artistImage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capo');
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId');
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctBySongUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songbookId');
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByStdKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stdKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByTuning({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tuning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionId');
    });
  }
}

extension UserVersionDtoQueryProperty on QueryBuilder<UserVersionDto, UserVersionDto, QQueryProperty> {
  QueryBuilder<UserVersionDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserVersionDto, UserVersionArtistDto, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<UserVersionDto, String?, QQueryOperations> artistImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artistImage');
    });
  }

  QueryBuilder<UserVersionDto, int?, QQueryOperations> capoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capo');
    });
  }

  QueryBuilder<UserVersionDto, String?, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<UserVersionDto, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<UserVersionDto, int, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<UserVersionDto, int, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }

  QueryBuilder<UserVersionDto, String, QQueryOperations> songUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songUrl');
    });
  }

  QueryBuilder<UserVersionDto, int, QQueryOperations> songbookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songbookId');
    });
  }

  QueryBuilder<UserVersionDto, String?, QQueryOperations> stdKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdKey');
    });
  }

  QueryBuilder<UserVersionDto, String?, QQueryOperations> tuningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tuning');
    });
  }

  QueryBuilder<UserVersionDto, int, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<UserVersionDto, int, QQueryOperations> versionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionId');
    });
  }
}

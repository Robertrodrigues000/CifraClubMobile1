// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_version_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserVersionDtoCWProxy {
  UserVersionDto remoteDatabaseID(int? remoteDatabaseID);

  UserVersionDto songUrl(String songUrl);

  UserVersionDto tone(String? tone);

  UserVersionDto type(int type);

  UserVersionDto name(String name);

  UserVersionDto songbookId(int songbookId);

  UserVersionDto capo(int? capo);

  UserVersionDto stdTone(String? stdTone);

  UserVersionDto tuning(String? tuning);

  UserVersionDto localDatabaseID(int localDatabaseID);

  UserVersionDto songId(int songId);

  UserVersionDto artist(UserVersionArtistDto artist);

  UserVersionDto artistImage(String? artistImage);

  UserVersionDto versionId(int versionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserVersionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserVersionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserVersionDto call({
    int? remoteDatabaseID,
    String? songUrl,
    String? tone,
    int? type,
    String? name,
    int? songbookId,
    int? capo,
    String? stdTone,
    String? tuning,
    int? localDatabaseID,
    int? songId,
    UserVersionArtistDto? artist,
    String? artistImage,
    int? versionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserVersionDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserVersionDto.copyWith.fieldName(...)`
class _$UserVersionDtoCWProxyImpl implements _$UserVersionDtoCWProxy {
  const _$UserVersionDtoCWProxyImpl(this._value);

  final UserVersionDto _value;

  @override
  UserVersionDto remoteDatabaseID(int? remoteDatabaseID) => this(remoteDatabaseID: remoteDatabaseID);

  @override
  UserVersionDto songUrl(String songUrl) => this(songUrl: songUrl);

  @override
  UserVersionDto tone(String? tone) => this(tone: tone);

  @override
  UserVersionDto type(int type) => this(type: type);

  @override
  UserVersionDto name(String name) => this(name: name);

  @override
  UserVersionDto songbookId(int songbookId) => this(songbookId: songbookId);

  @override
  UserVersionDto capo(int? capo) => this(capo: capo);

  @override
  UserVersionDto stdTone(String? stdTone) => this(stdTone: stdTone);

  @override
  UserVersionDto tuning(String? tuning) => this(tuning: tuning);

  @override
  UserVersionDto localDatabaseID(int localDatabaseID) => this(localDatabaseID: localDatabaseID);

  @override
  UserVersionDto songId(int songId) => this(songId: songId);

  @override
  UserVersionDto artist(UserVersionArtistDto artist) => this(artist: artist);

  @override
  UserVersionDto artistImage(String? artistImage) => this(artistImage: artistImage);

  @override
  UserVersionDto versionId(int versionId) => this(versionId: versionId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserVersionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserVersionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserVersionDto call({
    Object? remoteDatabaseID = const $CopyWithPlaceholder(),
    Object? songUrl = const $CopyWithPlaceholder(),
    Object? tone = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? songbookId = const $CopyWithPlaceholder(),
    Object? capo = const $CopyWithPlaceholder(),
    Object? stdTone = const $CopyWithPlaceholder(),
    Object? tuning = const $CopyWithPlaceholder(),
    Object? localDatabaseID = const $CopyWithPlaceholder(),
    Object? songId = const $CopyWithPlaceholder(),
    Object? artist = const $CopyWithPlaceholder(),
    Object? artistImage = const $CopyWithPlaceholder(),
    Object? versionId = const $CopyWithPlaceholder(),
  }) {
    return UserVersionDto(
      remoteDatabaseID: remoteDatabaseID == const $CopyWithPlaceholder()
          ? _value.remoteDatabaseID
          // ignore: cast_nullable_to_non_nullable
          : remoteDatabaseID as int?,
      songUrl: songUrl == const $CopyWithPlaceholder() || songUrl == null
          ? _value.songUrl
          // ignore: cast_nullable_to_non_nullable
          : songUrl as String,
      tone: tone == const $CopyWithPlaceholder()
          ? _value.tone
          // ignore: cast_nullable_to_non_nullable
          : tone as String?,
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
      stdTone: stdTone == const $CopyWithPlaceholder()
          ? _value.stdTone
          // ignore: cast_nullable_to_non_nullable
          : stdTone as String?,
      tuning: tuning == const $CopyWithPlaceholder()
          ? _value.tuning
          // ignore: cast_nullable_to_non_nullable
          : tuning as String?,
      localDatabaseID: localDatabaseID == const $CopyWithPlaceholder() || localDatabaseID == null
          ? _value.localDatabaseID
          // ignore: cast_nullable_to_non_nullable
          : localDatabaseID as int,
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
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'remoteDatabaseID': PropertySchema(
      id: 4,
      name: r'remoteDatabaseID',
      type: IsarType.long,
    ),
    r'songId': PropertySchema(
      id: 5,
      name: r'songId',
      type: IsarType.long,
    ),
    r'songUrl': PropertySchema(
      id: 6,
      name: r'songUrl',
      type: IsarType.string,
    ),
    r'songbookId': PropertySchema(
      id: 7,
      name: r'songbookId',
      type: IsarType.long,
    ),
    r'stdTone': PropertySchema(
      id: 8,
      name: r'stdTone',
      type: IsarType.string,
    ),
    r'tone': PropertySchema(
      id: 9,
      name: r'tone',
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
  idName: r'localDatabaseID',
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
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.songUrl.length * 3;
  {
    final value = object.stdTone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tone;
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
  writer.writeString(offsets[3], object.name);
  writer.writeLong(offsets[4], object.remoteDatabaseID);
  writer.writeLong(offsets[5], object.songId);
  writer.writeString(offsets[6], object.songUrl);
  writer.writeLong(offsets[7], object.songbookId);
  writer.writeString(offsets[8], object.stdTone);
  writer.writeString(offsets[9], object.tone);
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
    localDatabaseID: id,
    name: reader.readString(offsets[3]),
    remoteDatabaseID: reader.readLongOrNull(offsets[4]),
    songId: reader.readLong(offsets[5]),
    songUrl: reader.readString(offsets[6]),
    songbookId: reader.readLong(offsets[7]),
    stdTone: reader.readStringOrNull(offsets[8]),
    tone: reader.readStringOrNull(offsets[9]),
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
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
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
  return object.localDatabaseID;
}

List<IsarLinkBase<dynamic>> _userVersionDtoGetLinks(UserVersionDto object) {
  return [];
}

void _userVersionDtoAttach(IsarCollection<dynamic> col, Id id, UserVersionDto object) {
  object.localDatabaseID = id;
}

extension UserVersionDtoQueryWhereSort on QueryBuilder<UserVersionDto, UserVersionDto, QWhere> {
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhere> anyLocalDatabaseID() {
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
  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> localDatabaseIDEqualTo(Id localDatabaseID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localDatabaseID,
        upper: localDatabaseID,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> localDatabaseIDNotEqualTo(Id localDatabaseID) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localDatabaseID, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localDatabaseID, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localDatabaseID, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localDatabaseID, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> localDatabaseIDGreaterThan(Id localDatabaseID,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localDatabaseID, includeLower: include),
      );
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> localDatabaseIDLessThan(Id localDatabaseID,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localDatabaseID, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterWhereClause> localDatabaseIDBetween(
    Id lowerLocalDatabaseID,
    Id upperLocalDatabaseID, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocalDatabaseID,
        includeLower: includeLower,
        upper: upperLocalDatabaseID,
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> localDatabaseIDEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> localDatabaseIDGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> localDatabaseIDLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> localDatabaseIDBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localDatabaseID',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> remoteDatabaseIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteDatabaseID',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> remoteDatabaseIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteDatabaseID',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> remoteDatabaseIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> remoteDatabaseIDGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> remoteDatabaseIDLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> remoteDatabaseIDBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteDatabaseID',
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stdTone',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stdTone',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdTone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stdTone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stdTone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stdTone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stdTone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stdTone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stdTone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stdTone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdTone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> stdToneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stdTone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tone',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tone',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterFilterCondition> toneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tone',
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByRemoteDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByRemoteDatabaseIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.desc);
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByStdTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByStdToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> sortByToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.desc);
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByLocalDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseID', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByLocalDatabaseIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseID', Sort.desc);
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByRemoteDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByRemoteDatabaseIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.desc);
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

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByStdTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByStdToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QAfterSortBy> thenByToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.desc);
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

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByRemoteDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteDatabaseID');
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

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByStdTone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stdTone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDto, UserVersionDto, QDistinct> distinctByTone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tone', caseSensitive: caseSensitive);
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
  QueryBuilder<UserVersionDto, int, QQueryOperations> localDatabaseIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDatabaseID');
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

  QueryBuilder<UserVersionDto, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<UserVersionDto, int?, QQueryOperations> remoteDatabaseIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteDatabaseID');
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

  QueryBuilder<UserVersionDto, String?, QQueryOperations> stdToneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdTone');
    });
  }

  QueryBuilder<UserVersionDto, String?, QQueryOperations> toneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tone');
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
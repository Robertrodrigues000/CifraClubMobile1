// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_cifra_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserCifraDtoCWProxy {
  UserCifraDto remoteDatabaseID(int? remoteDatabaseID);

  UserCifraDto songUrl(String songUrl);

  UserCifraDto tone(String? tone);

  UserCifraDto type(int type);

  UserCifraDto name(String name);

  UserCifraDto songbookId(int songbookId);

  UserCifraDto capo(int? capo);

  UserCifraDto stdTone(String? stdTone);

  UserCifraDto tuning(String? tuning);

  UserCifraDto localDatabaseID(int localDatabaseID);

  UserCifraDto songId(int songId);

  UserCifraDto artist(UserCifraArtistDto artist);

  UserCifraDto artistImage(String? artistImage);

  UserCifraDto versionId(int versionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCifraDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCifraDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCifraDto call({
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
    UserCifraArtistDto? artist,
    String? artistImage,
    int? versionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserCifraDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserCifraDto.copyWith.fieldName(...)`
class _$UserCifraDtoCWProxyImpl implements _$UserCifraDtoCWProxy {
  const _$UserCifraDtoCWProxyImpl(this._value);

  final UserCifraDto _value;

  @override
  UserCifraDto remoteDatabaseID(int? remoteDatabaseID) => this(remoteDatabaseID: remoteDatabaseID);

  @override
  UserCifraDto songUrl(String songUrl) => this(songUrl: songUrl);

  @override
  UserCifraDto tone(String? tone) => this(tone: tone);

  @override
  UserCifraDto type(int type) => this(type: type);

  @override
  UserCifraDto name(String name) => this(name: name);

  @override
  UserCifraDto songbookId(int songbookId) => this(songbookId: songbookId);

  @override
  UserCifraDto capo(int? capo) => this(capo: capo);

  @override
  UserCifraDto stdTone(String? stdTone) => this(stdTone: stdTone);

  @override
  UserCifraDto tuning(String? tuning) => this(tuning: tuning);

  @override
  UserCifraDto localDatabaseID(int localDatabaseID) => this(localDatabaseID: localDatabaseID);

  @override
  UserCifraDto songId(int songId) => this(songId: songId);

  @override
  UserCifraDto artist(UserCifraArtistDto artist) => this(artist: artist);

  @override
  UserCifraDto artistImage(String? artistImage) => this(artistImage: artistImage);

  @override
  UserCifraDto versionId(int versionId) => this(versionId: versionId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserCifraDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserCifraDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserCifraDto call({
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
    return UserCifraDto(
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
          : artist as UserCifraArtistDto,
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

extension $UserCifraDtoCopyWith on UserCifraDto {
  /// Returns a callable class that can be used as follows: `instanceOfUserCifraDto.copyWith(...)` or like so:`instanceOfUserCifraDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserCifraDtoCWProxy get copyWith => _$UserCifraDtoCWProxyImpl(this);
}

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserCifraDtoCollection on Isar {
  IsarCollection<UserCifraDto> get userCifraDtos => this.collection();
}

const UserCifraDtoSchema = CollectionSchema(
  name: r'UserCifraDto',
  id: -8761160610546830687,
  properties: {
    r'artist': PropertySchema(
      id: 0,
      name: r'artist',
      type: IsarType.object,
      target: r'UserCifraArtistDto',
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
  estimateSize: _userCifraDtoEstimateSize,
  serialize: _userCifraDtoSerialize,
  deserialize: _userCifraDtoDeserialize,
  deserializeProp: _userCifraDtoDeserializeProp,
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
  embeddedSchemas: {r'UserCifraArtistDto': UserCifraArtistDtoSchema},
  getId: _userCifraDtoGetId,
  getLinks: _userCifraDtoGetLinks,
  attach: _userCifraDtoAttach,
  version: '3.1.0+1',
);

int _userCifraDtoEstimateSize(
  UserCifraDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + UserCifraArtistDtoSchema.estimateSize(object.artist, allOffsets[UserCifraArtistDto]!, allOffsets);
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

void _userCifraDtoSerialize(
  UserCifraDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<UserCifraArtistDto>(
    offsets[0],
    allOffsets,
    UserCifraArtistDtoSchema.serialize,
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

UserCifraDto _userCifraDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserCifraDto(
    artist: reader.readObjectOrNull<UserCifraArtistDto>(
          offsets[0],
          UserCifraArtistDtoSchema.deserialize,
          allOffsets,
        ) ??
        UserCifraArtistDto(),
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

P _userCifraDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<UserCifraArtistDto>(
            offset,
            UserCifraArtistDtoSchema.deserialize,
            allOffsets,
          ) ??
          UserCifraArtistDto()) as P;
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

Id _userCifraDtoGetId(UserCifraDto object) {
  return object.localDatabaseID;
}

List<IsarLinkBase<dynamic>> _userCifraDtoGetLinks(UserCifraDto object) {
  return [];
}

void _userCifraDtoAttach(IsarCollection<dynamic> col, Id id, UserCifraDto object) {
  object.localDatabaseID = id;
}

extension UserCifraDtoQueryWhereSort on QueryBuilder<UserCifraDto, UserCifraDto, QWhere> {
  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhere> anyLocalDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhere> anySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'songbookId'),
      );
    });
  }
}

extension UserCifraDtoQueryWhere on QueryBuilder<UserCifraDto, UserCifraDto, QWhereClause> {
  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> localDatabaseIDEqualTo(Id localDatabaseID) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localDatabaseID,
        upper: localDatabaseID,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> localDatabaseIDNotEqualTo(Id localDatabaseID) {
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> localDatabaseIDGreaterThan(Id localDatabaseID,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localDatabaseID, includeLower: include),
      );
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> localDatabaseIDLessThan(Id localDatabaseID,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localDatabaseID, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> localDatabaseIDBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> artistImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'artistImage',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> artistImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'artistImage',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> artistImageEqualTo(String? artistImage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'artistImage',
        value: [artistImage],
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> artistImageNotEqualTo(String? artistImage) {
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdEqualToAnyArtistImage(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId_artistImage',
        value: [songbookId],
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdNotEqualToAnyArtistImage(int songbookId) {
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdGreaterThanAnyArtistImage(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdLessThanAnyArtistImage(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdBetweenAnyArtistImage(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdEqualToArtistImageIsNull(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId_artistImage',
        value: [songbookId, null],
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdEqualToArtistImageIsNotNull(int songbookId) {
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdArtistImageEqualTo(
      int songbookId, String? artistImage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId_artistImage',
        value: [songbookId, artistImage],
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdEqualToArtistImageNotEqualTo(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdEqualTo(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId',
        value: [songbookId],
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdNotEqualTo(int songbookId) {
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterWhereClause> songbookIdBetween(
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

extension UserCifraDtoQueryFilter on QueryBuilder<UserCifraDto, UserCifraDto, QFilterCondition> {
  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artistImage',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artistImage',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageEqualTo(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageStartsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageEndsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artistImage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistImage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artistImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artistImage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> capoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'capo',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> capoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'capo',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> capoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> capoGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> capoLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> capoBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> localDatabaseIDEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> localDatabaseIDGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> localDatabaseIDLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> localDatabaseIDBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> remoteDatabaseIDIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteDatabaseID',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> remoteDatabaseIDIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteDatabaseID',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> remoteDatabaseIDEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteDatabaseID',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> remoteDatabaseIDGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> remoteDatabaseIDLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> remoteDatabaseIDBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songIdGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songIdLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songIdBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlEqualTo(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlStartsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlEndsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songbookIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songbookId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songbookIdGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songbookIdLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> songbookIdBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stdTone',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stdTone',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneEqualTo(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneStartsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneEndsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stdTone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stdTone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdTone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> stdToneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stdTone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tone',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tone',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneEqualTo(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneStartsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneEndsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> toneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tone',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningEqualTo(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningStartsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningEndsWith(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tuning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> tuningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> typeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> typeGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> typeLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> typeBetween(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> versionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> versionIdGreaterThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> versionIdLessThan(
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

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> versionIdBetween(
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

extension UserCifraDtoQueryObject on QueryBuilder<UserCifraDto, UserCifraDto, QFilterCondition> {
  QueryBuilder<UserCifraDto, UserCifraDto, QAfterFilterCondition> artist(FilterQuery<UserCifraArtistDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'artist');
    });
  }
}

extension UserCifraDtoQueryLinks on QueryBuilder<UserCifraDto, UserCifraDto, QFilterCondition> {}

extension UserCifraDtoQuerySortBy on QueryBuilder<UserCifraDto, UserCifraDto, QSortBy> {
  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByArtistImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByArtistImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByRemoteDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByRemoteDatabaseIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortBySongUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortBySongUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortBySongbookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByStdTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByStdToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> sortByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }
}

extension UserCifraDtoQuerySortThenBy on QueryBuilder<UserCifraDto, UserCifraDto, QSortThenBy> {
  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByArtistImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByArtistImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByLocalDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseID', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByLocalDatabaseIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseID', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByRemoteDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByRemoteDatabaseIDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseID', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenBySongUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenBySongUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenBySongbookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByStdTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByStdToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdTone', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByTone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByToneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tone', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QAfterSortBy> thenByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }
}

extension UserCifraDtoQueryWhereDistinct on QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> {
  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByArtistImage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artistImage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capo');
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByRemoteDatabaseID() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteDatabaseID');
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId');
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctBySongUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songbookId');
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByStdTone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stdTone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByTone({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByTuning({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tuning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<UserCifraDto, UserCifraDto, QDistinct> distinctByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionId');
    });
  }
}

extension UserCifraDtoQueryProperty on QueryBuilder<UserCifraDto, UserCifraDto, QQueryProperty> {
  QueryBuilder<UserCifraDto, int, QQueryOperations> localDatabaseIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDatabaseID');
    });
  }

  QueryBuilder<UserCifraDto, UserCifraArtistDto, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<UserCifraDto, String?, QQueryOperations> artistImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artistImage');
    });
  }

  QueryBuilder<UserCifraDto, int?, QQueryOperations> capoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capo');
    });
  }

  QueryBuilder<UserCifraDto, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<UserCifraDto, int?, QQueryOperations> remoteDatabaseIDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteDatabaseID');
    });
  }

  QueryBuilder<UserCifraDto, int, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }

  QueryBuilder<UserCifraDto, String, QQueryOperations> songUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songUrl');
    });
  }

  QueryBuilder<UserCifraDto, int, QQueryOperations> songbookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songbookId');
    });
  }

  QueryBuilder<UserCifraDto, String?, QQueryOperations> stdToneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdTone');
    });
  }

  QueryBuilder<UserCifraDto, String?, QQueryOperations> toneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tone');
    });
  }

  QueryBuilder<UserCifraDto, String?, QQueryOperations> tuningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tuning');
    });
  }

  QueryBuilder<UserCifraDto, int, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<UserCifraDto, int, QQueryOperations> versionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionId');
    });
  }
}

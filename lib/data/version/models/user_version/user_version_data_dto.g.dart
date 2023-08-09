// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_version_data_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserVersionDataDtoCollection on Isar {
  IsarCollection<UserVersionDataDto> get userVersionDataDtos => this.collection();
}

const UserVersionDataDtoSchema = CollectionSchema(
  name: r'UserVersionDataDto',
  id: -8740572584622513009,
  properties: {
    r'artist': PropertySchema(
      id: 0,
      name: r'artist',
      type: IsarType.object,
      target: r'UserVersionDataArtistDto',
    ),
    r'blocked': PropertySchema(
      id: 1,
      name: r'blocked',
      type: IsarType.bool,
    ),
    r'capo': PropertySchema(
      id: 2,
      name: r'capo',
      type: IsarType.long,
    ),
    r'chords': PropertySchema(
      id: 3,
      name: r'chords',
      type: IsarType.objectList,
      target: r'UserChordDto',
    ),
    r'completePath': PropertySchema(
      id: 4,
      name: r'completePath',
      type: IsarType.string,
    ),
    r'composers': PropertySchema(
      id: 5,
      name: r'composers',
      type: IsarType.string,
    ),
    r'content': PropertySchema(
      id: 6,
      name: r'content',
      type: IsarType.string,
    ),
    r'contributors': PropertySchema(
      id: 7,
      name: r'contributors',
      type: IsarType.objectList,
      target: r'UserContributorDto',
    ),
    r'isVerified': PropertySchema(
      id: 8,
      name: r'isVerified',
      type: IsarType.bool,
    ),
    r'key': PropertySchema(
      id: 9,
      name: r'key',
      type: IsarType.string,
    ),
    r'label': PropertySchema(
      id: 10,
      name: r'label',
      type: IsarType.string,
    ),
    r'reason': PropertySchema(
      id: 11,
      name: r'reason',
      type: IsarType.string,
    ),
    r'shapeKey': PropertySchema(
      id: 12,
      name: r'shapeKey',
      type: IsarType.string,
    ),
    r'siteUrl': PropertySchema(
      id: 13,
      name: r'siteUrl',
      type: IsarType.string,
    ),
    r'song': PropertySchema(
      id: 14,
      name: r'song',
      type: IsarType.object,
      target: r'UserVersionDataSongDto',
    ),
    r'songbookVersionId': PropertySchema(
      id: 15,
      name: r'songbookVersionId',
      type: IsarType.long,
    ),
    r'songsDetail': PropertySchema(
      id: 16,
      name: r'songsDetail',
      type: IsarType.objectList,
      target: r'UserInstrumentVersionsDto',
    ),
    r'stdKey': PropertySchema(
      id: 17,
      name: r'stdKey',
      type: IsarType.string,
    ),
    r'stdShapeKey': PropertySchema(
      id: 18,
      name: r'stdShapeKey',
      type: IsarType.string,
    ),
    r'tuning': PropertySchema(
      id: 19,
      name: r'tuning',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 20,
      name: r'type',
      type: IsarType.long,
    ),
    r'versionId': PropertySchema(
      id: 21,
      name: r'versionId',
      type: IsarType.long,
    ),
    r'versionUrl': PropertySchema(
      id: 22,
      name: r'versionUrl',
      type: IsarType.string,
    ),
    r'videoLesson': PropertySchema(
      id: 23,
      name: r'videoLesson',
      type: IsarType.object,
      target: r'UserVersionDataVideoLessonDto',
    )
  },
  estimateSize: _userVersionDataDtoEstimateSize,
  serialize: _userVersionDataDtoSerialize,
  deserialize: _userVersionDataDtoDeserialize,
  deserializeProp: _userVersionDataDtoDeserializeProp,
  idName: r'localId',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'UserChordDto': UserChordDtoSchema,
    r'UserVersionDataSongDto': UserVersionDataSongDtoSchema,
    r'UserVersionDataArtistDto': UserVersionDataArtistDtoSchema,
    r'UserVersionDataGenreDto': UserVersionDataGenreDtoSchema,
    r'UserVersionDataGenreImagesDto': UserVersionDataGenreImagesDtoSchema,
    r'UserVersionDataArtistImageDto': UserVersionDataArtistImageDtoSchema,
    r'UserVersionDataVideoLessonDto': UserVersionDataVideoLessonDtoSchema,
    r'UserContributorDto': UserContributorDtoSchema,
    r'UserInstrumentVersionsDto': UserInstrumentVersionsDtoSchema,
    r'UserInstrumentVersionDto': UserInstrumentVersionDtoSchema
  },
  getId: _userVersionDataDtoGetId,
  getLinks: _userVersionDataDtoGetLinks,
  attach: _userVersionDataDtoAttach,
  version: '3.1.0+1',
);

int _userVersionDataDtoEstimateSize(
  UserVersionDataDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.artist;
    if (value != null) {
      bytesCount +=
          3 + UserVersionDataArtistDtoSchema.estimateSize(value, allOffsets[UserVersionDataArtistDto]!, allOffsets);
    }
  }
  {
    final list = object.chords;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[UserChordDto]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += UserChordDtoSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.completePath.length * 3;
  bytesCount += 3 + object.composers.length * 3;
  bytesCount += 3 + object.content.length * 3;
  {
    final list = object.contributors;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[UserContributorDto]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += UserContributorDtoSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.label.length * 3;
  bytesCount += 3 + object.reason.length * 3;
  bytesCount += 3 + object.shapeKey.length * 3;
  bytesCount += 3 + object.siteUrl.length * 3;
  bytesCount +=
      3 + UserVersionDataSongDtoSchema.estimateSize(object.song, allOffsets[UserVersionDataSongDto]!, allOffsets);
  {
    final list = object.songsDetail;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[UserInstrumentVersionsDto]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += UserInstrumentVersionsDtoSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.stdKey.length * 3;
  bytesCount += 3 + object.stdShapeKey.length * 3;
  bytesCount += 3 + object.tuning.length * 3;
  bytesCount += 3 + object.versionUrl.length * 3;
  {
    final value = object.videoLesson;
    if (value != null) {
      bytesCount += 3 +
          UserVersionDataVideoLessonDtoSchema.estimateSize(
              value, allOffsets[UserVersionDataVideoLessonDto]!, allOffsets);
    }
  }
  return bytesCount;
}

void _userVersionDataDtoSerialize(
  UserVersionDataDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<UserVersionDataArtistDto>(
    offsets[0],
    allOffsets,
    UserVersionDataArtistDtoSchema.serialize,
    object.artist,
  );
  writer.writeBool(offsets[1], object.blocked);
  writer.writeLong(offsets[2], object.capo);
  writer.writeObjectList<UserChordDto>(
    offsets[3],
    allOffsets,
    UserChordDtoSchema.serialize,
    object.chords,
  );
  writer.writeString(offsets[4], object.completePath);
  writer.writeString(offsets[5], object.composers);
  writer.writeString(offsets[6], object.content);
  writer.writeObjectList<UserContributorDto>(
    offsets[7],
    allOffsets,
    UserContributorDtoSchema.serialize,
    object.contributors,
  );
  writer.writeBool(offsets[8], object.isVerified);
  writer.writeString(offsets[9], object.key);
  writer.writeString(offsets[10], object.label);
  writer.writeString(offsets[11], object.reason);
  writer.writeString(offsets[12], object.shapeKey);
  writer.writeString(offsets[13], object.siteUrl);
  writer.writeObject<UserVersionDataSongDto>(
    offsets[14],
    allOffsets,
    UserVersionDataSongDtoSchema.serialize,
    object.song,
  );
  writer.writeLong(offsets[15], object.songbookVersionId);
  writer.writeObjectList<UserInstrumentVersionsDto>(
    offsets[16],
    allOffsets,
    UserInstrumentVersionsDtoSchema.serialize,
    object.songsDetail,
  );
  writer.writeString(offsets[17], object.stdKey);
  writer.writeString(offsets[18], object.stdShapeKey);
  writer.writeString(offsets[19], object.tuning);
  writer.writeLong(offsets[20], object.type);
  writer.writeLong(offsets[21], object.versionId);
  writer.writeString(offsets[22], object.versionUrl);
  writer.writeObject<UserVersionDataVideoLessonDto>(
    offsets[23],
    allOffsets,
    UserVersionDataVideoLessonDtoSchema.serialize,
    object.videoLesson,
  );
}

UserVersionDataDto _userVersionDataDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserVersionDataDto(
    artist: reader.readObjectOrNull<UserVersionDataArtistDto>(
      offsets[0],
      UserVersionDataArtistDtoSchema.deserialize,
      allOffsets,
    ),
    blocked: reader.readBool(offsets[1]),
    capo: reader.readLong(offsets[2]),
    chords: reader.readObjectList<UserChordDto>(
      offsets[3],
      UserChordDtoSchema.deserialize,
      allOffsets,
      UserChordDto(),
    ),
    completePath: reader.readString(offsets[4]),
    composers: reader.readString(offsets[5]),
    content: reader.readString(offsets[6]),
    contributors: reader.readObjectList<UserContributorDto>(
      offsets[7],
      UserContributorDtoSchema.deserialize,
      allOffsets,
      UserContributorDto(),
    ),
    isVerified: reader.readBool(offsets[8]),
    key: reader.readString(offsets[9]),
    label: reader.readString(offsets[10]),
    localId: id,
    reason: reader.readString(offsets[11]),
    shapeKey: reader.readString(offsets[12]),
    siteUrl: reader.readString(offsets[13]),
    song: reader.readObjectOrNull<UserVersionDataSongDto>(
          offsets[14],
          UserVersionDataSongDtoSchema.deserialize,
          allOffsets,
        ) ??
        UserVersionDataSongDto(),
    songbookVersionId: reader.readLong(offsets[15]),
    songsDetail: reader.readObjectList<UserInstrumentVersionsDto>(
      offsets[16],
      UserInstrumentVersionsDtoSchema.deserialize,
      allOffsets,
      UserInstrumentVersionsDto(),
    ),
    stdKey: reader.readString(offsets[17]),
    stdShapeKey: reader.readString(offsets[18]),
    tuning: reader.readString(offsets[19]),
    type: reader.readLong(offsets[20]),
    versionId: reader.readLong(offsets[21]),
    versionUrl: reader.readString(offsets[22]),
    videoLesson: reader.readObjectOrNull<UserVersionDataVideoLessonDto>(
      offsets[23],
      UserVersionDataVideoLessonDtoSchema.deserialize,
      allOffsets,
    ),
  );
  return object;
}

P _userVersionDataDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<UserVersionDataArtistDto>(
        offset,
        UserVersionDataArtistDtoSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readObjectList<UserChordDto>(
        offset,
        UserChordDtoSchema.deserialize,
        allOffsets,
        UserChordDto(),
      )) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readObjectList<UserContributorDto>(
        offset,
        UserContributorDtoSchema.deserialize,
        allOffsets,
        UserContributorDto(),
      )) as P;
    case 8:
      return (reader.readBool(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readObjectOrNull<UserVersionDataSongDto>(
            offset,
            UserVersionDataSongDtoSchema.deserialize,
            allOffsets,
          ) ??
          UserVersionDataSongDto()) as P;
    case 15:
      return (reader.readLong(offset)) as P;
    case 16:
      return (reader.readObjectList<UserInstrumentVersionsDto>(
        offset,
        UserInstrumentVersionsDtoSchema.deserialize,
        allOffsets,
        UserInstrumentVersionsDto(),
      )) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    case 19:
      return (reader.readString(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readLong(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readObjectOrNull<UserVersionDataVideoLessonDto>(
        offset,
        UserVersionDataVideoLessonDtoSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userVersionDataDtoGetId(UserVersionDataDto object) {
  return object.localId;
}

List<IsarLinkBase<dynamic>> _userVersionDataDtoGetLinks(UserVersionDataDto object) {
  return [];
}

void _userVersionDataDtoAttach(IsarCollection<dynamic> col, Id id, UserVersionDataDto object) {}

extension UserVersionDataDtoQueryWhereSort on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QWhere> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhere> anyLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserVersionDataDtoQueryWhere on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QWhereClause> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localIdEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localId,
        upper: localId,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localIdNotEqualTo(Id localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localIdGreaterThan(Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localIdLessThan(Id localId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localIdBetween(
    Id lowerLocalId,
    Id upperLocalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocalId,
        includeLower: includeLower,
        upper: upperLocalId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserVersionDataDtoQueryFilter on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QFilterCondition> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> artistIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artist',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> artistIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artist',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> blockedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'blocked',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> capoEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> capoGreaterThan(
    int value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> capoLessThan(
    int value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> capoBetween(
    int lower,
    int upper, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chords',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chords',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'chords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'completePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'completePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'completePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'completePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> completePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'completePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'composers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'composers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'composers',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'composers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'composers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'composers',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'composers',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'composers',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> composersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'composers',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contributors',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contributors',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contributors',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contributors',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contributors',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contributors',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contributors',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'contributors',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> isVerifiedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVerified',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyEqualTo(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyGreaterThan(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyLessThan(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyBetween(
    String lower,
    String upper, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyStartsWith(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyEndsWith(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'label',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> reasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shapeKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shapeKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shapeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shapeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'siteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'siteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'siteUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'siteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'siteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'siteUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'siteUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'siteUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> siteUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'siteUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookVersionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songbookVersionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookVersionIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songbookVersionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookVersionIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songbookVersionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookVersionIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songbookVersionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'songsDetail',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'songsDetail',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsDetail',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsDetail',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsDetail',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsDetail',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsDetail',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songsDetail',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyEqualTo(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyGreaterThan(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyLessThan(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyBetween(
    String lower,
    String upper, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyStartsWith(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyEndsWith(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stdKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stdKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdShapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stdShapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stdShapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stdShapeKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stdShapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stdShapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stdShapeKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stdShapeKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdShapeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stdShapeKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningEqualTo(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningGreaterThan(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningLessThan(
    String value, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningBetween(
    String lower,
    String upper, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningStartsWith(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningEndsWith(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tuning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> typeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> typeGreaterThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> typeLessThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> typeBetween(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionIdGreaterThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionIdLessThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionIdBetween(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'versionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'versionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> videoLessonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'videoLesson',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> videoLessonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'videoLesson',
      ));
    });
  }
}

extension UserVersionDataDtoQueryObject on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QFilterCondition> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> artist(
      FilterQuery<UserVersionDataArtistDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'artist');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> chordsElement(
      FilterQuery<UserChordDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'chords');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> contributorsElement(
      FilterQuery<UserContributorDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'contributors');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> song(
      FilterQuery<UserVersionDataSongDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'song');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songsDetailElement(
      FilterQuery<UserInstrumentVersionsDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'songsDetail');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> videoLesson(
      FilterQuery<UserVersionDataVideoLessonDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'videoLesson');
    });
  }
}

extension UserVersionDataDtoQueryLinks on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QFilterCondition> {}

extension UserVersionDataDtoQuerySortBy on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QSortBy> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByCompletePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completePath', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByCompletePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completePath', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByComposers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composers', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByComposersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composers', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByIsVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByShapeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shapeKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByShapeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shapeKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortBySiteUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siteUrl', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortBySiteUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siteUrl', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortBySongbookVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookVersionId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortBySongbookVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookVersionId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByStdKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByStdKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByStdShapeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdShapeKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByStdShapeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdShapeKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionUrl', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionUrl', Sort.desc);
    });
  }
}

extension UserVersionDataDtoQuerySortThenBy on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QSortThenBy> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByBlockedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'blocked', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByCompletePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completePath', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByCompletePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completePath', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByComposers() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composers', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByComposersDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'composers', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByContent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByContentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'content', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByIsVerifiedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isVerified', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'label', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByShapeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shapeKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByShapeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shapeKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenBySiteUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siteUrl', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenBySiteUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'siteUrl', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenBySongbookVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookVersionId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenBySongbookVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookVersionId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByStdKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByStdKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByStdShapeKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdShapeKey', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByStdShapeKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdShapeKey', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionUrl', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionUrl', Sort.desc);
    });
  }
}

extension UserVersionDataDtoQueryWhereDistinct on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByBlocked() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'blocked');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capo');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByCompletePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completePath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByComposers({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'composers', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByContent({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'content', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByIsVerified() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isVerified');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByLabel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'label', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByReason({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reason', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByShapeKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shapeKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctBySiteUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'siteUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctBySongbookVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songbookVersionId');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByStdKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stdKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByStdShapeKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stdShapeKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByTuning({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tuning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionId');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByVersionUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionUrl', caseSensitive: caseSensitive);
    });
  }
}

extension UserVersionDataDtoQueryProperty on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QQueryProperty> {
  QueryBuilder<UserVersionDataDto, int, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataArtistDto?, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<UserVersionDataDto, bool, QQueryOperations> blockedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'blocked');
    });
  }

  QueryBuilder<UserVersionDataDto, int, QQueryOperations> capoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capo');
    });
  }

  QueryBuilder<UserVersionDataDto, List<UserChordDto>?, QQueryOperations> chordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chords');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> completePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completePath');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> composersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'composers');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> contentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'content');
    });
  }

  QueryBuilder<UserVersionDataDto, List<UserContributorDto>?, QQueryOperations> contributorsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contributors');
    });
  }

  QueryBuilder<UserVersionDataDto, bool, QQueryOperations> isVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVerified');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> labelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'label');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> reasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reason');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> shapeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shapeKey');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> siteUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'siteUrl');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataSongDto, QQueryOperations> songProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'song');
    });
  }

  QueryBuilder<UserVersionDataDto, int, QQueryOperations> songbookVersionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songbookVersionId');
    });
  }

  QueryBuilder<UserVersionDataDto, List<UserInstrumentVersionsDto>?, QQueryOperations> songsDetailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songsDetail');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> stdKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdKey');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> stdShapeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdShapeKey');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> tuningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tuning');
    });
  }

  QueryBuilder<UserVersionDataDto, int, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<UserVersionDataDto, int, QQueryOperations> versionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionId');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> versionUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionUrl');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataVideoLessonDto?, QQueryOperations> videoLessonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'videoLesson');
    });
  }
}

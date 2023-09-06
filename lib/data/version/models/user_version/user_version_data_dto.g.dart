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
    r'instrument': PropertySchema(
      id: 8,
      name: r'instrument',
      type: IsarType.byte,
      enumMap: _UserVersionDataDtoinstrumentEnumValueMap,
    ),
    r'instrumentVersions': PropertySchema(
      id: 9,
      name: r'instrumentVersions',
      type: IsarType.objectList,
      target: r'UserInstrumentVersionsDto',
    ),
    r'isVerified': PropertySchema(
      id: 10,
      name: r'isVerified',
      type: IsarType.bool,
    ),
    r'key': PropertySchema(
      id: 11,
      name: r'key',
      type: IsarType.string,
    ),
    r'reason': PropertySchema(
      id: 12,
      name: r'reason',
      type: IsarType.string,
    ),
    r'shapeKey': PropertySchema(
      id: 13,
      name: r'shapeKey',
      type: IsarType.string,
    ),
    r'siteUrl': PropertySchema(
      id: 14,
      name: r'siteUrl',
      type: IsarType.string,
    ),
    r'song': PropertySchema(
      id: 15,
      name: r'song',
      type: IsarType.object,
      target: r'UserVersionDataSongDto',
    ),
    r'songbookId': PropertySchema(
      id: 16,
      name: r'songbookId',
      type: IsarType.long,
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
    r'versionId': PropertySchema(
      id: 20,
      name: r'versionId',
      type: IsarType.long,
    ),
    r'versionLocalDatabaseId': PropertySchema(
      id: 21,
      name: r'versionLocalDatabaseId',
      type: IsarType.long,
    ),
    r'versionName': PropertySchema(
      id: 22,
      name: r'versionName',
      type: IsarType.string,
    ),
    r'versionUrl': PropertySchema(
      id: 23,
      name: r'versionUrl',
      type: IsarType.string,
    ),
    r'videoLesson': PropertySchema(
      id: 24,
      name: r'videoLesson',
      type: IsarType.object,
      target: r'UserVersionDataVideoLessonDto',
    )
  },
  estimateSize: _userVersionDataDtoEstimateSize,
  serialize: _userVersionDataDtoSerialize,
  deserialize: _userVersionDataDtoDeserialize,
  deserializeProp: _userVersionDataDtoDeserializeProp,
  idName: r'localDatabaseId',
  indexes: {
    r'versionLocalDatabaseId_songbookId': IndexSchema(
      id: -8803715492365910835,
      name: r'versionLocalDatabaseId_songbookId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'versionLocalDatabaseId',
          type: IndexType.value,
          caseSensitive: false,
        ),
        IndexPropertySchema(
          name: r'songbookId',
          type: IndexType.value,
          caseSensitive: false,
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
  {
    final list = object.instrumentVersions;
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
  {
    final value = object.key;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.reason.length * 3;
  {
    final value = object.shapeKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.siteUrl.length * 3;
  bytesCount +=
      3 + UserVersionDataSongDtoSchema.estimateSize(object.song, allOffsets[UserVersionDataSongDto]!, allOffsets);
  {
    final value = object.stdKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stdShapeKey;
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
  bytesCount += 3 + object.versionName.length * 3;
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
  writer.writeByte(offsets[8], object.instrument.index);
  writer.writeObjectList<UserInstrumentVersionsDto>(
    offsets[9],
    allOffsets,
    UserInstrumentVersionsDtoSchema.serialize,
    object.instrumentVersions,
  );
  writer.writeBool(offsets[10], object.isVerified);
  writer.writeString(offsets[11], object.key);
  writer.writeString(offsets[12], object.reason);
  writer.writeString(offsets[13], object.shapeKey);
  writer.writeString(offsets[14], object.siteUrl);
  writer.writeObject<UserVersionDataSongDto>(
    offsets[15],
    allOffsets,
    UserVersionDataSongDtoSchema.serialize,
    object.song,
  );
  writer.writeLong(offsets[16], object.songbookId);
  writer.writeString(offsets[17], object.stdKey);
  writer.writeString(offsets[18], object.stdShapeKey);
  writer.writeString(offsets[19], object.tuning);
  writer.writeLong(offsets[20], object.versionId);
  writer.writeLong(offsets[21], object.versionLocalDatabaseId);
  writer.writeString(offsets[22], object.versionName);
  writer.writeString(offsets[23], object.versionUrl);
  writer.writeObject<UserVersionDataVideoLessonDto>(
    offsets[24],
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
    instrument: _UserVersionDataDtoinstrumentValueEnumMap[reader.readByteOrNull(offsets[8])] ?? Instrument.guitar,
    instrumentVersions: reader.readObjectList<UserInstrumentVersionsDto>(
      offsets[9],
      UserInstrumentVersionsDtoSchema.deserialize,
      allOffsets,
      UserInstrumentVersionsDto(),
    ),
    isVerified: reader.readBool(offsets[10]),
    key: reader.readStringOrNull(offsets[11]),
    localDatabaseId: id,
    reason: reader.readString(offsets[12]),
    shapeKey: reader.readStringOrNull(offsets[13]),
    siteUrl: reader.readString(offsets[14]),
    song: reader.readObjectOrNull<UserVersionDataSongDto>(
          offsets[15],
          UserVersionDataSongDtoSchema.deserialize,
          allOffsets,
        ) ??
        UserVersionDataSongDto(),
    songbookId: reader.readLong(offsets[16]),
    stdKey: reader.readStringOrNull(offsets[17]),
    stdShapeKey: reader.readStringOrNull(offsets[18]),
    tuning: reader.readStringOrNull(offsets[19]),
    versionId: reader.readLong(offsets[20]),
    versionLocalDatabaseId: reader.readLong(offsets[21]),
    versionName: reader.readString(offsets[22]),
    versionUrl: reader.readString(offsets[23]),
    videoLesson: reader.readObjectOrNull<UserVersionDataVideoLessonDto>(
      offsets[24],
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
      return (_UserVersionDataDtoinstrumentValueEnumMap[reader.readByteOrNull(offset)] ?? Instrument.guitar) as P;
    case 9:
      return (reader.readObjectList<UserInstrumentVersionsDto>(
        offset,
        UserInstrumentVersionsDtoSchema.deserialize,
        allOffsets,
        UserInstrumentVersionsDto(),
      )) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readObjectOrNull<UserVersionDataSongDto>(
            offset,
            UserVersionDataSongDtoSchema.deserialize,
            allOffsets,
          ) ??
          UserVersionDataSongDto()) as P;
    case 16:
      return (reader.readLong(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readLong(offset)) as P;
    case 21:
      return (reader.readLong(offset)) as P;
    case 22:
      return (reader.readString(offset)) as P;
    case 23:
      return (reader.readString(offset)) as P;
    case 24:
      return (reader.readObjectOrNull<UserVersionDataVideoLessonDto>(
        offset,
        UserVersionDataVideoLessonDtoSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserVersionDataDtoinstrumentEnumValueMap = {
  'guitar': 0,
  'ukulele': 1,
  'keyboard': 2,
  'cavaco': 3,
  'violaCaipira': 4,
  'bass': 5,
  'drums': 6,
  'harmonica': 7,
  'unknown': 8,
};
const _UserVersionDataDtoinstrumentValueEnumMap = {
  0: Instrument.guitar,
  1: Instrument.ukulele,
  2: Instrument.keyboard,
  3: Instrument.cavaco,
  4: Instrument.violaCaipira,
  5: Instrument.bass,
  6: Instrument.drums,
  7: Instrument.harmonica,
  8: Instrument.unknown,
};

Id _userVersionDataDtoGetId(UserVersionDataDto object) {
  return object.localDatabaseId;
}

List<IsarLinkBase<dynamic>> _userVersionDataDtoGetLinks(UserVersionDataDto object) {
  return [];
}

void _userVersionDataDtoAttach(IsarCollection<dynamic> col, Id id, UserVersionDataDto object) {}

extension UserVersionDataDtoByIndex on IsarCollection<UserVersionDataDto> {
  Future<UserVersionDataDto?> getByVersionLocalDatabaseIdSongbookId(int versionLocalDatabaseId, int songbookId) {
    return getByIndex(r'versionLocalDatabaseId_songbookId', [versionLocalDatabaseId, songbookId]);
  }

  UserVersionDataDto? getByVersionLocalDatabaseIdSongbookIdSync(int versionLocalDatabaseId, int songbookId) {
    return getByIndexSync(r'versionLocalDatabaseId_songbookId', [versionLocalDatabaseId, songbookId]);
  }

  Future<bool> deleteByVersionLocalDatabaseIdSongbookId(int versionLocalDatabaseId, int songbookId) {
    return deleteByIndex(r'versionLocalDatabaseId_songbookId', [versionLocalDatabaseId, songbookId]);
  }

  bool deleteByVersionLocalDatabaseIdSongbookIdSync(int versionLocalDatabaseId, int songbookId) {
    return deleteByIndexSync(r'versionLocalDatabaseId_songbookId', [versionLocalDatabaseId, songbookId]);
  }

  Future<List<UserVersionDataDto?>> getAllByVersionLocalDatabaseIdSongbookId(
      List<int> versionLocalDatabaseIdValues, List<int> songbookIdValues) {
    final len = versionLocalDatabaseIdValues.length;
    assert(songbookIdValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([versionLocalDatabaseIdValues[i], songbookIdValues[i]]);
    }

    return getAllByIndex(r'versionLocalDatabaseId_songbookId', values);
  }

  List<UserVersionDataDto?> getAllByVersionLocalDatabaseIdSongbookIdSync(
      List<int> versionLocalDatabaseIdValues, List<int> songbookIdValues) {
    final len = versionLocalDatabaseIdValues.length;
    assert(songbookIdValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([versionLocalDatabaseIdValues[i], songbookIdValues[i]]);
    }

    return getAllByIndexSync(r'versionLocalDatabaseId_songbookId', values);
  }

  Future<int> deleteAllByVersionLocalDatabaseIdSongbookId(
      List<int> versionLocalDatabaseIdValues, List<int> songbookIdValues) {
    final len = versionLocalDatabaseIdValues.length;
    assert(songbookIdValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([versionLocalDatabaseIdValues[i], songbookIdValues[i]]);
    }

    return deleteAllByIndex(r'versionLocalDatabaseId_songbookId', values);
  }

  int deleteAllByVersionLocalDatabaseIdSongbookIdSync(
      List<int> versionLocalDatabaseIdValues, List<int> songbookIdValues) {
    final len = versionLocalDatabaseIdValues.length;
    assert(songbookIdValues.length == len, 'All index values must have the same length');
    final values = <List<dynamic>>[];
    for (var i = 0; i < len; i++) {
      values.add([versionLocalDatabaseIdValues[i], songbookIdValues[i]]);
    }

    return deleteAllByIndexSync(r'versionLocalDatabaseId_songbookId', values);
  }

  Future<Id> putByVersionLocalDatabaseIdSongbookId(UserVersionDataDto object) {
    return putByIndex(r'versionLocalDatabaseId_songbookId', object);
  }

  Id putByVersionLocalDatabaseIdSongbookIdSync(UserVersionDataDto object, {bool saveLinks = true}) {
    return putByIndexSync(r'versionLocalDatabaseId_songbookId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByVersionLocalDatabaseIdSongbookId(List<UserVersionDataDto> objects) {
    return putAllByIndex(r'versionLocalDatabaseId_songbookId', objects);
  }

  List<Id> putAllByVersionLocalDatabaseIdSongbookIdSync(List<UserVersionDataDto> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'versionLocalDatabaseId_songbookId', objects, saveLinks: saveLinks);
  }
}

extension UserVersionDataDtoQueryWhereSort on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QWhere> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhere> anyLocalDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhere> anyVersionLocalDatabaseIdSongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'versionLocalDatabaseId_songbookId'),
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhere> anySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'songbookId'),
      );
    });
  }
}

extension UserVersionDataDtoQueryWhere on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QWhereClause> {
  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localDatabaseIdEqualTo(Id localDatabaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localDatabaseId,
        upper: localDatabaseId,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localDatabaseIdNotEqualTo(
      Id localDatabaseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: localDatabaseId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localDatabaseId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: localDatabaseId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: localDatabaseId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localDatabaseIdGreaterThan(Id localDatabaseId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localDatabaseId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localDatabaseIdLessThan(Id localDatabaseId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localDatabaseId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> localDatabaseIdBetween(
    Id lowerLocalDatabaseId,
    Id upperLocalDatabaseId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerLocalDatabaseId,
        includeLower: includeLower,
        upper: upperLocalDatabaseId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> versionLocalDatabaseIdEqualToAnySongbookId(
      int versionLocalDatabaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'versionLocalDatabaseId_songbookId',
        value: [versionLocalDatabaseId],
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> versionLocalDatabaseIdNotEqualToAnySongbookId(
      int versionLocalDatabaseId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [],
              upper: [versionLocalDatabaseId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [versionLocalDatabaseId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [versionLocalDatabaseId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [],
              upper: [versionLocalDatabaseId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause>
      versionLocalDatabaseIdGreaterThanAnySongbookId(
    int versionLocalDatabaseId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'versionLocalDatabaseId_songbookId',
        lower: [versionLocalDatabaseId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> versionLocalDatabaseIdLessThanAnySongbookId(
    int versionLocalDatabaseId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'versionLocalDatabaseId_songbookId',
        lower: [],
        upper: [versionLocalDatabaseId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> versionLocalDatabaseIdBetweenAnySongbookId(
    int lowerVersionLocalDatabaseId,
    int upperVersionLocalDatabaseId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'versionLocalDatabaseId_songbookId',
        lower: [lowerVersionLocalDatabaseId],
        includeLower: includeLower,
        upper: [upperVersionLocalDatabaseId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> versionLocalDatabaseIdSongbookIdEqualTo(
      int versionLocalDatabaseId, int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'versionLocalDatabaseId_songbookId',
        value: [versionLocalDatabaseId, songbookId],
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause>
      versionLocalDatabaseIdEqualToSongbookIdNotEqualTo(int versionLocalDatabaseId, int songbookId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [versionLocalDatabaseId],
              upper: [versionLocalDatabaseId, songbookId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [versionLocalDatabaseId, songbookId],
              includeLower: false,
              upper: [versionLocalDatabaseId],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [versionLocalDatabaseId, songbookId],
              includeLower: false,
              upper: [versionLocalDatabaseId],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'versionLocalDatabaseId_songbookId',
              lower: [versionLocalDatabaseId],
              upper: [versionLocalDatabaseId, songbookId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause>
      versionLocalDatabaseIdEqualToSongbookIdGreaterThan(
    int versionLocalDatabaseId,
    int songbookId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'versionLocalDatabaseId_songbookId',
        lower: [versionLocalDatabaseId, songbookId],
        includeLower: include,
        upper: [versionLocalDatabaseId],
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause>
      versionLocalDatabaseIdEqualToSongbookIdLessThan(
    int versionLocalDatabaseId,
    int songbookId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'versionLocalDatabaseId_songbookId',
        lower: [versionLocalDatabaseId],
        upper: [versionLocalDatabaseId, songbookId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause>
      versionLocalDatabaseIdEqualToSongbookIdBetween(
    int versionLocalDatabaseId,
    int lowerSongbookId,
    int upperSongbookId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'versionLocalDatabaseId_songbookId',
        lower: [versionLocalDatabaseId, lowerSongbookId],
        includeLower: includeLower,
        upper: [versionLocalDatabaseId, upperSongbookId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> songbookIdEqualTo(int songbookId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'songbookId',
        value: [songbookId],
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> songbookIdNotEqualTo(int songbookId) {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> songbookIdGreaterThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> songbookIdLessThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterWhereClause> songbookIdBetween(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentEqualTo(Instrument value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instrument',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentGreaterThan(
    Instrument value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'instrument',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentLessThan(
    Instrument value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'instrument',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentBetween(
    Instrument lower,
    Instrument upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'instrument',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'instrumentVersions',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'instrumentVersions',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instrumentVersions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instrumentVersions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instrumentVersions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instrumentVersions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instrumentVersions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'instrumentVersions',
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyEqualTo(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyGreaterThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyLessThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> keyBetween(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localDatabaseIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localDatabaseIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localDatabaseIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> localDatabaseIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localDatabaseId',
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shapeKey',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shapeKey',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> shapeKeyEqualTo(
    String? value, {
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
    String? value, {
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
    String? value, {
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
    String? lower,
    String? upper, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songbookId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookIdGreaterThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookIdLessThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> songbookIdBetween(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stdKey',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stdKey',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyEqualTo(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyGreaterThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyLessThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdKeyBetween(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stdShapeKey',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stdShapeKey',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> stdShapeKeyEqualTo(
    String? value, {
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
    String? value, {
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
    String? value, {
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
    String? lower,
    String? upper, {
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningEqualTo(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningGreaterThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningLessThan(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> tuningBetween(
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionLocalDatabaseIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionLocalDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionLocalDatabaseIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionLocalDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionLocalDatabaseIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionLocalDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionLocalDatabaseIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionLocalDatabaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'versionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> versionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionName',
        value: '',
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> instrumentVersionsElement(
      FilterQuery<UserInstrumentVersionsDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'instrumentVersions');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterFilterCondition> song(
      FilterQuery<UserVersionDataSongDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'song');
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByInstrument() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByInstrumentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.desc);
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortBySongbookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.desc);
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionLocalDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionLocalDatabaseId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionLocalDatabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionLocalDatabaseId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> sortByVersionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.desc);
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByInstrument() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByInstrumentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.desc);
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByLocalDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByLocalDatabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseId', Sort.desc);
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenBySongbookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songbookId', Sort.desc);
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionLocalDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionLocalDatabaseId', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionLocalDatabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionLocalDatabaseId', Sort.desc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.asc);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QAfterSortBy> thenByVersionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionName', Sort.desc);
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByInstrument() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instrument');
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctBySongbookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songbookId');
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

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionId');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByVersionLocalDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionLocalDatabaseId');
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByVersionName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserVersionDataDto, UserVersionDataDto, QDistinct> distinctByVersionUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionUrl', caseSensitive: caseSensitive);
    });
  }
}

extension UserVersionDataDtoQueryProperty on QueryBuilder<UserVersionDataDto, UserVersionDataDto, QQueryProperty> {
  QueryBuilder<UserVersionDataDto, int, QQueryOperations> localDatabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDatabaseId');
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

  QueryBuilder<UserVersionDataDto, Instrument, QQueryOperations> instrumentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instrument');
    });
  }

  QueryBuilder<UserVersionDataDto, List<UserInstrumentVersionsDto>?, QQueryOperations> instrumentVersionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instrumentVersions');
    });
  }

  QueryBuilder<UserVersionDataDto, bool, QQueryOperations> isVerifiedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isVerified');
    });
  }

  QueryBuilder<UserVersionDataDto, String?, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> reasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reason');
    });
  }

  QueryBuilder<UserVersionDataDto, String?, QQueryOperations> shapeKeyProperty() {
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

  QueryBuilder<UserVersionDataDto, int, QQueryOperations> songbookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songbookId');
    });
  }

  QueryBuilder<UserVersionDataDto, String?, QQueryOperations> stdKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdKey');
    });
  }

  QueryBuilder<UserVersionDataDto, String?, QQueryOperations> stdShapeKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdShapeKey');
    });
  }

  QueryBuilder<UserVersionDataDto, String?, QQueryOperations> tuningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tuning');
    });
  }

  QueryBuilder<UserVersionDataDto, int, QQueryOperations> versionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionId');
    });
  }

  QueryBuilder<UserVersionDataDto, int, QQueryOperations> versionLocalDatabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionLocalDatabaseId');
    });
  }

  QueryBuilder<UserVersionDataDto, String, QQueryOperations> versionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionName');
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

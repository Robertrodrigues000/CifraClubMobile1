// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recent_version_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserRecentVersionDtoCWProxy {
  UserRecentVersionDto localDatabaseId(int localDatabaseId);

  UserRecentVersionDto remoteDatabaseId(int? remoteDatabaseId);

  UserRecentVersionDto songUrl(String songUrl);

  UserRecentVersionDto key(String? key);

  UserRecentVersionDto instrument(Instrument instrument);

  UserRecentVersionDto name(String name);

  UserRecentVersionDto capo(int? capo);

  UserRecentVersionDto stdKey(String? stdKey);

  UserRecentVersionDto tuning(String? tuning);

  UserRecentVersionDto songId(int songId);

  UserRecentVersionDto artist(UserVersionArtistDto artist);

  UserRecentVersionDto artistImage(String? artistImage);

  UserRecentVersionDto versionId(int versionId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserRecentVersionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserRecentVersionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserRecentVersionDto call({
    int? localDatabaseId,
    int? remoteDatabaseId,
    String? songUrl,
    String? key,
    Instrument? instrument,
    String? name,
    int? capo,
    String? stdKey,
    String? tuning,
    int? songId,
    UserVersionArtistDto? artist,
    String? artistImage,
    int? versionId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserRecentVersionDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserRecentVersionDto.copyWith.fieldName(...)`
class _$UserRecentVersionDtoCWProxyImpl implements _$UserRecentVersionDtoCWProxy {
  const _$UserRecentVersionDtoCWProxyImpl(this._value);

  final UserRecentVersionDto _value;

  @override
  UserRecentVersionDto localDatabaseId(int localDatabaseId) => this(localDatabaseId: localDatabaseId);

  @override
  UserRecentVersionDto remoteDatabaseId(int? remoteDatabaseId) => this(remoteDatabaseId: remoteDatabaseId);

  @override
  UserRecentVersionDto songUrl(String songUrl) => this(songUrl: songUrl);

  @override
  UserRecentVersionDto key(String? key) => this(key: key);

  @override
  UserRecentVersionDto instrument(Instrument instrument) => this(instrument: instrument);

  @override
  UserRecentVersionDto name(String name) => this(name: name);

  @override
  UserRecentVersionDto capo(int? capo) => this(capo: capo);

  @override
  UserRecentVersionDto stdKey(String? stdKey) => this(stdKey: stdKey);

  @override
  UserRecentVersionDto tuning(String? tuning) => this(tuning: tuning);

  @override
  UserRecentVersionDto songId(int songId) => this(songId: songId);

  @override
  UserRecentVersionDto artist(UserVersionArtistDto artist) => this(artist: artist);

  @override
  UserRecentVersionDto artistImage(String? artistImage) => this(artistImage: artistImage);

  @override
  UserRecentVersionDto versionId(int versionId) => this(versionId: versionId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserRecentVersionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserRecentVersionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserRecentVersionDto call({
    Object? localDatabaseId = const $CopyWithPlaceholder(),
    Object? remoteDatabaseId = const $CopyWithPlaceholder(),
    Object? songUrl = const $CopyWithPlaceholder(),
    Object? key = const $CopyWithPlaceholder(),
    Object? instrument = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? capo = const $CopyWithPlaceholder(),
    Object? stdKey = const $CopyWithPlaceholder(),
    Object? tuning = const $CopyWithPlaceholder(),
    Object? songId = const $CopyWithPlaceholder(),
    Object? artist = const $CopyWithPlaceholder(),
    Object? artistImage = const $CopyWithPlaceholder(),
    Object? versionId = const $CopyWithPlaceholder(),
  }) {
    return UserRecentVersionDto(
      localDatabaseId: localDatabaseId == const $CopyWithPlaceholder() || localDatabaseId == null
          ? _value.localDatabaseId
          // ignore: cast_nullable_to_non_nullable
          : localDatabaseId as int,
      remoteDatabaseId: remoteDatabaseId == const $CopyWithPlaceholder()
          ? _value.remoteDatabaseId
          // ignore: cast_nullable_to_non_nullable
          : remoteDatabaseId as int?,
      songUrl: songUrl == const $CopyWithPlaceholder() || songUrl == null
          ? _value.songUrl
          // ignore: cast_nullable_to_non_nullable
          : songUrl as String,
      key: key == const $CopyWithPlaceholder()
          ? _value.key
          // ignore: cast_nullable_to_non_nullable
          : key as String?,
      instrument: instrument == const $CopyWithPlaceholder() || instrument == null
          ? _value.instrument
          // ignore: cast_nullable_to_non_nullable
          : instrument as Instrument,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
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

extension $UserRecentVersionDtoCopyWith on UserRecentVersionDto {
  /// Returns a callable class that can be used as follows: `instanceOfUserRecentVersionDto.copyWith(...)` or like so:`instanceOfUserRecentVersionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserRecentVersionDtoCWProxy get copyWith => _$UserRecentVersionDtoCWProxyImpl(this);
}

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserRecentVersionDtoCollection on Isar {
  IsarCollection<UserRecentVersionDto> get userRecentVersionDtos => this.collection();
}

const UserRecentVersionDtoSchema = CollectionSchema(
  name: r'UserRecentVersionDto',
  id: 2160241629409975599,
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
    r'instrument': PropertySchema(
      id: 3,
      name: r'instrument',
      type: IsarType.byte,
      enumMap: _UserRecentVersionDtoinstrumentEnumValueMap,
    ),
    r'key': PropertySchema(
      id: 4,
      name: r'key',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'remoteDatabaseId': PropertySchema(
      id: 6,
      name: r'remoteDatabaseId',
      type: IsarType.long,
    ),
    r'songId': PropertySchema(
      id: 7,
      name: r'songId',
      type: IsarType.long,
    ),
    r'songUrl': PropertySchema(
      id: 8,
      name: r'songUrl',
      type: IsarType.string,
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
    r'versionId': PropertySchema(
      id: 11,
      name: r'versionId',
      type: IsarType.long,
    )
  },
  estimateSize: _userRecentVersionDtoEstimateSize,
  serialize: _userRecentVersionDtoSerialize,
  deserialize: _userRecentVersionDtoDeserialize,
  deserializeProp: _userRecentVersionDtoDeserializeProp,
  idName: r'localDatabaseId',
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
    )
  },
  links: {},
  embeddedSchemas: {r'UserVersionArtistDto': UserVersionArtistDtoSchema},
  getId: _userRecentVersionDtoGetId,
  getLinks: _userRecentVersionDtoGetLinks,
  attach: _userRecentVersionDtoAttach,
  version: '3.1.0+1',
);

int _userRecentVersionDtoEstimateSize(
  UserRecentVersionDto object,
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

void _userRecentVersionDtoSerialize(
  UserRecentVersionDto object,
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
  writer.writeByte(offsets[3], object.instrument.index);
  writer.writeString(offsets[4], object.key);
  writer.writeString(offsets[5], object.name);
  writer.writeLong(offsets[6], object.remoteDatabaseId);
  writer.writeLong(offsets[7], object.songId);
  writer.writeString(offsets[8], object.songUrl);
  writer.writeString(offsets[9], object.stdKey);
  writer.writeString(offsets[10], object.tuning);
  writer.writeLong(offsets[11], object.versionId);
}

UserRecentVersionDto _userRecentVersionDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserRecentVersionDto(
    artist: reader.readObjectOrNull<UserVersionArtistDto>(
          offsets[0],
          UserVersionArtistDtoSchema.deserialize,
          allOffsets,
        ) ??
        UserVersionArtistDto(),
    artistImage: reader.readStringOrNull(offsets[1]),
    capo: reader.readLongOrNull(offsets[2]),
    instrument: _UserRecentVersionDtoinstrumentValueEnumMap[reader.readByteOrNull(offsets[3])] ?? Instrument.guitar,
    key: reader.readStringOrNull(offsets[4]),
    localDatabaseId: id,
    name: reader.readString(offsets[5]),
    remoteDatabaseId: reader.readLongOrNull(offsets[6]),
    songId: reader.readLong(offsets[7]),
    songUrl: reader.readString(offsets[8]),
    stdKey: reader.readStringOrNull(offsets[9]),
    tuning: reader.readStringOrNull(offsets[10]),
    versionId: reader.readLong(offsets[11]),
  );
  return object;
}

P _userRecentVersionDtoDeserializeProp<P>(
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
      return (_UserRecentVersionDtoinstrumentValueEnumMap[reader.readByteOrNull(offset)] ?? Instrument.guitar) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserRecentVersionDtoinstrumentEnumValueMap = {
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
const _UserRecentVersionDtoinstrumentValueEnumMap = {
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

Id _userRecentVersionDtoGetId(UserRecentVersionDto object) {
  return object.localDatabaseId;
}

List<IsarLinkBase<dynamic>> _userRecentVersionDtoGetLinks(UserRecentVersionDto object) {
  return [];
}

void _userRecentVersionDtoAttach(IsarCollection<dynamic> col, Id id, UserRecentVersionDto object) {
  object.localDatabaseId = id;
}

extension UserRecentVersionDtoQueryWhereSort on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QWhere> {
  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhere> anyLocalDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserRecentVersionDtoQueryWhere on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QWhereClause> {
  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> localDatabaseIdEqualTo(
      Id localDatabaseId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: localDatabaseId,
        upper: localDatabaseId,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> localDatabaseIdNotEqualTo(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> localDatabaseIdGreaterThan(
      Id localDatabaseId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: localDatabaseId, includeLower: include),
      );
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> localDatabaseIdLessThan(
      Id localDatabaseId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: localDatabaseId, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> localDatabaseIdBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> artistImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'artistImage',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> artistImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'artistImage',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> artistImageEqualTo(String? artistImage) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'artistImage',
        value: [artistImage],
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterWhereClause> artistImageNotEqualTo(
      String? artistImage) {
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
}

extension UserRecentVersionDtoQueryFilter
    on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QFilterCondition> {
  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'artistImage',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'artistImage',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageEqualTo(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageStartsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageEndsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'artistImage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'artistImage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'artistImage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artistImageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'artistImage',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> capoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'capo',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> capoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'capo',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> capoEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'capo',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> capoGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> capoLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> capoBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> instrumentEqualTo(Instrument value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instrument',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> instrumentGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> instrumentLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> instrumentBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'key',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyEqualTo(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyStartsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyEndsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> localDatabaseIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> localDatabaseIdGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> localDatabaseIdLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> localDatabaseIdBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> remoteDatabaseIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteDatabaseId',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> remoteDatabaseIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteDatabaseId',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> remoteDatabaseIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> remoteDatabaseIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> remoteDatabaseIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteDatabaseId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> remoteDatabaseIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteDatabaseId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songIdGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songIdLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songIdBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlEqualTo(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlStartsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlEndsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> songUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stdKey',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stdKey',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyEqualTo(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyStartsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyEndsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stdKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stdKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stdKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> stdKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stdKey',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tuning',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningEqualTo(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningBetween(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningStartsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningEndsWith(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tuning',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tuning',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> tuningIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tuning',
        value: '',
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> versionIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> versionIdGreaterThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> versionIdLessThan(
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

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> versionIdBetween(
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

extension UserRecentVersionDtoQueryObject
    on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QFilterCondition> {
  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterFilterCondition> artist(
      FilterQuery<UserVersionArtistDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'artist');
    });
  }
}

extension UserRecentVersionDtoQueryLinks
    on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QFilterCondition> {}

extension UserRecentVersionDtoQuerySortBy on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QSortBy> {
  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByArtistImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByArtistImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByInstrument() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByInstrumentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByRemoteDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByRemoteDatabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortBySongUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortBySongUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByStdKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByStdKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> sortByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }
}

extension UserRecentVersionDtoQuerySortThenBy on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QSortThenBy> {
  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByArtistImage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByArtistImageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'artistImage', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByCapoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'capo', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByInstrument() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByInstrumentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'instrument', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'key', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByLocalDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByLocalDatabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDatabaseId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByRemoteDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByRemoteDatabaseIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteDatabaseId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenBySongIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songId', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenBySongUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenBySongUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songUrl', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByStdKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByStdKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stdKey', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByTuning() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByTuningDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tuning', Sort.desc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.asc);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QAfterSortBy> thenByVersionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'versionId', Sort.desc);
    });
  }
}

extension UserRecentVersionDtoQueryWhereDistinct
    on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> {
  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByArtistImage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'artistImage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByCapo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'capo');
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByInstrument() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'instrument');
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'key', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByRemoteDatabaseId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteDatabaseId');
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctBySongId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songId');
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctBySongUrl({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songUrl', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByStdKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stdKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByTuning({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tuning', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QDistinct> distinctByVersionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'versionId');
    });
  }
}

extension UserRecentVersionDtoQueryProperty
    on QueryBuilder<UserRecentVersionDto, UserRecentVersionDto, QQueryProperty> {
  QueryBuilder<UserRecentVersionDto, int, QQueryOperations> localDatabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDatabaseId');
    });
  }

  QueryBuilder<UserRecentVersionDto, UserVersionArtistDto, QQueryOperations> artistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artist');
    });
  }

  QueryBuilder<UserRecentVersionDto, String?, QQueryOperations> artistImageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'artistImage');
    });
  }

  QueryBuilder<UserRecentVersionDto, int?, QQueryOperations> capoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'capo');
    });
  }

  QueryBuilder<UserRecentVersionDto, Instrument, QQueryOperations> instrumentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'instrument');
    });
  }

  QueryBuilder<UserRecentVersionDto, String?, QQueryOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'key');
    });
  }

  QueryBuilder<UserRecentVersionDto, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<UserRecentVersionDto, int?, QQueryOperations> remoteDatabaseIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteDatabaseId');
    });
  }

  QueryBuilder<UserRecentVersionDto, int, QQueryOperations> songIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songId');
    });
  }

  QueryBuilder<UserRecentVersionDto, String, QQueryOperations> songUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songUrl');
    });
  }

  QueryBuilder<UserRecentVersionDto, String?, QQueryOperations> stdKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stdKey');
    });
  }

  QueryBuilder<UserRecentVersionDto, String?, QQueryOperations> tuningProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tuning');
    });
  }

  QueryBuilder<UserRecentVersionDto, int, QQueryOperations> versionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'versionId');
    });
  }
}

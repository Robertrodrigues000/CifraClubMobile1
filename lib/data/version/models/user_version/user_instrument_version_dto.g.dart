// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_instrument_version_dto.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserInstrumentVersionDtoSchema = Schema(
  name: r'UserInstrumentVersionDto',
  id: 7008447098937058674,
  properties: {
    r'completePath': PropertySchema(
      id: 0,
      name: r'completePath',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.long,
    ),
    r'isVerified': PropertySchema(
      id: 2,
      name: r'isVerified',
      type: IsarType.bool,
    ),
    r'versionName': PropertySchema(
      id: 3,
      name: r'versionName',
      type: IsarType.string,
    ),
    r'versionUrl': PropertySchema(
      id: 4,
      name: r'versionUrl',
      type: IsarType.string,
    ),
    r'videoLesson': PropertySchema(
      id: 5,
      name: r'videoLesson',
      type: IsarType.object,
      target: r'UserVersionDataVideoLessonDto',
    )
  },
  estimateSize: _userInstrumentVersionDtoEstimateSize,
  serialize: _userInstrumentVersionDtoSerialize,
  deserialize: _userInstrumentVersionDtoDeserialize,
  deserializeProp: _userInstrumentVersionDtoDeserializeProp,
);

int _userInstrumentVersionDtoEstimateSize(
  UserInstrumentVersionDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.completePath.length * 3;
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

void _userInstrumentVersionDtoSerialize(
  UserInstrumentVersionDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.completePath);
  writer.writeLong(offsets[1], object.id);
  writer.writeBool(offsets[2], object.isVerified);
  writer.writeString(offsets[3], object.versionName);
  writer.writeString(offsets[4], object.versionUrl);
  writer.writeObject<UserVersionDataVideoLessonDto>(
    offsets[5],
    allOffsets,
    UserVersionDataVideoLessonDtoSchema.serialize,
    object.videoLesson,
  );
}

UserInstrumentVersionDto _userInstrumentVersionDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserInstrumentVersionDto();
  object.completePath = reader.readString(offsets[0]);
  object.id = reader.readLong(offsets[1]);
  object.isVerified = reader.readBool(offsets[2]);
  object.versionName = reader.readString(offsets[3]);
  object.versionUrl = reader.readString(offsets[4]);
  object.videoLesson = reader.readObjectOrNull<UserVersionDataVideoLessonDto>(
    offsets[5],
    UserVersionDataVideoLessonDtoSchema.deserialize,
    allOffsets,
  );
  return object;
}

P _userInstrumentVersionDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<UserVersionDataVideoLessonDto>(
        offset,
        UserVersionDataVideoLessonDtoSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserInstrumentVersionDtoQueryFilter
    on QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QFilterCondition> {
  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathEqualTo(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathGreaterThan(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathLessThan(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathBetween(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathStartsWith(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathEndsWith(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'completePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'completePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> completePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'completePath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> idGreaterThan(
    int value, {
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> idLessThan(
    int value, {
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> isVerifiedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isVerified',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameEqualTo(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameGreaterThan(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameLessThan(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameBetween(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameStartsWith(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameEndsWith(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlEqualTo(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlGreaterThan(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlLessThan(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlBetween(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlStartsWith(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlEndsWith(
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

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'versionUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'versionUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'versionUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> versionUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'versionUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> videoLessonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'videoLesson',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> videoLessonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'videoLesson',
      ));
    });
  }
}

extension UserInstrumentVersionDtoQueryObject
    on QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QFilterCondition> {
  QueryBuilder<UserInstrumentVersionDto, UserInstrumentVersionDto, QAfterFilterCondition> videoLesson(
      FilterQuery<UserVersionDataVideoLessonDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'videoLesson');
    });
  }
}

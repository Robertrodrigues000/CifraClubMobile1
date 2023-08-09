// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_instrument_versions_dto.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserInstrumentVersionsDtoSchema = Schema(
  name: r'UserInstrumentVersionsDto',
  id: 1238804202600983845,
  properties: {
    r'label': PropertySchema(
      id: 0,
      name: r'label',
      type: IsarType.string,
    ),
    r'songs': PropertySchema(
      id: 1,
      name: r'songs',
      type: IsarType.objectList,
      target: r'UserInstrumentVersionDto',
    ),
    r'type': PropertySchema(
      id: 2,
      name: r'type',
      type: IsarType.long,
    )
  },
  estimateSize: _userInstrumentVersionsDtoEstimateSize,
  serialize: _userInstrumentVersionsDtoSerialize,
  deserialize: _userInstrumentVersionsDtoDeserialize,
  deserializeProp: _userInstrumentVersionsDtoDeserializeProp,
);

int _userInstrumentVersionsDtoEstimateSize(
  UserInstrumentVersionsDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.label.length * 3;
  {
    final list = object.songs;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[UserInstrumentVersionDto]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += UserInstrumentVersionDtoSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  return bytesCount;
}

void _userInstrumentVersionsDtoSerialize(
  UserInstrumentVersionsDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.label);
  writer.writeObjectList<UserInstrumentVersionDto>(
    offsets[1],
    allOffsets,
    UserInstrumentVersionDtoSchema.serialize,
    object.songs,
  );
  writer.writeLong(offsets[2], object.type);
}

UserInstrumentVersionsDto _userInstrumentVersionsDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserInstrumentVersionsDto();
  object.label = reader.readString(offsets[0]);
  object.songs = reader.readObjectList<UserInstrumentVersionDto>(
    offsets[1],
    UserInstrumentVersionDtoSchema.deserialize,
    allOffsets,
    UserInstrumentVersionDto(),
  );
  object.type = reader.readLong(offsets[2]);
  return object;
}

P _userInstrumentVersionsDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<UserInstrumentVersionDto>(
        offset,
        UserInstrumentVersionDtoSchema.deserialize,
        allOffsets,
        UserInstrumentVersionDto(),
      )) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserInstrumentVersionsDtoQueryFilter
    on QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QFilterCondition> {
  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelEqualTo(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelGreaterThan(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelLessThan(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelBetween(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelStartsWith(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelEndsWith(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'label',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'label',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> labelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'label',
        value: '',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'songs',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'songs',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songs',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songs',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songs',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songs',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songs',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'songs',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> typeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> typeGreaterThan(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> typeLessThan(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> typeBetween(
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
}

extension UserInstrumentVersionsDtoQueryObject
    on QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QFilterCondition> {
  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> songsElement(
      FilterQuery<UserInstrumentVersionDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'songs');
    });
  }
}

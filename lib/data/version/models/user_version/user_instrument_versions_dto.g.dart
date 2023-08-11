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
    r'instrument': PropertySchema(
      id: 0,
      name: r'instrument',
      type: IsarType.byte,
      enumMap: _UserInstrumentVersionsDtoinstrumentEnumValueMap,
    ),
    r'versions': PropertySchema(
      id: 1,
      name: r'versions',
      type: IsarType.objectList,
      target: r'UserInstrumentVersionDto',
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
  {
    final list = object.versions;
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
  writer.writeByte(offsets[0], object.instrument.index);
  writer.writeObjectList<UserInstrumentVersionDto>(
    offsets[1],
    allOffsets,
    UserInstrumentVersionDtoSchema.serialize,
    object.versions,
  );
}

UserInstrumentVersionsDto _userInstrumentVersionsDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserInstrumentVersionsDto();
  object.instrument =
      _UserInstrumentVersionsDtoinstrumentValueEnumMap[reader.readByteOrNull(offsets[0])] ?? Instrument.guitar;
  object.versions = reader.readObjectList<UserInstrumentVersionDto>(
    offsets[1],
    UserInstrumentVersionDtoSchema.deserialize,
    allOffsets,
    UserInstrumentVersionDto(),
  );
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
      return (_UserInstrumentVersionsDtoinstrumentValueEnumMap[reader.readByteOrNull(offset)] ?? Instrument.guitar)
          as P;
    case 1:
      return (reader.readObjectList<UserInstrumentVersionDto>(
        offset,
        UserInstrumentVersionDtoSchema.deserialize,
        allOffsets,
        UserInstrumentVersionDto(),
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserInstrumentVersionsDtoinstrumentEnumValueMap = {
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
const _UserInstrumentVersionsDtoinstrumentValueEnumMap = {
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

extension UserInstrumentVersionsDtoQueryFilter
    on QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QFilterCondition> {
  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> instrumentEqualTo(
      Instrument value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'instrument',
        value: value,
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> instrumentGreaterThan(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> instrumentLessThan(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> instrumentBetween(
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

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'versions',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'versions',
      ));
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'versions',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'versions',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'versions',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'versions',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'versions',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'versions',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension UserInstrumentVersionsDtoQueryObject
    on QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QFilterCondition> {
  QueryBuilder<UserInstrumentVersionsDto, UserInstrumentVersionsDto, QAfterFilterCondition> versionsElement(
      FilterQuery<UserInstrumentVersionDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'versions');
    });
  }
}

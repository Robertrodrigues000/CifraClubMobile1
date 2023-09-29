// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_chord_dto.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserChordDtoSchema = Schema(
  name: r'UserChordDto',
  id: 754604440676385279,
  properties: {
    r'cavaco': PropertySchema(
      id: 0,
      name: r'cavaco',
      type: IsarType.stringList,
    ),
    r'guitar': PropertySchema(
      id: 1,
      name: r'guitar',
      type: IsarType.stringList,
    ),
    r'keyboard': PropertySchema(
      id: 2,
      name: r'keyboard',
      type: IsarType.stringList,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'shapeName': PropertySchema(
      id: 4,
      name: r'shapeName',
      type: IsarType.string,
    ),
    r'ukulele': PropertySchema(
      id: 5,
      name: r'ukulele',
      type: IsarType.stringList,
    ),
    r'viola': PropertySchema(
      id: 6,
      name: r'viola',
      type: IsarType.stringList,
    ),
    r'violaMi': PropertySchema(
      id: 7,
      name: r'violaMi',
      type: IsarType.stringList,
    ),
    r'violaRa': PropertySchema(
      id: 8,
      name: r'violaRa',
      type: IsarType.stringList,
    )
  },
  estimateSize: _userChordDtoEstimateSize,
  serialize: _userChordDtoSerialize,
  deserialize: _userChordDtoDeserialize,
  deserializeProp: _userChordDtoDeserializeProp,
);

int _userChordDtoEstimateSize(
  UserChordDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.cavaco;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.guitar;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.keyboard;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.shapeName.length * 3;
  {
    final list = object.ukulele;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.viola;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.violaMi;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.violaRa;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  return bytesCount;
}

void _userChordDtoSerialize(
  UserChordDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.cavaco);
  writer.writeStringList(offsets[1], object.guitar);
  writer.writeStringList(offsets[2], object.keyboard);
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.shapeName);
  writer.writeStringList(offsets[5], object.ukulele);
  writer.writeStringList(offsets[6], object.viola);
  writer.writeStringList(offsets[7], object.violaMi);
  writer.writeStringList(offsets[8], object.violaRa);
}

UserChordDto _userChordDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserChordDto();
  object.cavaco = reader.readStringList(offsets[0]);
  object.guitar = reader.readStringList(offsets[1]);
  object.keyboard = reader.readStringList(offsets[2]);
  object.name = reader.readString(offsets[3]);
  object.shapeName = reader.readString(offsets[4]);
  object.ukulele = reader.readStringList(offsets[5]);
  object.viola = reader.readStringList(offsets[6]);
  object.violaMi = reader.readStringList(offsets[7]);
  object.violaRa = reader.readStringList(offsets[8]);
  return object;
}

P _userChordDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringList(offset)) as P;
    case 6:
      return (reader.readStringList(offset)) as P;
    case 7:
      return (reader.readStringList(offset)) as P;
    case 8:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserChordDtoQueryFilter on QueryBuilder<UserChordDto, UserChordDto, QFilterCondition> {
  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cavaco',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cavaco',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cavaco',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cavaco',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cavaco',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cavaco',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cavaco',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cavaco',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cavaco',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cavaco',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cavaco',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cavaco',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cavaco',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cavaco',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cavaco',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cavaco',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cavaco',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> cavacoLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cavaco',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'guitar',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'guitar',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'guitar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'guitar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'guitar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'guitar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'guitar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'guitar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'guitar',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'guitar',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'guitar',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'guitar',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'guitar',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'guitar',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'guitar',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'guitar',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'guitar',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> guitarLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'guitar',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'keyboard',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'keyboard',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keyboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keyboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keyboard',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keyboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keyboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keyboard',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keyboard',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keyboard',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keyboard',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyboard',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyboard',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyboard',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyboard',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyboard',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> keyboardLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'keyboard',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shapeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shapeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shapeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shapeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shapeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shapeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shapeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shapeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shapeName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> shapeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shapeName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ukulele',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ukulele',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ukulele',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ukulele',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ukulele',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ukulele',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ukulele',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ukulele',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ukulele',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ukulele',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ukulele',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ukulele',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ukulele',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ukulele',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ukulele',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ukulele',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ukulele',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> ukuleleLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'ukulele',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'viola',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'viola',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viola',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'viola',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'viola',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'viola',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'viola',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'viola',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'viola',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'viola',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'viola',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'viola',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viola',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viola',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viola',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viola',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viola',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'viola',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'violaMi',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'violaMi',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'violaMi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'violaMi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'violaMi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'violaMi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'violaMi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'violaMi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'violaMi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'violaMi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'violaMi',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'violaMi',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaMi',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaMi',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaMi',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaMi',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaMi',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaMiLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaMi',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'violaRa',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'violaRa',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'violaRa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'violaRa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'violaRa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'violaRa',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'violaRa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'violaRa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'violaRa',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'violaRa',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'violaRa',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'violaRa',
        value: '',
      ));
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaRa',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaRa',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaRa',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaRa',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaRa',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserChordDto, UserChordDto, QAfterFilterCondition> violaRaLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'violaRa',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension UserChordDtoQueryObject on QueryBuilder<UserChordDto, UserChordDto, QFilterCondition> {}

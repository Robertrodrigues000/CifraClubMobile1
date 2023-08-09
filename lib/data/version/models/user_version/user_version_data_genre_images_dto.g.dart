// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_version_data_genre_images_dto.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserVersionDataGenreImagesDtoSchema = Schema(
  name: r'UserVersionDataGenreImagesDto',
  id: -5188842830262134987,
  properties: {
    r'dark': PropertySchema(
      id: 0,
      name: r'dark',
      type: IsarType.string,
    ),
    r'darkInactive': PropertySchema(
      id: 1,
      name: r'darkInactive',
      type: IsarType.string,
    ),
    r'light': PropertySchema(
      id: 2,
      name: r'light',
      type: IsarType.string,
    ),
    r'lightInactive': PropertySchema(
      id: 3,
      name: r'lightInactive',
      type: IsarType.string,
    )
  },
  estimateSize: _userVersionDataGenreImagesDtoEstimateSize,
  serialize: _userVersionDataGenreImagesDtoSerialize,
  deserialize: _userVersionDataGenreImagesDtoDeserialize,
  deserializeProp: _userVersionDataGenreImagesDtoDeserializeProp,
);

int _userVersionDataGenreImagesDtoEstimateSize(
  UserVersionDataGenreImagesDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.dark;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.darkInactive;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.light;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.lightInactive;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userVersionDataGenreImagesDtoSerialize(
  UserVersionDataGenreImagesDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dark);
  writer.writeString(offsets[1], object.darkInactive);
  writer.writeString(offsets[2], object.light);
  writer.writeString(offsets[3], object.lightInactive);
}

UserVersionDataGenreImagesDto _userVersionDataGenreImagesDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserVersionDataGenreImagesDto(
    dark: reader.readStringOrNull(offsets[0]),
    darkInactive: reader.readStringOrNull(offsets[1]),
    light: reader.readStringOrNull(offsets[2]),
    lightInactive: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _userVersionDataGenreImagesDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserVersionDataGenreImagesDtoQueryFilter
    on QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QFilterCondition> {
  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dark',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dark',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dark',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dark',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dark',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dark',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dark',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'darkInactive',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'darkInactive',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkInactiveEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'darkInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'darkInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'darkInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkInactiveBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'darkInactive',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'darkInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'darkInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'darkInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> darkInactiveMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'darkInactive',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'darkInactive',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      darkInactiveIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'darkInactive',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'light',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'light',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'light',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'light',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'light',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'light',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'light',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'light',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'light',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'light',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'light',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition> lightIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'light',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lightInactive',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lightInactive',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lightInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lightInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lightInactive',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lightInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lightInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lightInactive',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lightInactive',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lightInactive',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QAfterFilterCondition>
      lightInactiveIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lightInactive',
        value: '',
      ));
    });
  }
}

extension UserVersionDataGenreImagesDtoQueryObject
    on QueryBuilder<UserVersionDataGenreImagesDto, UserVersionDataGenreImagesDto, QFilterCondition> {}

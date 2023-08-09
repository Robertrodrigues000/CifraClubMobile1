// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_artist_image_dto.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserVersionDataArtistImageDtoSchema = Schema(
  name: r'UserVersionDataArtistImageDto',
  id: 4255970876447765541,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.string,
    ),
    r'size162': PropertySchema(
      id: 1,
      name: r'size162',
      type: IsarType.string,
    ),
    r'size250': PropertySchema(
      id: 2,
      name: r'size250',
      type: IsarType.string,
    ),
    r'size50': PropertySchema(
      id: 3,
      name: r'size50',
      type: IsarType.string,
    )
  },
  estimateSize: _userVersionDataArtistImageDtoEstimateSize,
  serialize: _userVersionDataArtistImageDtoSerialize,
  deserialize: _userVersionDataArtistImageDtoDeserialize,
  deserializeProp: _userVersionDataArtistImageDtoDeserializeProp,
);

int _userVersionDataArtistImageDtoEstimateSize(
  UserVersionDataArtistImageDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.color;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.size162;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.size250;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.size50;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userVersionDataArtistImageDtoSerialize(
  UserVersionDataArtistImageDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.color);
  writer.writeString(offsets[1], object.size162);
  writer.writeString(offsets[2], object.size250);
  writer.writeString(offsets[3], object.size50);
}

UserVersionDataArtistImageDto _userVersionDataArtistImageDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserVersionDataArtistImageDto(
    color: reader.readStringOrNull(offsets[0]),
    size162: reader.readStringOrNull(offsets[1]),
    size250: reader.readStringOrNull(offsets[2]),
    size50: reader.readStringOrNull(offsets[3]),
  );
  return object;
}

P _userVersionDataArtistImageDtoDeserializeProp<P>(
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

extension UserVersionDataArtistImageDtoQueryFilter
    on QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QFilterCondition> {
  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size162',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size162',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size162',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size162',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size162',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size162',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'size162',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'size162',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'size162',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'size162',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size162IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size162',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition>
      size162IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'size162',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size250',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size250',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size250',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size250',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size250',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size250',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'size250',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'size250',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'size250',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'size250',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size250IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size250',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition>
      size250IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'size250',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size50',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size50',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size50',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size50',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size50',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size50',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'size50',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'size50',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'size50',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'size50',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size50',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QAfterFilterCondition> size50IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'size50',
        value: '',
      ));
    });
  }
}

extension UserVersionDataArtistImageDtoQueryObject
    on QueryBuilder<UserVersionDataArtistImageDto, UserVersionDataArtistImageDto, QFilterCondition> {}

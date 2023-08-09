// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_version_data_artist_dto.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const UserVersionDataArtistDtoSchema = Schema(
  name: r'UserVersionDataArtistDto',
  id: -6823693305576410695,
  properties: {
    r'genre': PropertySchema(
      id: 0,
      name: r'genre',
      type: IsarType.object,
      target: r'UserVersionDataGenreDto',
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.long,
    ),
    r'image': PropertySchema(
      id: 2,
      name: r'image',
      type: IsarType.object,
      target: r'UserVersionDataArtistImageDto',
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'url': PropertySchema(
      id: 4,
      name: r'url',
      type: IsarType.string,
    )
  },
  estimateSize: _userVersionDataArtistDtoEstimateSize,
  serialize: _userVersionDataArtistDtoSerialize,
  deserialize: _userVersionDataArtistDtoDeserialize,
  deserializeProp: _userVersionDataArtistDtoDeserializeProp,
);

int _userVersionDataArtistDtoEstimateSize(
  UserVersionDataArtistDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.genre;
    if (value != null) {
      bytesCount +=
          3 + UserVersionDataGenreDtoSchema.estimateSize(value, allOffsets[UserVersionDataGenreDto]!, allOffsets);
    }
  }
  {
    final value = object.image;
    if (value != null) {
      bytesCount += 3 +
          UserVersionDataArtistImageDtoSchema.estimateSize(
              value, allOffsets[UserVersionDataArtistImageDto]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.url.length * 3;
  return bytesCount;
}

void _userVersionDataArtistDtoSerialize(
  UserVersionDataArtistDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<UserVersionDataGenreDto>(
    offsets[0],
    allOffsets,
    UserVersionDataGenreDtoSchema.serialize,
    object.genre,
  );
  writer.writeLong(offsets[1], object.id);
  writer.writeObject<UserVersionDataArtistImageDto>(
    offsets[2],
    allOffsets,
    UserVersionDataArtistImageDtoSchema.serialize,
    object.image,
  );
  writer.writeString(offsets[3], object.name);
  writer.writeString(offsets[4], object.url);
}

UserVersionDataArtistDto _userVersionDataArtistDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserVersionDataArtistDto();
  object.genre = reader.readObjectOrNull<UserVersionDataGenreDto>(
    offsets[0],
    UserVersionDataGenreDtoSchema.deserialize,
    allOffsets,
  );
  object.id = reader.readLong(offsets[1]);
  object.image = reader.readObjectOrNull<UserVersionDataArtistImageDto>(
    offsets[2],
    UserVersionDataArtistImageDtoSchema.deserialize,
    allOffsets,
  );
  object.name = reader.readString(offsets[3]);
  object.url = reader.readString(offsets[4]);
  return object;
}

P _userVersionDataArtistDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<UserVersionDataGenreDto>(
        offset,
        UserVersionDataGenreDtoSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<UserVersionDataArtistImageDto>(
        offset,
        UserVersionDataArtistImageDtoSchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension UserVersionDataArtistDtoQueryFilter
    on QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QFilterCondition> {
  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> genreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'genre',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> genreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'genre',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> idEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> imageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> imageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'image',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'url',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'url',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'url',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'url',
        value: '',
      ));
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> urlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'url',
        value: '',
      ));
    });
  }
}

extension UserVersionDataArtistDtoQueryObject
    on QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QFilterCondition> {
  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> genre(
      FilterQuery<UserVersionDataGenreDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'genre');
    });
  }

  QueryBuilder<UserVersionDataArtistDto, UserVersionDataArtistDto, QAfterFilterCondition> image(
      FilterQuery<UserVersionDataArtistImageDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'image');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_genres_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserGenresDtoCollection on Isar {
  IsarCollection<UserGenresDto> get userGenresDtos => this.collection();
}

const UserGenresDtoSchema = CollectionSchema(
  name: r'UserGenresDto',
  id: -5946927811144364265,
  properties: {
    r'genres': PropertySchema(
      id: 0,
      name: r'genres',
      type: IsarType.objectList,
      target: r'UserGenreDto',
    )
  },
  estimateSize: _userGenresDtoEstimateSize,
  serialize: _userGenresDtoSerialize,
  deserialize: _userGenresDtoDeserialize,
  deserializeProp: _userGenresDtoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'UserGenreDto': UserGenreDtoSchema},
  getId: _userGenresDtoGetId,
  getLinks: _userGenresDtoGetLinks,
  attach: _userGenresDtoAttach,
  version: '3.1.0+1',
);

int _userGenresDtoEstimateSize(
  UserGenresDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.genres.length * 3;
  {
    final offsets = allOffsets[UserGenreDto]!;
    for (var i = 0; i < object.genres.length; i++) {
      final value = object.genres[i];
      bytesCount += UserGenreDtoSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _userGenresDtoSerialize(
  UserGenresDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<UserGenreDto>(
    offsets[0],
    allOffsets,
    UserGenreDtoSchema.serialize,
    object.genres,
  );
}

UserGenresDto _userGenresDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserGenresDto(
    genres: reader.readObjectList<UserGenreDto>(
          offsets[0],
          UserGenreDtoSchema.deserialize,
          allOffsets,
          UserGenreDto(),
        ) ??
        [],
  );
  object.id = id;
  return object;
}

P _userGenresDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<UserGenreDto>(
            offset,
            UserGenreDtoSchema.deserialize,
            allOffsets,
            UserGenreDto(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userGenresDtoGetId(UserGenresDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userGenresDtoGetLinks(UserGenresDto object) {
  return [];
}

void _userGenresDtoAttach(IsarCollection<dynamic> col, Id id, UserGenresDto object) {
  object.id = id;
}

extension UserGenresDtoQueryWhereSort on QueryBuilder<UserGenresDto, UserGenresDto, QWhere> {
  QueryBuilder<UserGenresDto, UserGenresDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserGenresDtoQueryWhere on QueryBuilder<UserGenresDto, UserGenresDto, QWhereClause> {
  QueryBuilder<UserGenresDto, UserGenresDto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserGenresDtoQueryFilter on QueryBuilder<UserGenresDto, UserGenresDto, QFilterCondition> {
  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> genresLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> genresIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> genresIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> genresLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> genresLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> genresLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'genres',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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
}

extension UserGenresDtoQueryObject on QueryBuilder<UserGenresDto, UserGenresDto, QFilterCondition> {
  QueryBuilder<UserGenresDto, UserGenresDto, QAfterFilterCondition> genresElement(FilterQuery<UserGenreDto> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'genres');
    });
  }
}

extension UserGenresDtoQueryLinks on QueryBuilder<UserGenresDto, UserGenresDto, QFilterCondition> {}

extension UserGenresDtoQuerySortBy on QueryBuilder<UserGenresDto, UserGenresDto, QSortBy> {}

extension UserGenresDtoQuerySortThenBy on QueryBuilder<UserGenresDto, UserGenresDto, QSortThenBy> {
  QueryBuilder<UserGenresDto, UserGenresDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserGenresDto, UserGenresDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension UserGenresDtoQueryWhereDistinct on QueryBuilder<UserGenresDto, UserGenresDto, QDistinct> {}

extension UserGenresDtoQueryProperty on QueryBuilder<UserGenresDto, UserGenresDto, QQueryProperty> {
  QueryBuilder<UserGenresDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserGenresDto, List<UserGenreDto>, QQueryOperations> genresProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'genres');
    });
  }
}

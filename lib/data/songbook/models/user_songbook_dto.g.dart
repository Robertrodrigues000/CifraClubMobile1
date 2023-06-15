// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_songbook_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UserSongbookDtoCWProxy {
  UserSongbookDto id(int id);

  UserSongbookDto createdAt(DateTime createdAt);

  UserSongbookDto lastUpdated(DateTime? lastUpdated);

  UserSongbookDto name(String name);

  UserSongbookDto userName(String? userName);

  UserSongbookDto userId(int? userId);

  UserSongbookDto thumb(String? thumb);

  UserSongbookDto type(ListTypeDto type);

  UserSongbookDto isPublic(bool isPublic);

  UserSongbookDto status(int? status);

  UserSongbookDto totalSongs(int? totalSongs);

  UserSongbookDto timestamp(int? timestamp);

  UserSongbookDto preview(List<String?> preview);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserSongbookDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserSongbookDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserSongbookDto call({
    int? id,
    DateTime? createdAt,
    DateTime? lastUpdated,
    String? name,
    String? userName,
    int? userId,
    String? thumb,
    ListTypeDto? type,
    bool? isPublic,
    int? status,
    int? totalSongs,
    int? timestamp,
    List<String?>? preview,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUserSongbookDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUserSongbookDto.copyWith.fieldName(...)`
class _$UserSongbookDtoCWProxyImpl implements _$UserSongbookDtoCWProxy {
  const _$UserSongbookDtoCWProxyImpl(this._value);

  final UserSongbookDto _value;

  @override
  UserSongbookDto id(int id) => this(id: id);

  @override
  UserSongbookDto createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  UserSongbookDto lastUpdated(DateTime? lastUpdated) => this(lastUpdated: lastUpdated);

  @override
  UserSongbookDto name(String name) => this(name: name);

  @override
  UserSongbookDto userName(String? userName) => this(userName: userName);

  @override
  UserSongbookDto userId(int? userId) => this(userId: userId);

  @override
  UserSongbookDto thumb(String? thumb) => this(thumb: thumb);

  @override
  UserSongbookDto type(ListTypeDto type) => this(type: type);

  @override
  UserSongbookDto isPublic(bool isPublic) => this(isPublic: isPublic);

  @override
  UserSongbookDto status(int? status) => this(status: status);

  @override
  UserSongbookDto totalSongs(int? totalSongs) => this(totalSongs: totalSongs);

  @override
  UserSongbookDto timestamp(int? timestamp) => this(timestamp: timestamp);

  @override
  UserSongbookDto preview(List<String?> preview) => this(preview: preview);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UserSongbookDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UserSongbookDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UserSongbookDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? lastUpdated = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
    Object? userName = const $CopyWithPlaceholder(),
    Object? userId = const $CopyWithPlaceholder(),
    Object? thumb = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? isPublic = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? totalSongs = const $CopyWithPlaceholder(),
    Object? timestamp = const $CopyWithPlaceholder(),
    Object? preview = const $CopyWithPlaceholder(),
  }) {
    return UserSongbookDto(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      lastUpdated: lastUpdated == const $CopyWithPlaceholder()
          ? _value.lastUpdated
          // ignore: cast_nullable_to_non_nullable
          : lastUpdated as DateTime?,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      userName: userName == const $CopyWithPlaceholder()
          ? _value.userName
          // ignore: cast_nullable_to_non_nullable
          : userName as String?,
      userId: userId == const $CopyWithPlaceholder()
          ? _value.userId
          // ignore: cast_nullable_to_non_nullable
          : userId as int?,
      thumb: thumb == const $CopyWithPlaceholder()
          ? _value.thumb
          // ignore: cast_nullable_to_non_nullable
          : thumb as String?,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ListTypeDto,
      isPublic: isPublic == const $CopyWithPlaceholder() || isPublic == null
          ? _value.isPublic
          // ignore: cast_nullable_to_non_nullable
          : isPublic as bool,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as int?,
      totalSongs: totalSongs == const $CopyWithPlaceholder()
          ? _value.totalSongs
          // ignore: cast_nullable_to_non_nullable
          : totalSongs as int?,
      timestamp: timestamp == const $CopyWithPlaceholder()
          ? _value.timestamp
          // ignore: cast_nullable_to_non_nullable
          : timestamp as int?,
      preview: preview == const $CopyWithPlaceholder() || preview == null
          ? _value.preview
          // ignore: cast_nullable_to_non_nullable
          : preview as List<String?>,
    );
  }
}

extension $UserSongbookDtoCopyWith on UserSongbookDto {
  /// Returns a callable class that can be used as follows: `instanceOfUserSongbookDto.copyWith(...)` or like so:`instanceOfUserSongbookDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UserSongbookDtoCWProxy get copyWith => _$UserSongbookDtoCWProxyImpl(this);
}

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserSongbookDtoCollection on Isar {
  IsarCollection<UserSongbookDto> get userSongbookDtos => this.collection();
}

const UserSongbookDtoSchema = CollectionSchema(
  name: r'UserSongbookDto',
  id: 7814832261536344850,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'isPublic': PropertySchema(
      id: 1,
      name: r'isPublic',
      type: IsarType.bool,
    ),
    r'lastUpdated': PropertySchema(
      id: 2,
      name: r'lastUpdated',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 3,
      name: r'name',
      type: IsarType.string,
    ),
    r'preview': PropertySchema(
      id: 4,
      name: r'preview',
      type: IsarType.stringList,
    ),
    r'status': PropertySchema(
      id: 5,
      name: r'status',
      type: IsarType.long,
    ),
    r'thumb': PropertySchema(
      id: 6,
      name: r'thumb',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 7,
      name: r'timestamp',
      type: IsarType.long,
    ),
    r'totalSongs': PropertySchema(
      id: 8,
      name: r'totalSongs',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.byte,
      enumMap: _UserSongbookDtotypeEnumValueMap,
    ),
    r'userId': PropertySchema(
      id: 10,
      name: r'userId',
      type: IsarType.long,
    ),
    r'userName': PropertySchema(
      id: 11,
      name: r'userName',
      type: IsarType.string,
    )
  },
  estimateSize: _userSongbookDtoEstimateSize,
  serialize: _userSongbookDtoSerialize,
  deserialize: _userSongbookDtoDeserialize,
  deserializeProp: _userSongbookDtoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userSongbookDtoGetId,
  getLinks: _userSongbookDtoGetLinks,
  attach: _userSongbookDtoAttach,
  version: '3.1.0+1',
);

int _userSongbookDtoEstimateSize(
  UserSongbookDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.preview.length * 3;
  {
    for (var i = 0; i < object.preview.length; i++) {
      final value = object.preview[i];
      if (value != null) {
        bytesCount += value.length * 3;
      }
    }
  }
  {
    final value = object.thumb;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _userSongbookDtoSerialize(
  UserSongbookDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeBool(offsets[1], object.isPublic);
  writer.writeDateTime(offsets[2], object.lastUpdated);
  writer.writeString(offsets[3], object.name);
  writer.writeStringList(offsets[4], object.preview);
  writer.writeLong(offsets[5], object.status);
  writer.writeString(offsets[6], object.thumb);
  writer.writeLong(offsets[7], object.timestamp);
  writer.writeLong(offsets[8], object.totalSongs);
  writer.writeByte(offsets[9], object.type.index);
  writer.writeLong(offsets[10], object.userId);
  writer.writeString(offsets[11], object.userName);
}

UserSongbookDto _userSongbookDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSongbookDto(
    createdAt: reader.readDateTime(offsets[0]),
    id: id,
    isPublic: reader.readBool(offsets[1]),
    lastUpdated: reader.readDateTimeOrNull(offsets[2]),
    name: reader.readString(offsets[3]),
    preview: reader.readStringOrNullList(offsets[4]) ?? [],
    status: reader.readLongOrNull(offsets[5]),
    thumb: reader.readStringOrNull(offsets[6]),
    timestamp: reader.readLongOrNull(offsets[7]),
    totalSongs: reader.readLongOrNull(offsets[8]),
    type: _UserSongbookDtotypeValueEnumMap[reader.readByteOrNull(offsets[9])] ?? ListTypeDto.user,
    userId: reader.readLongOrNull(offsets[10]),
    userName: reader.readStringOrNull(offsets[11]),
  );
  return object;
}

P _userSongbookDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNullList(offset) ?? []) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (_UserSongbookDtotypeValueEnumMap[reader.readByteOrNull(offset)] ?? ListTypeDto.user) as P;
    case 10:
      return (reader.readLongOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserSongbookDtotypeEnumValueMap = {
  'user': 0,
  'favorites': 1,
  'canPlay': 2,
  'cantPlay': 3,
  'recents': 4,
};
const _UserSongbookDtotypeValueEnumMap = {
  0: ListTypeDto.user,
  1: ListTypeDto.favorites,
  2: ListTypeDto.canPlay,
  3: ListTypeDto.cantPlay,
  4: ListTypeDto.recents,
};

Id _userSongbookDtoGetId(UserSongbookDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userSongbookDtoGetLinks(UserSongbookDto object) {
  return [];
}

void _userSongbookDtoAttach(IsarCollection<dynamic> col, Id id, UserSongbookDto object) {}

extension UserSongbookDtoQueryWhereSort on QueryBuilder<UserSongbookDto, UserSongbookDto, QWhere> {
  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserSongbookDtoQueryWhere on QueryBuilder<UserSongbookDto, UserSongbookDto, QWhereClause> {
  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterWhereClause> idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterWhereClause> idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterWhereClause> idBetween(
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

extension UserSongbookDtoQueryFilter on QueryBuilder<UserSongbookDto, UserSongbookDto, QFilterCondition> {
  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> isPublicEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublic',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> lastUpdatedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> lastUpdatedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdated',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> lastUpdatedEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> lastUpdatedGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> lastUpdatedLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdated',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> lastUpdatedBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNull(
        property: r'preview',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNotNull(
        property: r'preview',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'preview',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'preview',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'preview',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'preview',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'preview',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preview',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preview',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preview',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preview',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preview',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> previewLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'preview',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> statusEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> statusGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> statusLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> statusBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'thumb',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'thumb',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'thumb',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'thumb',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'thumb',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'thumb',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> thumbIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'thumb',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> timestampIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> timestampIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'timestamp',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> timestampEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> timestampGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> timestampLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> timestampBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> totalSongsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'totalSongs',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> totalSongsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'totalSongs',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> totalSongsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalSongs',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> totalSongsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalSongs',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> totalSongsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalSongs',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> totalSongsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalSongs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> typeEqualTo(ListTypeDto value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> typeGreaterThan(
    ListTypeDto value, {
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> typeLessThan(
    ListTypeDto value, {
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> typeBetween(
    ListTypeDto lower,
    ListTypeDto upper, {
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

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterFilterCondition> userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }
}

extension UserSongbookDtoQueryObject on QueryBuilder<UserSongbookDto, UserSongbookDto, QFilterCondition> {}

extension UserSongbookDtoQueryLinks on QueryBuilder<UserSongbookDto, UserSongbookDto, QFilterCondition> {}

extension UserSongbookDtoQuerySortBy on QueryBuilder<UserSongbookDto, UserSongbookDto, QSortBy> {
  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByThumb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByThumbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByTotalSongs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSongs', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByTotalSongsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSongs', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension UserSongbookDtoQuerySortThenBy on QueryBuilder<UserSongbookDto, UserSongbookDto, QSortThenBy> {
  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByIsPublicDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublic', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByLastUpdatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdated', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByThumb() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByThumbDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'thumb', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByTotalSongs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSongs', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByTotalSongsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalSongs', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QAfterSortBy> thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension UserSongbookDtoQueryWhereDistinct on QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> {
  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByIsPublic() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublic');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByLastUpdated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdated');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByPreview() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'preview');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByThumb({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'thumb', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByTotalSongs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalSongs');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }

  QueryBuilder<UserSongbookDto, UserSongbookDto, QDistinct> distinctByUserName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension UserSongbookDtoQueryProperty on QueryBuilder<UserSongbookDto, UserSongbookDto, QQueryProperty> {
  QueryBuilder<UserSongbookDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSongbookDto, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<UserSongbookDto, bool, QQueryOperations> isPublicProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublic');
    });
  }

  QueryBuilder<UserSongbookDto, DateTime?, QQueryOperations> lastUpdatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdated');
    });
  }

  QueryBuilder<UserSongbookDto, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<UserSongbookDto, List<String?>, QQueryOperations> previewProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'preview');
    });
  }

  QueryBuilder<UserSongbookDto, int?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<UserSongbookDto, String?, QQueryOperations> thumbProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'thumb');
    });
  }

  QueryBuilder<UserSongbookDto, int?, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }

  QueryBuilder<UserSongbookDto, int?, QQueryOperations> totalSongsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalSongs');
    });
  }

  QueryBuilder<UserSongbookDto, ListTypeDto, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<UserSongbookDto, int?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<UserSongbookDto, String?, QQueryOperations> userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }
}

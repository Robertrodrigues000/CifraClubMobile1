// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persisted_purchase_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPersistedPurchaseDtoCollection on Isar {
  IsarCollection<PersistedPurchaseDto> get persistedPurchaseDtos => this.collection();
}

const PersistedPurchaseDtoSchema = CollectionSchema(
  name: r'PersistedPurchaseDto',
  id: -1724552724505496740,
  properties: {
    r'packageName': PropertySchema(
      id: 0,
      name: r'packageName',
      type: IsarType.string,
    ),
    r'pendingCompletePurchase': PropertySchema(
      id: 1,
      name: r'pendingCompletePurchase',
      type: IsarType.bool,
    ),
    r'productId': PropertySchema(
      id: 2,
      name: r'productId',
      type: IsarType.string,
    ),
    r'token': PropertySchema(
      id: 3,
      name: r'token',
      type: IsarType.string,
    ),
    r'transactionDate': PropertySchema(
      id: 4,
      name: r'transactionDate',
      type: IsarType.string,
    )
  },
  estimateSize: _persistedPurchaseDtoEstimateSize,
  serialize: _persistedPurchaseDtoSerialize,
  deserialize: _persistedPurchaseDtoDeserialize,
  deserializeProp: _persistedPurchaseDtoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _persistedPurchaseDtoGetId,
  getLinks: _persistedPurchaseDtoGetLinks,
  attach: _persistedPurchaseDtoAttach,
  version: '3.1.0+1',
);

int _persistedPurchaseDtoEstimateSize(
  PersistedPurchaseDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.packageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.productId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.token;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.transactionDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _persistedPurchaseDtoSerialize(
  PersistedPurchaseDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.packageName);
  writer.writeBool(offsets[1], object.pendingCompletePurchase);
  writer.writeString(offsets[2], object.productId);
  writer.writeString(offsets[3], object.token);
  writer.writeString(offsets[4], object.transactionDate);
}

PersistedPurchaseDto _persistedPurchaseDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PersistedPurchaseDto(
    packageName: reader.readStringOrNull(offsets[0]),
    pendingCompletePurchase: reader.readBoolOrNull(offsets[1]),
    productId: reader.readStringOrNull(offsets[2]),
    token: reader.readStringOrNull(offsets[3]),
    transactionDate: reader.readStringOrNull(offsets[4]),
  );
  return object;
}

P _persistedPurchaseDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readBoolOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _persistedPurchaseDtoGetId(PersistedPurchaseDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _persistedPurchaseDtoGetLinks(PersistedPurchaseDto object) {
  return [];
}

void _persistedPurchaseDtoAttach(IsarCollection<dynamic> col, Id id, PersistedPurchaseDto object) {}

extension PersistedPurchaseDtoQueryWhereSort on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QWhere> {
  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PersistedPurchaseDtoQueryWhere on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QWhereClause> {
  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterWhereClause> idBetween(
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

extension PersistedPurchaseDtoQueryFilter
    on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QFilterCondition> {
  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'packageName',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'packageName',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'packageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'packageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'packageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'packageName',
        value: '',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> packageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'packageName',
        value: '',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> pendingCompletePurchaseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pendingCompletePurchase',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> pendingCompletePurchaseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pendingCompletePurchase',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> pendingCompletePurchaseEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pendingCompletePurchase',
        value: value,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'productId',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'productId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'productId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'productId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> productIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'productId',
        value: '',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'token',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'token',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'token',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'token',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> tokenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'token',
        value: '',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'transactionDate',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'transactionDate',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'transactionDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'transactionDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'transactionDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'transactionDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'transactionDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'transactionDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'transactionDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'transactionDate',
        value: '',
      ));
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterFilterCondition> transactionDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'transactionDate',
        value: '',
      ));
    });
  }
}

extension PersistedPurchaseDtoQueryObject
    on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QFilterCondition> {}

extension PersistedPurchaseDtoQueryLinks
    on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QFilterCondition> {}

extension PersistedPurchaseDtoQuerySortBy on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QSortBy> {
  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByPendingCompletePurchase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingCompletePurchase', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByPendingCompletePurchaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingCompletePurchase', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByTransactionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> sortByTransactionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.desc);
    });
  }
}

extension PersistedPurchaseDtoQuerySortThenBy on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QSortThenBy> {
  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByPackageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByPackageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'packageName', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByPendingCompletePurchase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingCompletePurchase', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByPendingCompletePurchaseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pendingCompletePurchase', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByProductId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByProductIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'productId', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByToken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByTokenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'token', Sort.desc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByTransactionDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.asc);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QAfterSortBy> thenByTransactionDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'transactionDate', Sort.desc);
    });
  }
}

extension PersistedPurchaseDtoQueryWhereDistinct
    on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QDistinct> {
  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QDistinct> distinctByPackageName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'packageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QDistinct> distinctByPendingCompletePurchase() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pendingCompletePurchase');
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QDistinct> distinctByProductId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'productId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QDistinct> distinctByToken({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'token', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QDistinct> distinctByTransactionDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'transactionDate', caseSensitive: caseSensitive);
    });
  }
}

extension PersistedPurchaseDtoQueryProperty
    on QueryBuilder<PersistedPurchaseDto, PersistedPurchaseDto, QQueryProperty> {
  QueryBuilder<PersistedPurchaseDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PersistedPurchaseDto, String?, QQueryOperations> packageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'packageName');
    });
  }

  QueryBuilder<PersistedPurchaseDto, bool?, QQueryOperations> pendingCompletePurchaseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pendingCompletePurchase');
    });
  }

  QueryBuilder<PersistedPurchaseDto, String?, QQueryOperations> productIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'productId');
    });
  }

  QueryBuilder<PersistedPurchaseDto, String?, QQueryOperations> tokenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'token');
    });
  }

  QueryBuilder<PersistedPurchaseDto, String?, QQueryOperations> transactionDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'transactionDate');
    });
  }
}

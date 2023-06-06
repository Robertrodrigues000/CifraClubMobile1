// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_purchase_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ValidatePurchaseResponseDto _$ValidatePurchaseResponseDtoFromJson(Map<String, dynamic> json) =>
    ValidatePurchaseResponseDto(
      isValid: json['response'] as bool,
      responseCode: json['response_code'] as int?,
      isInGracePeriod: json['is_in_grace_period'] as bool,
      expirationDate: json['expirationDate'] as String?,
      purchaseDate: json['purchaseDate'] as String,
      app: json['app'] as String?,
      productID: json['productID'] as String?,
    );

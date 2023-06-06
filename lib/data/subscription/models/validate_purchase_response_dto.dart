// coverage:ignore-file
import 'package:cifraclub/domain/subscription/models/validate_purchase_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'validate_purchase_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class ValidatePurchaseResponseDto {
  @JsonKey(name: "response")
  final bool isValid;

  final String purchaseDate;

  @JsonKey(name: "is_in_grace_period")
  final bool isInGracePeriod;

  // Os campos responseCode, expirationDate, app e productID não vêm na resposta quando postamos uma compra vitalícia

  @JsonKey(name: "response_code")
  final int? responseCode;
  final String? expirationDate;
  final String? app;
  final String? productID;

  ValidatePurchaseResponseDto({
    required this.isValid,
    required this.responseCode,
    required this.isInGracePeriod,
    required this.expirationDate,
    required this.purchaseDate,
    required this.app,
    required this.productID,
  });

  factory ValidatePurchaseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ValidatePurchaseResponseDtoFromJson(json);

  ValidatePurchaseResponse toDomain() {
    return ValidatePurchaseResponse(
      isValid: isValid,
      responseCode: responseCode,
      isInGracePeriod: isInGracePeriod,
      expirationDate: expirationDate,
      purchaseDate: purchaseDate,
      app: app,
      productID: productID,
    );
  }
}

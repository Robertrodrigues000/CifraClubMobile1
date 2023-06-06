// coverage:ignore-file
import 'package:json_annotation/json_annotation.dart';

part 'validate_purchase_input_dto.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class ValidatePurchaseInputDto {
  @JsonKey(name: "id")
  final String? productId;

  @JsonKey(name: "type")
  final String? productType;

  final bool? sandbox;
  final String platform;
  final String? receipt;
  final String? token;
  final String? app;
  final String? confirmed;

  ValidatePurchaseInputDto.fromAndroid({
    required this.platform,
    required this.token,
    required this.app,
    required this.productId,
    required this.confirmed,
    required this.productType,
  })  : receipt = null,
        sandbox = null;

  ValidatePurchaseInputDto.fromiOS({
    required this.platform,
    required this.receipt,
    required this.sandbox,
  })  : token = null,
        app = null,
        productId = null,
        confirmed = null,
        productType = null;

  Map<String, dynamic> toJson() => _$ValidatePurchaseInputDtoToJson(this);
}

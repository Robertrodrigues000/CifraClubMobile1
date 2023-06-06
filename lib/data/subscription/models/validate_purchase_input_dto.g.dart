// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validate_purchase_input_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$ValidatePurchaseInputDtoToJson(ValidatePurchaseInputDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.productId);
  writeNotNull('type', instance.productType);
  writeNotNull('sandbox', instance.sandbox);
  val['platform'] = instance.platform;
  writeNotNull('receipt', instance.receipt);
  writeNotNull('token', instance.token);
  writeNotNull('app', instance.app);
  writeNotNull('confirmed', instance.confirmed);
  return val;
}

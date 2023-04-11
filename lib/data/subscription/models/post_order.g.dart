// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$PostOrderToJson(PostOrder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('expirationDate', instance.expirationDate);
  val['type'] = instance.type;
  val['token'] = instance.token;
  val['confirmed'] = instance.confirmed;
  writeNotNull('app', instance.app);
  writeNotNull('productId', instance.productId);
  writeNotNull('subType', instance.subType);
  writeNotNull('sandbox', instance.sandbox);
  return val;
}

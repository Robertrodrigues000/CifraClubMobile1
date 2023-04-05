// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) => OrderDto(
      id: json['id'] as String,
      userId: json['userId'] as int,
      status: json['status'] as int,
      orderStatus: json['orderStatus'] as String,
      paymentMethod: json['paymentMethod'] as String,
      productGroup: json['productGroup'] as String,
      sku: json['product'] as String,
      productType: json['productType'] as String,
      expirationDate: json['expirationDate'] as String,
      activationDate: json['activationDate'] as String,
      price: json['price'] as String,
      paymentClient: json['paymentClient'] as String,
    );

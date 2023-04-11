import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_order.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class PostOrder {
  final String? expirationDate;
  final String type;
  final String token;
  final bool confirmed; // booleano que permite mover a assinatura/compra de outro usuário caso já exista
  final String? app;
  final String? productId;
  final String? subType; // apenas android
  final bool? sandbox; // apenas ios

  const PostOrder({
    required this.expirationDate,
    required this.type,
    required this.token,
    required this.confirmed,
    required this.app,
    required this.productId,
    required this.subType,
    required this.sandbox,
  });

  const PostOrder.android({
    required this.productId,
    required this.confirmed,
    required this.token,
    required this.app,
    this.expirationDate,
  })  : type = 'google_play',
        subType = 'subs',
        sandbox = null;

  const PostOrder.ios({
    required this.sandbox,
    required this.confirmed,
    required this.token,
    this.expirationDate,
    this.productId,
  })  : type = 'apple',
        subType = null,
        app = null;

  Map<String, dynamic> toJson() => _$PostOrderToJson(this);

  static PostOrder? fromPurchase(
    PurchaseDetails purchaseData, {
    bool isSandbox = false,
    bool replaceCcidAccount = false,
  }) {
    if (purchaseData is GooglePlayPurchaseDetails) {
      return PostOrder.android(
        productId: purchaseData.productID,
        confirmed: replaceCcidAccount,
        token: purchaseData.billingClientPurchase.purchaseToken,
        app: purchaseData.billingClientPurchase.packageName,
      );
    } else if (purchaseData is AppStorePurchaseDetails) {
      return PostOrder.ios(
        productId: purchaseData.productID,
        confirmed: replaceCcidAccount,
        token: purchaseData.verificationData.localVerificationData,
        sandbox: isSandbox,
      );
    }
    return null;
  }
}

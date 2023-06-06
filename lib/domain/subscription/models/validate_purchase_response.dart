class ValidatePurchaseResponse {
  final bool isValid;
  final int? responseCode;
  final bool isInGracePeriod;
  final String? expirationDate;
  final String purchaseDate;
  final String? app;
  final String? productID;

  ValidatePurchaseResponse({
    required this.isValid,
    required this.responseCode,
    required this.isInGracePeriod,
    required this.expirationDate,
    required this.purchaseDate,
    required this.app,
    required this.productID,
  });
}

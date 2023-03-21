class PurchaseError {
  final String source;
  final String code;
  final String message;
  final dynamic details;

  PurchaseError({required this.source, required this.code, required this.message, this.details});
}

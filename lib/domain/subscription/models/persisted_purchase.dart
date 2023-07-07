class PersistedPurchase {
  final String? productId;
  final String? transactionDate;
  final bool? pendingCompletePurchase;
  final String? token;
  final String? packageName;

  PersistedPurchase({
    this.productId,
    this.transactionDate,
    this.pendingCompletePurchase,
    this.token,
    this.packageName,
  });
}

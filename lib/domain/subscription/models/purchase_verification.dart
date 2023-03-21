// coverage:ignore-file
class PurchaseVerification {
  final String localVerificationData;
  final String serverVerificationData;
  final String source;

  PurchaseVerification(
      {required this.localVerificationData, required this.serverVerificationData, required this.source});
}

class VerifyProStatus {
  bool call({required bool? remoteProStatus, required bool? storeProStatus, required currentProStatus}) {
    return (remoteProStatus ?? currentProStatus) || (storeProStatus ?? currentProStatus);
  }
}

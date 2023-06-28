import 'package:cifraclub/domain/subscription/use_cases/verify_pro_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var verifyProStatus = VerifyProStatus();

  test("When remote and store pro status are unknown, the current pro status should be preserved", () {
    expect(verifyProStatus(currentProStatus: true, remoteProStatus: null, storeProStatus: null), isTrue);
    expect(verifyProStatus(currentProStatus: false, remoteProStatus: null, storeProStatus: null), isFalse);
  });

  test("When either remote, store or both pro status are true, pro status should be true", () {
    // remoteProStatus true
    expect(verifyProStatus(currentProStatus: false, remoteProStatus: true, storeProStatus: null), isTrue);
    expect(verifyProStatus(currentProStatus: true, remoteProStatus: true, storeProStatus: null), isTrue);
    expect(verifyProStatus(currentProStatus: false, remoteProStatus: true, storeProStatus: false), isTrue);
    expect(verifyProStatus(currentProStatus: true, remoteProStatus: true, storeProStatus: false), isTrue);

    // storeProStatus true
    expect(verifyProStatus(currentProStatus: false, remoteProStatus: null, storeProStatus: true), isTrue);
    expect(verifyProStatus(currentProStatus: true, remoteProStatus: null, storeProStatus: true), isTrue);
    expect(verifyProStatus(currentProStatus: false, remoteProStatus: false, storeProStatus: true), isTrue);
    expect(verifyProStatus(currentProStatus: true, remoteProStatus: false, storeProStatus: true), isTrue);

    // both true
    expect(verifyProStatus(currentProStatus: false, remoteProStatus: true, storeProStatus: true), isTrue);
    expect(verifyProStatus(currentProStatus: true, remoteProStatus: true, storeProStatus: true), isTrue);
  });

  test("When both remote and store pro status are false, pro status should be false", () {
    expect(verifyProStatus(currentProStatus: false, remoteProStatus: false, storeProStatus: false), isFalse);
    expect(verifyProStatus(currentProStatus: true, remoteProStatus: false, storeProStatus: false), isFalse);
  });
}

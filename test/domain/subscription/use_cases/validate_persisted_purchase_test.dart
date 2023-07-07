import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/models/validate_purchase_response.dart';
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_persisted_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/post_persistent_purchase_order.dart';
import 'package:cifraclub/domain/subscription/use_cases/update_pro_status_with_purchase_result.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_persisted_purchase.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/subscription/models/persisted_purchase_mock.dart';

class _GetCredentialMock extends Mock implements GetCredential {}

class _PostOrderMock extends Mock implements PostPersistentPurchaseOrder {}

class _ValidatePurchaseRepositoryMock extends Mock implements ValidatePurchaseRepository {}

class _UpdateProStatusWithPurchaseResultMock extends Mock implements UpdateProStatusWithPurchaseResult {}

class _GetPersistedPurchaseMock extends Mock implements GetPersistedPurchase {}

void main() {
  setUpAll(() {
    registerFallbackValue(PurchaseResult.valid);
    registerFallbackValue(getFakePersistedPurchase());
  });

  var validatePurchaseRepository = _ValidatePurchaseRepositoryMock();
  var postOrder = _PostOrderMock();
  var getCredential = _GetCredentialMock();
  var updateProStatusWithPurchaseResult = _UpdateProStatusWithPurchaseResultMock();
  var getPersistedPurchase = _GetPersistedPurchaseMock();

  test("When there is not a persisted purchase, the use case should update pro status with PurchaseResult.invalid", () {
    clearInteractions(updateProStatusWithPurchaseResult);

    when(getPersistedPurchase).thenAnswer((_) => SynchronousFuture(null));
    when(() => updateProStatusWithPurchaseResult(any())).thenReturn(null);

    var validatePersistedPurchase = ValidatePersistedPurchase(
        getCredential, postOrder, validatePurchaseRepository, updateProStatusWithPurchaseResult, getPersistedPurchase);

    validatePersistedPurchase();

    var result = verify(() => updateProStatusWithPurchaseResult(captureAny())).captured.first! as PurchaseResult;

    expect(result, PurchaseResult.invalid);
  });

  group("when user is logged in", () {
    test(
        "When there is a persisted purchase, the use case should validate with PostOrder and update pro status with the response",
        () {
      for (var purchaseResult in PurchaseResult.values) {
        clearInteractions(updateProStatusWithPurchaseResult);

        when(getPersistedPurchase).thenAnswer((_) => SynchronousFuture(getFakePersistedPurchase()));
        when(getCredential).thenReturn(const UserCredential(isUserLoggedIn: true));
        when(() => postOrder(any())).thenAnswer((_) => SynchronousFuture(purchaseResult));

        when(() => updateProStatusWithPurchaseResult(any())).thenReturn(null);

        var validatePersistedPurchase = ValidatePersistedPurchase(getCredential, postOrder, validatePurchaseRepository,
            updateProStatusWithPurchaseResult, getPersistedPurchase);

        validatePersistedPurchase();

        var result = verify(() => updateProStatusWithPurchaseResult(captureAny())).captured.first! as PurchaseResult;

        expect(result, purchaseResult);
      }
    });
  });

  group("when user is not logged in", () {
    test(
        "When there is a valid persisted purchase, the use case should validate with validatePurchaseRepository and update pro status with the response",
        () {
      clearInteractions(updateProStatusWithPurchaseResult);

      when(getPersistedPurchase).thenAnswer((_) => SynchronousFuture(getFakePersistedPurchase()));
      when(getCredential).thenReturn(const UserCredential(isUserLoggedIn: false));

      when(
        () => validatePurchaseRepository.postValidatePersistedPurchase(purchase: any(named: "purchase")),
      ).thenAnswer((_) => SynchronousFuture(Ok(_getFakeResponse(true))));

      when(() => updateProStatusWithPurchaseResult(any())).thenReturn(null);

      var validatePersistedPurchase = ValidatePersistedPurchase(getCredential, postOrder, validatePurchaseRepository,
          updateProStatusWithPurchaseResult, getPersistedPurchase);

      validatePersistedPurchase();

      var result = verify(() => updateProStatusWithPurchaseResult(captureAny())).captured.first! as PurchaseResult;

      expect(result, PurchaseResult.valid);
    });
    test(
        "When there is a invalid persisted purchase, the use case should validate with validatePurchaseRepository and update pro status with the response",
        () {
      clearInteractions(updateProStatusWithPurchaseResult);

      when(getPersistedPurchase).thenAnswer((_) => SynchronousFuture(getFakePersistedPurchase()));
      when(getCredential).thenReturn(const UserCredential(isUserLoggedIn: false));

      when(
        () => validatePurchaseRepository.postValidatePersistedPurchase(purchase: any(named: "purchase")),
      ).thenAnswer((_) => SynchronousFuture(Ok(_getFakeResponse(false))));

      when(() => updateProStatusWithPurchaseResult(any())).thenReturn(null);

      var validatePersistedPurchase = ValidatePersistedPurchase(getCredential, postOrder, validatePurchaseRepository,
          updateProStatusWithPurchaseResult, getPersistedPurchase);

      validatePersistedPurchase();

      var result = verify(() => updateProStatusWithPurchaseResult(captureAny())).captured.first! as PurchaseResult;

      expect(result, PurchaseResult.invalid);
    });

    test(
        "When there is a persisted purchase and validatePurchaseRepository fails to validate it, the use case update pro status",
        () {
      clearInteractions(updateProStatusWithPurchaseResult);

      when(getPersistedPurchase).thenAnswer((_) => SynchronousFuture(getFakePersistedPurchase()));
      when(getCredential).thenReturn(const UserCredential(isUserLoggedIn: false));

      when(
        () => validatePurchaseRepository.postValidatePersistedPurchase(purchase: any(named: "purchase")),
      ).thenAnswer((_) => SynchronousFuture(Err(ServerError())));

      when(() => updateProStatusWithPurchaseResult(any())).thenReturn(null);

      var validatePersistedPurchase = ValidatePersistedPurchase(getCredential, postOrder, validatePurchaseRepository,
          updateProStatusWithPurchaseResult, getPersistedPurchase);

      validatePersistedPurchase();

      var result = verify(() => updateProStatusWithPurchaseResult(captureAny())).captured.first! as PurchaseResult;

      expect(result, PurchaseResult.unknown);
    });
  });
}

ValidatePurchaseResponse _getFakeResponse(bool isValid) {
  return ValidatePurchaseResponse(
      isValid: isValid,
      responseCode: 0,
      isInGracePeriod: false,
      expirationDate: "",
      purchaseDate: "",
      app: "",
      productID: "");
}

import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/models/validate_purchase_response.dart';
import 'package:cifraclub/domain/subscription/repository/validate_purchase_repository.dart';
import 'package:cifraclub/domain/subscription/use_cases/post_purchase_order.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart';
import 'package:cifraclub/domain/user/models/user_credential.dart';
import 'package:cifraclub/domain/user/use_cases/get_credential.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/subscription/models/purchase_mock.dart';

class _GetCredentialMock extends Mock implements GetCredential {}

class _PostPurchaseOrderMock extends Mock implements PostPurchaseOrder {}

class _ValidatePurchaseRepositoryMock extends Mock implements ValidatePurchaseRepository {}

void main() {
  registerFallbackValue(getFakePurchase());
  group("When user is logged in", () {
    var getCredential = _GetCredentialMock();
    var postPurchaseOrder = _PostPurchaseOrderMock();
    var validatePurchaseRepository = _ValidatePurchaseRepositoryMock();

    when(getCredential.call).thenAnswer((_) => const UserCredential(isUserLoggedIn: true));

    test('The purchase should be sent to postOrder', () async {
      var validatePurchase = ValidatePurchase(
        getCredential: getCredential,
        postOrder: postPurchaseOrder,
        validatePurchaseRepository: validatePurchaseRepository,
      );

      when(() => postPurchaseOrder.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.valid));

      expect(await validatePurchase(getFakePurchase()), PurchaseResult.valid);
      verify(() => postPurchaseOrder.call(any())).called(1);

      clearInteractions(postPurchaseOrder);

      when(() => postPurchaseOrder.call(any())).thenAnswer((_) => SynchronousFuture(PurchaseResult.invalid));

      expect(await validatePurchase(getFakePurchase()), PurchaseResult.invalid);
      verify(() => postPurchaseOrder.call(any())).called(1);
    });
  });

  group("When user is not logged in", () {
    var getCredential = _GetCredentialMock();
    var postPurchaseOrder = _PostPurchaseOrderMock();
    var validatePurchaseRepository = _ValidatePurchaseRepositoryMock();

    when(getCredential.call).thenAnswer((_) => const UserCredential(isUserLoggedIn: false));

    test('The purchase should be sent to patrocine validate and confirmed in the store', () async {
      var validatePurchase = ValidatePurchase(
          getCredential: getCredential,
          postOrder: postPurchaseOrder,
          validatePurchaseRepository: validatePurchaseRepository);

      when(() => validatePurchaseRepository.postValidatePurchase(purchase: any(named: "purchase")))
          .thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));

      expect(await validatePurchase(getFakePurchase()), PurchaseResult.unknown);
      verify(() => validatePurchaseRepository.postValidatePurchase(purchase: any(named: "purchase"))).called(1);

      clearInteractions(postPurchaseOrder);

      when(() => validatePurchaseRepository.postValidatePurchase(purchase: any(named: "purchase")))
          .thenAnswer((invocation) => SynchronousFuture(Ok(_getFakeResponse(false))));

      expect(await validatePurchase(getFakePurchase()), PurchaseResult.invalid);
      verify(() => validatePurchaseRepository.postValidatePurchase(purchase: any(named: "purchase"))).called(1);

      clearInteractions(postPurchaseOrder);

      when(() => validatePurchaseRepository.postValidatePurchase(purchase: any(named: "purchase")))
          .thenAnswer((invocation) => SynchronousFuture(Ok(_getFakeResponse(true))));

      expect(await validatePurchase(getFakePurchase()), PurchaseResult.valid);
      verify(() => validatePurchaseRepository.postValidatePurchase(purchase: any(named: "purchase"))).called(1);
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

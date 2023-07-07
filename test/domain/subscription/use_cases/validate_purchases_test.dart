import 'package:cifraclub/domain/subscription/models/purchase.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:cifraclub/domain/subscription/use_cases/complete_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/persist_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchase.dart';
import 'package:cifraclub/domain/subscription/use_cases/validate_purchases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/subscription/models/purchase_mock.dart';

class _ValidatePurchaseMock extends Mock implements ValidatePurchase {}

class _CompletePurchaseMock extends Mock implements CompletePurchase {}

class _PersistPurchaseMock extends Mock implements PersistPurchase {}

void main() {
  registerFallbackValue(getFakePurchase());

  var persistPurchase = _PersistPurchaseMock();
  when(() => persistPurchase.call(any())).thenAnswer((invocation) => SynchronousFuture(null));

  var completePurchase = _CompletePurchaseMock();
  when(() => completePurchase.call(any())).thenAnswer((invocation) => SynchronousFuture(null));

  var validatePurchase = _ValidatePurchaseMock();
  when(() => validatePurchase.call(any())).thenAnswer((invocation) {
    var productId = (invocation.positionalArguments.first as Purchase).productId;
    if (productId == "valid") {
      return SynchronousFuture(PurchaseResult.valid);
    }
    if (productId == "invalid") {
      return SynchronousFuture(PurchaseResult.invalid);
    }
    if (productId == "tokenAlreadyValidated") {
      return SynchronousFuture(PurchaseResult.tokenAlreadyValidated);
    }
    return SynchronousFuture(PurchaseResult.unknown);
  });

  test('When there is a valid purchase, the result should be valid', () async {
    clearInteractions(persistPurchase);
    var purchases = [
      getFakePurchase(productId: "tokenAlreadyValidated"),
      getFakePurchase(productId: "unknown"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "valid"),
      getFakePurchase(productId: "invalid"),
    ];

    var validatePurchases = ValidatePurchases(validatePurchase, completePurchase, persistPurchase);

    var result = await validatePurchases(purchases);

    expect(result, PurchaseResult.valid);
    verify(() => completePurchase.call(any())).called(1);
    var persistedPurchase = verify(() => persistPurchase.call(captureAny())).captured.last as Purchase;
    expect(persistedPurchase.productId, "valid");
    clearInteractions(completePurchase);
  });

  test('When there is a tokenAlreadyValidated purchase, the result should be tokenAlreadyValidated', () async {
    clearInteractions(persistPurchase);
    var purchases = [
      getFakePurchase(productId: "unknown"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "tokenAlreadyValidated"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "invalid"),
    ];

    var validatePurchases = ValidatePurchases(validatePurchase, completePurchase, persistPurchase);

    var result = await validatePurchases(purchases);

    expect(result, PurchaseResult.tokenAlreadyValidated);
    verifyNever(() => completePurchase.call(any()));
    var persistedPurchase = verify(() => persistPurchase.call(captureAny())).captured.last as Purchase;
    expect(persistedPurchase.productId, "tokenAlreadyValidated");
  });

  test('When there is a unknown purchase and no tokenAlreadyValidated or valid purchases, the result should be unknown',
      () async {
    clearInteractions(persistPurchase);
    var purchases = [
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "unknown"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "invalid"),
    ];

    var validatePurchases = ValidatePurchases(validatePurchase, completePurchase, persistPurchase);

    var result = await validatePurchases(purchases);

    expect(result, PurchaseResult.unknown);
    verifyNever(() => completePurchase.call(any()));
    verifyNever(() => persistPurchase.call(any()));
  });

  test('When all purchases are invalid, the result should be invalid', () async {
    clearInteractions(persistPurchase);
    var purchases = [
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "invalid"),
      getFakePurchase(productId: "invalid"),
    ];

    var validatePurchases = ValidatePurchases(validatePurchase, completePurchase, persistPurchase);

    var result = await validatePurchases(purchases);

    expect(result, PurchaseResult.invalid);
    verifyNever(() => completePurchase.call(any()));
    verifyNever(() => persistPurchase.call(any()));
  });
}

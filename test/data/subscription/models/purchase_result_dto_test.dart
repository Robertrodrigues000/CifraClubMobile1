import 'package:cifraclub/data/subscription/models/purchase_result_dto.dart';
import 'package:cifraclub/domain/subscription/models/purchase_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('purchase result dto conversion to domain', () {
    expect(PurchaseResultDto.invalidParams.toDomain(), PurchaseResult.invalid);
    expect(PurchaseResultDto.paymentError.toDomain(), PurchaseResult.invalid);
    expect(PurchaseResultDto.userNotLogged.toDomain(), PurchaseResult.invalid);
    expect(PurchaseResultDto.success.toDomain(), PurchaseResult.valid);
    expect(PurchaseResultDto.tokenAlreadyValidated.toDomain(), PurchaseResult.tokenAlreadyValidated);
    expect(PurchaseResultDto.unknown.toDomain(), PurchaseResult.unknown);
    expect(PurchaseResultDto.requestError.toDomain(), PurchaseResult.unknown);
    expect(PurchaseResultDto.serverError.toDomain(), PurchaseResult.unknown);
  });
}

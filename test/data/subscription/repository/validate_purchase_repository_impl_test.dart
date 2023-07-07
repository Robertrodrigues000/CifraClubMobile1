import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/models/validate_purchase_input_dto.dart';
import 'package:cifraclub/data/subscription/models/validate_purchase_response_dto.dart';
import 'package:cifraclub/data/subscription/repository/validate_purchase_repository_impl.dart';
import 'package:cifraclub/domain/device/operating_system/models/operating_system.dart';
import 'package:cifraclub/domain/device/operating_system/use_cases/get_operating_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/domain/subscription/models/persisted_purchase_mock.dart';
import '../../../shared_mocks/domain/subscription/models/purchase_mock.dart';

class _GetOperatingSystemMock extends Mock implements GetOperatingSystem {}

class _ValidatePurchaseDataSourceMock extends Mock implements ValidatePurchaseDataSource {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      ValidatePurchaseInputDto.fromiOS(platform: "ios", receipt: "receipt", sandbox: true),
    );
  });
  test('When postValidatePurchase is called, the data source method should be called.', () async {
    var getOperatingSystem = _GetOperatingSystemMock();
    when(getOperatingSystem.call).thenAnswer((_) => OperatingSystem.android);

    var validatePurchaseResponse = ValidatePurchaseResponseDto(
      isValid: true,
      responseCode: 0,
      isInGracePeriod: false,
      expirationDate: "expirationDate",
      purchaseDate: "purchaseDate",
      app: "app",
      productID: "productID",
    );

    var validatePurchaseDataSource = _ValidatePurchaseDataSourceMock();
    when(() => validatePurchaseDataSource.postValidatePurchase(any()))
        .thenAnswer((invocation) => SynchronousFuture(Ok(validatePurchaseResponse)));

    var repository = ValidatePurchaseRepositoryImpl(
      getOperatingSystem: getOperatingSystem,
      validatePurchaseDataSource: validatePurchaseDataSource,
    );

    var response = await repository.postValidatePurchase(purchase: getFakePurchase());

    var input = verify(() => validatePurchaseDataSource.postValidatePurchase(captureAny())).captured.first
        as ValidatePurchaseInputDto;

    expect(response.isSuccess, true);
    expect(input.platform, "android");

    // testing on iOS

    when(getOperatingSystem.call).thenAnswer((_) => OperatingSystem.ios);

    await repository.postValidatePurchase(purchase: getFakePurchase());

    input = verify(() => validatePurchaseDataSource.postValidatePurchase(captureAny())).captured.first
        as ValidatePurchaseInputDto;

    expect(response.isSuccess, true);
    expect(input.platform, "ios");

    // testing on other OS, should fallback to android

    for (var element in [
      OperatingSystem.windows,
      OperatingSystem.fuchsia,
      OperatingSystem.linux,
      OperatingSystem.macos,
      OperatingSystem.web,
      OperatingSystem.unknown,
    ]) {
      when(getOperatingSystem.call).thenAnswer((_) => element);

      await repository.postValidatePurchase(purchase: getFakePurchase());

      input = verify(() => validatePurchaseDataSource.postValidatePurchase(captureAny())).captured.first
          as ValidatePurchaseInputDto;

      expect(response.isSuccess, true);
      expect(input.platform, "android");
    }
  });

  test("When postValidatePersistedPurchase is called, the data source method should be called.", () async {
    var getOperatingSystem = _GetOperatingSystemMock();
    when(getOperatingSystem.call).thenAnswer((_) => OperatingSystem.android);

    var validatePurchaseResponse = ValidatePurchaseResponseDto(
      isValid: true,
      responseCode: 0,
      isInGracePeriod: false,
      expirationDate: "expirationDate",
      purchaseDate: "purchaseDate",
      app: "app",
      productID: "productID",
    );

    var validatePurchaseDataSource = _ValidatePurchaseDataSourceMock();
    when(() => validatePurchaseDataSource.postValidatePurchase(any()))
        .thenAnswer((invocation) => SynchronousFuture(Ok(validatePurchaseResponse)));

    var repository = ValidatePurchaseRepositoryImpl(
      getOperatingSystem: getOperatingSystem,
      validatePurchaseDataSource: validatePurchaseDataSource,
    );

    var response = await repository.postValidatePersistedPurchase(purchase: getFakePersistedPurchase());

    verify(() => validatePurchaseDataSource.postValidatePurchase(captureAny())).called(1);

    expect(response.isSuccess, true);
  });
}

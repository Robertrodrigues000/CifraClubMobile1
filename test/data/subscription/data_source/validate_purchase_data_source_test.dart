import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/subscription/data_source/validate_purchase_data_source.dart';
import 'package:cifraclub/data/subscription/models/validate_purchase_input_dto.dart';
import 'package:cifraclub/data/subscription/models/validate_purchase_response_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  test("When validating purchase from iOS", () async {
    final networkService = NetworkServiceMock();
    final dataSource = ValidatePurchaseDataSource(networkService: networkService);

    final mockResponse =
        await File("test/data/subscription/data_source/validate_purchase_json_response_ios.json").readAsString();
    await networkService.mock<ValidatePurchaseResponseDto>(response: mockResponse);

    final validatePurchaseInput = ValidatePurchaseInputDto.fromiOS(sandbox: true, platform: "ios", receipt: "receipt");

    final result = await dataSource.postValidatePurchase(validatePurchaseInput);

    final request =
        verify(() => networkService.execute<ValidatePurchaseResponseDto>(request: captureAny(named: "request")))
            .captured
            .first as NetworkRequest<ValidatePurchaseResponseDto>;

    expect(request.path, "/v3/patrocine/validate");
    expect(request.type, NetworkRequestType.post);

    expect(request.data, {'sandbox': true, 'platform': 'ios', 'receipt': 'receipt'});

    expect(result.isSuccess, isTrue);
    expect(result.get()!.app, "br.com.studiosol.CifraClub.debug");
    expect(result.get()!.expirationDate, "2023-05-24 09:28:46");
    expect(result.get()!.purchaseDate, "2021-05-26 17:10:10");
    expect(result.get()!.isInGracePeriod, false);
    expect(result.get()!.isValid, true);
    expect(result.get()!.productID, "cifra_club_pro_mensal");
    expect(result.get()!.responseCode, 0);
  });

  test("When validating purchase from Android", () async {
    final networkService = NetworkServiceMock();
    final dataSource = ValidatePurchaseDataSource(networkService: networkService);

    final mockResponse =
        await File("test/data/subscription/data_source/validate_purchase_json_response_android.json").readAsString();
    await networkService.mock<ValidatePurchaseResponseDto>(response: mockResponse);

    final validatePurchaseInput = ValidatePurchaseInputDto.fromAndroid(
        platform: "android",
        token: "token",
        app: "app",
        productId: "productId",
        confirmed: "false",
        productType: "subs");

    final result = await dataSource.postValidatePurchase(validatePurchaseInput);

    final request =
        verify(() => networkService.execute<ValidatePurchaseResponseDto>(request: captureAny(named: "request")))
            .captured
            .first as NetworkRequest<ValidatePurchaseResponseDto>;

    expect(request.path, "/v3/patrocine/validate");
    expect(request.type, NetworkRequestType.post);

    expect(
      request.data,
      {'id': 'productId', 'type': 'subs', 'platform': 'android', 'token': 'token', 'app': 'app', 'confirmed': 'false'},
    );

    expect(result.isSuccess, isTrue);
    expect(result.get()!.purchaseDate, "2021-05-26 17:10:10");
    expect(result.get()!.isInGracePeriod, false);
    expect(result.get()!.isValid, true);
  });

  test("When request fail", () async {
    final networkService = NetworkServiceMock();
    final dataSource = ValidatePurchaseDataSource(networkService: networkService);

    when(() => networkService.execute<ValidatePurchaseResponseDto>(request: captureAny(named: "request")))
        .thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));

    final validatePurchaseInput = ValidatePurchaseInputDto.fromiOS(sandbox: true, platform: "ios", receipt: "receipt");

    final result = await dataSource.postValidatePurchase(validatePurchaseInput);

    expect(result.isFailure, isTrue);
  });
}

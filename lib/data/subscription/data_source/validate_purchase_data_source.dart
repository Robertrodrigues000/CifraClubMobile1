import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/subscription/models/validate_purchase_input_dto.dart';
import 'package:cifraclub/data/subscription/models/validate_purchase_response_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class ValidatePurchaseDataSource {
  NetworkService networkService;
  ValidatePurchaseDataSource({
    required this.networkService,
  });

  Future<Result<ValidatePurchaseResponseDto, RequestError>> postValidatePurchase(
      ValidatePurchaseInputDto validatePurchaseInput) async {
    var request = NetworkRequest(
        type: NetworkRequestType.post,
        data: validatePurchaseInput.toJson(),
        path: "/v3/patrocine/validate",
        parser: (data) => ValidatePurchaseResponseDto.fromJson(data as Map<String, dynamic>));
    var validatePurchaseResponse = await networkService.execute(request: request);
    return validatePurchaseResponse;
  }
}

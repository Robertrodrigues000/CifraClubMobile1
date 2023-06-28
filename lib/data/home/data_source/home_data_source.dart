import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/home/models/home_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class HomeDataSource {
  final NetworkService _networkService;

  HomeDataSource(this._networkService);

  CancelableOperation<Result<HomeDto, RequestError>> getHomeInfo(String? genreUrl) {
    var request = NetworkRequest(
        type: NetworkRequestType.get,
        path: "/v3/home/${genreUrl ?? ""}",
        parser: (data) => HomeDto.fromJson(data as Map<String, dynamic>));
    return _networkService.cancelableExecute(request: request);
  }
}

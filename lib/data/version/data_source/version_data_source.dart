import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/version/models/version_data_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class VersionDataSource {
  final NetworkService _networkService;

  VersionDataSource(this._networkService);

  Future<Result<VersionDataDto, RequestError>> getVersionData(
    String artistDns,
    String songDns, [
    String? type,
    String? label,
  ]) async {
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/version/$artistDns/$songDns${type != null ? "/$type" : ""}${label != null ? "/$label" : ""}",
      parser: (data) {
        return VersionDataDto.fromJson(data);
      },
    );
    return _networkService.execute(request: request);
  }
}

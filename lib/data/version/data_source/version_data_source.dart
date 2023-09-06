import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/version/models/version/version_data_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class VersionDataSource {
  final NetworkService _networkService;

  VersionDataSource(this._networkService);

  Future<Result<VersionDataDto, RequestError>> getVersionData(
    String artistUrl,
    String songUrl, [
    String? instrumentUrl,
    String? versionUrl,
  ]) async {
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path:
          "/v3/version/$artistUrl/$songUrl${instrumentUrl != null ? "/$instrumentUrl" : ""}${versionUrl != null ? "/$versionUrl" : ""}",
      parser: (data) {
        return VersionDataDto.fromJson(data);
      },
    );
    return _networkService.execute(request: request);
  }

  Future<Result<VersionDataDto, RequestError>> getVersionDataByVersionId(
    int versionId,
    int apiType,
  ) async {
    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "/v3/cifra/$versionId/$apiType",
      parser: (data) {
        return VersionDataDto.fromJson(data);
      },
    );
    return _networkService.execute(request: request);
  }
}

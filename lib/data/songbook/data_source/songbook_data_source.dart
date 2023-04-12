import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class SongbookDataSource {
  final NetworkService _networkService;

  SongbookDataSource(this._networkService);

  Future<Result<List<SongbookDto>, RequestError>> getAll() {
    var request = NetworkRequest(
        type: NetworkRequestType.get,
        path: "https://master.cifraclub.com.br/api/v3/songbook/all",
        parser: (data) {
          return (data as List<dynamic>).map((e) => SongbookDto.fromJson(e as Map<String, dynamic>)).toList();
        });

    return _networkService.execute(request: request);
  }
}

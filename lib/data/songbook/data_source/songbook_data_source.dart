import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/songbook/models/delete_versions_input_dto.dart';
import 'package:cifraclub/data/songbook/models/new_songbook_response_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
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

  Future<Result<NewSongbookResponseDto, RequestError>> insertSongbook(SongbookInputDto songbookInputDto) {
    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: "/v3/songbook",
      data: songbookInputDto.toJson(),
      parser: (data) {
        return NewSongbookResponseDto.fromJson(data);
      },
    );
    return _networkService.execute(request: request);
  }

  Future<Result<void, RequestError>> deleteSongbook(int songbookId) {
    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: "/v3/songbook/$songbookId/delete",
      parser: (_) => null, // coverage:ignore-line
    );
    return _networkService.execute(request: request);
  }

  Future<Result<void, RequestError>> updateSongbookData(int songbookId, SongbookInputDto songbookInputDto) {
    var request = NetworkRequest(
      type: NetworkRequestType.put,
      path: "/v3/songbook/$songbookId",
      data: songbookInputDto.toJson(),
      parser: (_) => null, // coverage:ignore-line
    );
    return _networkService.execute(request: request);
  }

  Future<Result<void, RequestError>> deleteVersions(int songbookId, DeleteVersionsInputDto deleteVersionsInputDto) {
    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: "/v3/songbook/$songbookId/songs/delete",
      data: deleteVersionsInputDto.toJson(),
      parser: (_) => null, // coverage:ignore-line
    );
    return _networkService.execute(request: request);
  }
}

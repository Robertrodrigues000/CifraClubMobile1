import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/songbook/models/versions_ids_input_dto.dart';
import 'package:cifraclub/data/songbook/models/new_songbook_response_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_input_dto.dart';
import 'package:cifraclub/data/songbook/models/songbook_version_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
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

  Future<Result<NewSongbookResponseDto, RequestError>> addSongbook(SongbookInputDto songbookInputDto) {
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

  Future<Result<void, RequestError>> deleteVersions(int songbookId, VersionsIdsInputDto deleteVersionsInputDto) {
    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: "/v3/songbook/$songbookId/songs/delete",
      data: deleteVersionsInputDto.toJson(),
      parser: (_) => null, // coverage:ignore-line
    );
    return _networkService.execute(request: request);
  }

  Future<Result<void, RequestError>> sortVersions(
    int songbookId,
    VersionsIdsInputDto orderedVersionInput,
  ) {
    var request = NetworkRequest(
      type: NetworkRequestType.put,
      path: "/v3/songbook/$songbookId/sort",
      data: orderedVersionInput.toJson(),
      parser: (_) => null, // coverage:ignore-line
    );
    return _networkService.execute(request: request);
  }

  Future<Result<SongbookVersionDto?, RequestError>> addVersionToSongbook(
    int songbookId,
    SongbookVersionInputDto songbookSongInputDto,
  ) {
    var request = NetworkRequest(
      type: NetworkRequestType.post,
      path: _getRequestPath(songbookId),
      data: songbookSongInputDto.toJson(),
      parser: (data) {
        if (data is Map<String, dynamic>) {
          return SongbookVersionDto.fromJson(data);
        }
        return null;
      },
    );
    return _networkService.execute(request: request);
  }

  String _getRequestPath(int songbookId) {
    final listType = ListType.getListTypeById(songbookId);

    return switch (listType) {
      ListType.favorites => "/v3/user/favorite-song",
      ListType.canPlay => "/v3/user/${listType.label}-play",
      ListType.cantPlay => "/v3/user/${listType.label}-play",
      ListType.recents => "/v3/user/song-view",
      _ => "/v3/songbook/$songbookId/song",
    };
  }

  Future<Result<SongbookDto, RequestError>> getSongbookById({required int songbookId}) {
    var request = NetworkRequest(
        type: NetworkRequestType.get,
        path: "/v3/songbook/$songbookId",
        parser: (data) {
          return SongbookDto.fromJson(data);
        });

    return _networkService.execute(request: request);
  }
}

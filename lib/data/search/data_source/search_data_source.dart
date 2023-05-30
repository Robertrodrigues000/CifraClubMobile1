import 'dart:convert';
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/search/models/search_response_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class SearchDataSource {
  NetworkService networkService;

  SearchDataSource({
    required this.networkService,
  });

  Future<Result<SearchResponseDto, RequestError>> getAll({required String query}) async {
    var request = NetworkRequest(
        type: NetworkRequestType.get,
        path: "https://solr.sscdn.co/cc/c1/",
        queryParams: {"q": query},
        parser: (data) {
          return SearchResponseDto.fromJson(jsonDecode(data) as Map<String, dynamic>);
        });
    return networkService.execute(request: request);
  }

  CancelableOperation<Result<SearchResponseDto, RequestError>> getSongs({required String query}) {
    var request = NetworkRequest(
        type: NetworkRequestType.get,
        path: "https://solr.sscdn.co/cc/c2/",
        queryParams: {"q": query},
        parser: (data) {
          return SearchResponseDto.fromJson(jsonDecode(data) as Map<String, dynamic>);
        });
    return networkService.cancelableExecute(request: request);
  }
}

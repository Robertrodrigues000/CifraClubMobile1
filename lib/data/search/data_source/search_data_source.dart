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

  CancelableOperation<Result<SearchResponseDto, RequestError>> getAll({required String query, String? search}) {
    final queryParams = {'q': query};
    if (search != null) {
      queryParams['search'] = search;
    }
    var request = NetworkRequest(
        type: NetworkRequestType.get,
        path: "https://solr.sscdn.co/cc/c7/",
        queryParams: queryParams,
        parser: (data) {
          return SearchResponseDto.fromJson(jsonDecode(data) as Map<String, dynamic>);
        });
    return networkService.cancelableExecute(request: request);
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

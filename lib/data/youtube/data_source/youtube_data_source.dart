import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/youtube/models/search/youtube_search_items_dto.dart';
import 'package:cifraclub/data/youtube/models/video/youtube_video_items_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class YouTubeDataSource {
  final NetworkService _networkService;

  const YouTubeDataSource(this._networkService);

  static const String _youTubeKey = "AIzaSyBbzM-yYzmQsveZcksn8UswSCIPk5u_qas";
  static const String _baseUrl = "https://gapi.cifraclub.com.br/youtube";

  Future<Result<YouTubeSearchItemsDto, RequestError>> search(String query) async {
    final queryParams = {
      "part": "snippet",
      "maxResults": 10,
      "order": "relevance",
      "type": "video",
      "q": query,
      "key": _youTubeKey,
    };

    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "$_baseUrl/v3/search",
      queryParams: queryParams,
      parser: (data) {
        return YouTubeSearchItemsDto.fromJson(data);
      },
    );
    return _networkService.execute(request: request);
  }

  Future<Result<YouTubeVideoItemsDto, RequestError>> getVideos(List<String> videoIds) async {
    final queryParams = {
      "part": "statistics,contentDetails",
      "id": videoIds.join(','),
      "fields": "items",
      "key": _youTubeKey,
    };

    var request = NetworkRequest(
      type: NetworkRequestType.get,
      path: "$_baseUrl/v3/videos",
      queryParams: queryParams,
      parser: (data) {
        return YouTubeVideoItemsDto.fromJson(data);
      },
    );
    return _networkService.execute(request: request);
  }
}

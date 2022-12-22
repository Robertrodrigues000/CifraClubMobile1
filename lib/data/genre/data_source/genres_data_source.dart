// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/data/genre/models/all_genres_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class GenresDataSource {
  NetworkService networkService;
  GenresDataSource({
    required this.networkService,
  });

  Future<Result<AllGenresDto, RequestError>> getGenres() async {
    var request = NetworkRequest(type: NetworkRequestType.get, path: "/v3/genres", parser: (data) => AllGenresDto.fromJson(data as Map<String, dynamic>));
    var allGenres = await networkService.execute(request: request);
    return allGenres;
  }
}

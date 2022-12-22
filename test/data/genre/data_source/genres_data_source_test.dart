import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/genre/data_source/genres_data_source.dart';
import 'package:cifraclub/data/genre/models/all_genres_dto.dart';
import 'package:cifraclub/data/genre/models/genre_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(NetworkRequest(type: NetworkRequestType.get, path: "", parser: (p0) => const AllGenresDto(top: [], all: [])));
  });
  group("When getGenres() is called", () {
    test("Request successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/genre/data_source/genres_mock_json_response.json").readAsString();
      await networkService.mock<AllGenresDto>(response: mockResponse);

      final genresDataSource = GenresDataSource(networkService: networkService);
      final result = await genresDataSource.getGenres();

      final request = verify(() => networkService.execute<AllGenresDto>(request: captureAny(named: "request"))).captured.first as NetworkRequest<AllGenresDto>;

      expect(request.path, "/v3/genres");
      expect(request.type, NetworkRequestType.get);

      const expectedAllGenresDto = AllGenresDto(
        all: [GenreDto(name: "Alternativo", url: "alternativo"), GenreDto(name: "Axé", url: "axe")],
        top: [GenreDto(name: "Rock", url: "rock"), GenreDto(name: "Gospel/Religioso", url: "gospelreligioso")],
      );

      expect(result.isSuccess, true);
      expect(result.get()!, expectedAllGenresDto);
    });

    test("Request failed", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<AllGenresDto>(request: captureAny(named: "request"))).thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));

      final genresDataSource = GenresDataSource(networkService: networkService);
      final result = await genresDataSource.getGenres();
      final request = verify(() => networkService.execute<AllGenresDto>(request: captureAny(named: "request"))).captured.first as NetworkRequest<AllGenresDto>;

      expect(request.path, "/v3/genres");
      expect(request.type, NetworkRequestType.get);

      expect(result.isSuccess, false);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, null);
    });
  });
}

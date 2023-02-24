import 'dart:io';

import 'package:cifraclub/data/artist/data_source/artist_data_source.dart';
import 'package:cifraclub/data/artist/models/top_artists_dto.dart';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  group("When getTopArtists is called", () {
    test("When request is successful with params", () async {
      final queryParams = {
        'genre': 'mpb',
        'offset': 5,
        'limit': 3,
      };

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/top_artists_mock_json_response.json").readAsString();
      await networkService.mock<TopArtistsDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getTopArtists(
        genreUrl: queryParams['genre'] as String,
        limit: queryParams['limit'] as int,
        offset: queryParams['offset'] as int,
      );

      final request = verify(() => networkService.execute<TopArtistsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<TopArtistsDto>;

      expect(request.path, "/v3/top/artists");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, queryParams);

      expect(result.isSuccess, true);
      final topArtists = result.get()!;

      expect(topArtists.artists.length, 3);
      expect(topArtists.artists.first.id, 7507);
      expect(topArtists.artists.first.name, "Zé Ramalho");
      expect(topArtists.artists.first.url, "ze-ramalho");
      expect(topArtists.moreResults, true);
    });

    test("When request is successful without params", () async {
      final queryParams = {
        'limit': 10,
      };

      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/artist/data_source/top_artists_mock_json_response.json").readAsString();
      await networkService.mock<TopArtistsDto>(response: mockResponse);

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getTopArtists(
        limit: queryParams['limit'] as int,
        offset: 0,
      );

      final request = verify(() => networkService.execute<TopArtistsDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<TopArtistsDto>;

      expect(request.path, "/v3/top/artists");
      expect(request.type, NetworkRequestType.get);
      expect(request.queryParams, queryParams);

      expect(result.isSuccess, true);
      final topArtists = result.get()!;

      expect(topArtists.artists.length, 3);
      expect(topArtists.artists.first.id, 7507);
      expect(topArtists.artists.first.name, "Zé Ramalho");
      expect(topArtists.artists.first.url, "ze-ramalho");
      expect(topArtists.moreResults, true);
    });

    test("When request fails", () async {
      final networkService = NetworkServiceMock();
      when(() => networkService.execute<TopArtistsDto>(request: captureAny(named: "request"))).thenAnswer(
        (invocation) => SynchronousFuture(
          Err(ServerError(statusCode: 404)),
        ),
      );

      final artistDataSource = ArtistDataSource(networkService: networkService);
      final result = await artistDataSource.getTopArtists(
        limit: 10,
        offset: 0,
      );

      expect(result.isFailure, true);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, 404);
    });
  });
}

import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/search/data_source/search_data_source.dart';
import 'package:cifraclub/data/search/models/search_list_dto.dart';
import 'package:cifraclub/data/search/models/search_response_dto.dart';
import 'package:cifraclub/data/search/models/search_dto.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

import '../../../shared_mocks/data/clients/http/network_service_mock.dart';

void main() {
  group("When getAll() is called", () {
    test("Request successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/search/data_source/get_all_search_mock_json_reponse.json").readAsString();
      await networkService.mock<SearchResponseDto>(contentType: Headers.textPlainContentType, response: mockResponse);

      final searchDataSource = SearchDataSource(networkService: networkService);
      final result = await searchDataSource.getAll(
        query: "lifehouse",
      );

      final request = verify(() => networkService.execute<SearchResponseDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c1/");
      expect(request.queryParams, {"q": "lifehouse"});
      expect(request.type, NetworkRequestType.get);

      const expectedAllSearchDto = SearchResponseDto(
        response: SearchListDto(
          docs: [
            SearchDto(
                idSong: null,
                tipo: "1",
                txt: "Lifehouse",
                url: null,
                idArtist: 2843,
                art: "Lifehouse",
                dns: "lifehouse",
                img: "3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c-tb.jpg"),
            SearchDto(
                idSong: 27161,
                tipo: "2",
                txt: "You And Me",
                url: "you-and-me",
                idArtist: 2843,
                art: "Lifehouse",
                dns: "lifehouse",
                img: "3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c-tb.jpg")
          ],
        ),
      );

      expect(result.isSuccess, true);
      expect(result.get(), expectedAllSearchDto);
    });

    test("Request failed", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<SearchResponseDto>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));

      final genresDataSource = SearchDataSource(networkService: networkService);
      final result = await genresDataSource.getAll(query: "lifehouse");
      final request = verify(() => networkService.execute<SearchResponseDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c1/");
      expect(request.queryParams, {"q": "lifehouse"});
      expect(request.type, NetworkRequestType.get);

      expect(result.isFailure, isTrue);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, null);
    });
  });

  group("When getSongs is called", () {
    test("and request id succesful should return songs", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/search/data_source/get_songs_mock_json_response.json").readAsString();
      await networkService.mock<SearchResponseDto>(contentType: Headers.textPlainContentType, response: mockResponse);

      final searchDataSource = SearchDataSource(networkService: networkService);
      final result = await searchDataSource.getSongs(query: "ava");

      final request = verify(() => networkService.execute<SearchResponseDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c2/");
      expect(request.queryParams, {"q": "ava"});
      expect(request.type, NetworkRequestType.get);

      const expectedAllSearchDto = SearchResponseDto(
        response: SearchListDto(
          docs: [
            SearchDto(
                idSong: 437376, tipo: "2", txt: "Ava", url: "ava", idArtist: 174027, art: "FAMY", dns: "famy", img: ""),
            SearchDto(
                idSong: 244155,
                tipo: "2",
                txt: "Avante Eu Vou",
                url: "avante-eu-vou",
                idArtist: 24399,
                art: "Harpa Cristã",
                dns: "harpa-crista",
                img: "3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5-tb.jpg")
          ],
        ),
      );

      expect(result.isSuccess, true);
      expect(result.get(), expectedAllSearchDto);
    });

    test("and request fail should return request error", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.execute<SearchResponseDto>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => SynchronousFuture(Err(ServerError())));

      final genresDataSource = SearchDataSource(networkService: networkService);
      final result = await genresDataSource.getSongs(query: "ava");
      final request = verify(() => networkService.execute<SearchResponseDto>(request: captureAny(named: "request")))
          .captured
          .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c2/");
      expect(request.queryParams, {"q": "ava"});
      expect(request.type, NetworkRequestType.get);

      expect(result.isFailure, isTrue);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, null);
    });
  });
}

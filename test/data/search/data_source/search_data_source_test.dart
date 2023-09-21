import 'dart:io';

import 'package:async/async.dart';
import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/search/data_source/search_data_source.dart';
import 'package:cifraclub/data/search/models/search_result_dto.dart';
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
          await File("test/data/search/data_source/get_all_search_mock_json_response.json").readAsString();
      await networkService.mock<SearchResponseDto>(contentType: Headers.textPlainContentType, response: mockResponse);

      final searchDataSource = SearchDataSource(networkService: networkService);
      final result = await searchDataSource
          .getAll(
            query: "lifehouse",
          )
          .value;

      final request =
          verify(() => networkService.cancelableExecute<SearchResponseDto>(request: captureAny(named: "request")))
              .captured
              .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c7/");
      expect(request.queryParams, {"q": "lifehouse"});
      expect(request.type, NetworkRequestType.get);

      const expectedAllSearchDto = SearchResponseDto(
        response: SearchResultDto(
          docs: [
            SearchDto(
              songId: null,
              type: "1",
              txt: "Lifehouse",
              url: null,
              artistId: 2843,
              artist: "Lifehouse",
              artistUrl: "lifehouse",
              imgm: "https://akamai.sscdn.co/letras/250x250/fotos/3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c.jpg",
              albumUrl: null,
              songbookId: null,
              userId: null,
              songbookName: null,
              userName: null,
              totalSongs: null,
              imgsm: null,
              isVerified: null,
            ),
            SearchDto(
              songId: 27161,
              type: "2",
              txt: "You And Me",
              url: "you-and-me",
              artistId: 2843,
              artist: "Lifehouse",
              artistUrl: "lifehouse",
              imgm: "https://akamai.sscdn.co/letras/250x250/fotos/3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c.jpg",
              albumUrl: null,
              songbookId: null,
              userId: null,
              songbookName: null,
              userName: null,
              totalSongs: null,
              imgsm: null,
              isVerified: false,
            )
          ],
        ),
      );

      expect(result.isSuccess, true);
      expect(result.get(), expectedAllSearchDto);
    });
    test("Has search and request is successful", () async {
      final networkService = NetworkServiceMock();
      final mockResponse =
          await File("test/data/search/data_source/get_all_search_with_filter_mock_json_response.json").readAsString();
      await networkService.mock<SearchResponseDto>(contentType: Headers.textPlainContentType, response: mockResponse);

      final searchDataSource = SearchDataSource(networkService: networkService);
      final result = await searchDataSource.getAll(query: "lifehouse", search: "1").value;

      final request =
          verify(() => networkService.cancelableExecute<SearchResponseDto>(request: captureAny(named: "request")))
              .captured
              .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c7/");
      expect(request.queryParams, {"q": "lifehouse", "search": "1"});
      expect(request.type, NetworkRequestType.get);

      const expectedFilteredSearchDto = SearchResponseDto(
        response: SearchResultDto(
          docs: [
            SearchDto(
              songId: null,
              type: "1",
              txt: "Lifehouse",
              url: null,
              artistId: 2843,
              artist: "Lifehouse",
              artistUrl: "lifehouse",
              imgm: "https://akamai.sscdn.co/letras/250x250/fotos/3/7/f/2/37f26a39f944f2c63455e1e7aca58c6c.jpg",
              albumUrl: null,
              songbookId: null,
              userId: null,
              songbookName: null,
              userName: null,
              totalSongs: null,
              imgsm: null,
              isVerified: null,
            ),
          ],
        ),
      );

      expect(result.isSuccess, true);
      expect(result.get(), expectedFilteredSearchDto);
    });
    test("Request failed", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.cancelableExecute<SearchResponseDto>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => CancelableOperation.fromFuture(SynchronousFuture(Err(ServerError()))));

      final searchDataSource = SearchDataSource(networkService: networkService);
      final result = await searchDataSource.getAll(query: "lifehouse").value;
      final request =
          verify(() => networkService.cancelableExecute<SearchResponseDto>(request: captureAny(named: "request")))
              .captured
              .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c7/");
      expect(request.queryParams, {"q": "lifehouse"});
      expect(request.type, NetworkRequestType.get);

      expect(result.isFailure, isTrue);
      expect(result.getError().runtimeType, ServerError);
      expect((result.getError() as ServerError).statusCode, null);
    });
  });

  group("When getSongs is called", () {
    test("and request id successful should return songs", () async {
      final networkService = NetworkServiceMock();
      final mockResponse = await File("test/data/search/data_source/get_songs_mock_json_response.json").readAsString();
      await networkService.mock<SearchResponseDto>(contentType: Headers.textPlainContentType, response: mockResponse);

      final searchDataSource = SearchDataSource(networkService: networkService);
      final result = await searchDataSource.getSongs(query: "ava").value;

      final request =
          verify(() => networkService.cancelableExecute<SearchResponseDto>(request: captureAny(named: "request")))
              .captured
              .first as NetworkRequest<SearchResponseDto>;

      expect(request.path, "https://solr.sscdn.co/cc/c2/");
      expect(request.queryParams, {"q": "ava"});
      expect(request.type, NetworkRequestType.get);

      const expectedAllSearchDto = SearchResponseDto(
        response: SearchResultDto(
          docs: [
            SearchDto(
              songId: 437376,
              type: "2",
              txt: "Ava",
              url: "ava",
              artistId: 174027,
              artist: "FAMY",
              artistUrl: "famy",
              imgm: "",
              albumUrl: null,
              songbookId: null,
              userId: null,
              songbookName: null,
              userName: null,
              totalSongs: null,
              imgsm: null,
              isVerified: false,
            ),
            SearchDto(
              songId: 244155,
              type: "2",
              txt: "Avante Eu Vou",
              url: "avante-eu-vou",
              artistId: 24399,
              artist: "Harpa Cristã",
              artistUrl: "harpa-crista",
              imgm: "https://akamai.sscdn.co/letras/250x250/fotos/3/0/8/3/3083b1621a661eee9c2eb4ef9d03daa5.jpg",
              albumUrl: null,
              songbookId: null,
              userId: null,
              songbookName: null,
              userName: null,
              totalSongs: null,
              imgsm: null,
              isVerified: false,
            )
          ],
        ),
      );

      expect(result.isSuccess, true);
      expect(result.get(), expectedAllSearchDto);
    });

    test("and request fail should return request error", () async {
      final networkService = NetworkServiceMock();

      when(() => networkService.cancelableExecute<SearchResponseDto>(request: captureAny(named: "request")))
          .thenAnswer((invocation) => CancelableOperation.fromFuture(SynchronousFuture(Err(ServerError()))));

      final searchDataSource = SearchDataSource(networkService: networkService);
      final result = await searchDataSource.getSongs(query: "ava").value;
      final request =
          verify(() => networkService.cancelableExecute<SearchResponseDto>(request: captureAny(named: "request")))
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

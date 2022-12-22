import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class _DioMock extends Mock implements Dio {
  @override
  BaseOptions options = BaseOptions();
}

class _TestNetworkService extends NetworkService {
  _TestNetworkService({required Dio dio})
      : super(
          dioClient: dio..options.baseUrl = "https://test.test.com.br",
        );
}

class _CancelTokenMock extends Mock implements CancelToken {}

class _MapModel {
  String value1;
  int value2;

  _MapModel({required this.value1, required this.value2});

  factory _MapModel.fromJson(Map<String, dynamic> json) => _MapModel(value1: json["value1"], value2: json["value2"]);
}

When<Future<Response<dynamic>>> _whenDioRequest(Dio dio) {
  reset(dio);
  return when(
    () => dio.request<dynamic>(
      any(),
      cancelToken: any(named: "cancelToken"),
      data: any(named: "data"),
      onReceiveProgress: any(named: "onReceiveProgress"),
      onSendProgress: any(named: "onSendProgress"),
      options: any(named: "options"),
      queryParameters: any(named: "queryParameters"),
    ),
  );
}

Future<Result<T, RequestError>> _executeRequest<T>(_TestNetworkService networkService, {required T Function(dynamic) parser}) {
  return networkService.execute(
    request: NetworkRequest(
      type: NetworkRequestType.get,
      path: "v3/test",
      parser: parser,
    ),
  );
}

void _verifyDioRequest(Dio dio) {
  verify(() => dio.request<dynamic>(
        "v3/test",
        cancelToken: any(named: "cancelToken"),
        data: any(named: "data"),
        onReceiveProgress: any(named: "onReceiveProgress"),
        onSendProgress: any(named: "onSendProgress"),
        options: any(named: "options"),
        queryParameters: any(named: "queryParameters"),
      )).called(1);
}

void main() {
  group("When request() is invoked", () {
    var dio = _DioMock();
    group("when request is successful", () {
      test("Receiving json with object", () async {
        Map<String, dynamic> okResponse = {"value1": "ok", "value2": 42};
        _whenDioRequest(dio).thenAnswer((_) => SynchronousFuture(Response(data: okResponse, requestOptions: RequestOptions(path: ''))));

        var networkService = _TestNetworkService(dio: dio);
        var response = await _executeRequest(
          networkService,
          parser: (data) => _MapModel.fromJson(data as Map<String, dynamic>),
        );

        expect(response.isSuccess, true);
        expect(response.get()!.value1, "ok");
        expect(response.get()!.value2, 42);
        _verifyDioRequest(dio);
      });

      test("Receiving json with array", () async {
        List<Map<String, dynamic>> okResponse = [
          {"value1": "ok1", "value2": 42},
          {"value1": "ok2", "value2": 666}
        ];
        _whenDioRequest(dio).thenAnswer((_) => SynchronousFuture(Response(data: okResponse, requestOptions: RequestOptions(path: ''))));

        var networkService = _TestNetworkService(dio: dio);
        var response = await _executeRequest(
          networkService,
          parser: (data) => (data as List<Map<String, dynamic>>).map(_MapModel.fromJson).toList(),
        );
        expect(response.isSuccess, true);
        expect(response.get()!.length, 2);
        expect(response.get()![0].value1, "ok1");
        expect(response.get()![0].value2, 42);
        expect(response.get()![1].value1, "ok2");
        expect(response.get()![1].value2, 666);
        _verifyDioRequest(dio);
      });

      test("Receiving json with array when object was expected", () async {
        List<Map<String, dynamic>> okResponse = [
          {"value1": "ok1", "value2": 42},
          {"value1": "ok2", "value2": 666}
        ];
        _whenDioRequest(dio).thenAnswer((_) => SynchronousFuture(Response(data: okResponse, requestOptions: RequestOptions(path: ''))));

        var networkService = _TestNetworkService(dio: dio);
        var response = await _executeRequest(
          networkService,
          parser: (data) => _MapModel.fromJson(data as Map<String, dynamic>),
        );
        expect(response.isSuccess, false);
        expect(response.getError(), isA<ServerError>());
        expect((response.getError() as ServerError).statusCode, null);
        _verifyDioRequest(dio);
      });
    });

    group("when request is cancelled", () {
      test("Throw Request cancelled error", () async {
        var cancelToken = _CancelTokenMock();
        var dioError = DioError(requestOptions: RequestOptions(path: "v3/test"));
        dioError.requestOptions.cancelToken = cancelToken;
        when(() => cancelToken.isCancelled).thenAnswer((invocation) => true);
        _whenDioRequest(dio).thenThrow(dioError);

        var networkService = _TestNetworkService(dio: dio);
        var response = await _executeRequest(
          networkService,
          parser: (data) => data,
        );
        expect(response.isSuccess, false);
        expect(response.getError(), isA<RequestCancelled>());
        _verifyDioRequest(dio);
      });
    });

    group("when request returns dioError", () {
      test("Throw server error", () async {
        var cancelToken = _CancelTokenMock();
        var requestOptions = RequestOptions(path: "v3/test");
        var dioError = DioError(requestOptions: requestOptions);
        dioError.requestOptions.cancelToken = cancelToken;
        dioError.response = Response(requestOptions: requestOptions, statusCode: 404);
        when(() => cancelToken.isCancelled).thenAnswer((invocation) => false);
        _whenDioRequest(dio).thenThrow(dioError);

        var networkService = _TestNetworkService(dio: dio);
        var response = await _executeRequest(
          networkService,
          parser: (data) => data,
        );
        expect(response.isSuccess, false);
        expect(response.getError(), isA<ServerError>());
        expect((response.getError() as ServerError).statusCode, 404);
        _verifyDioRequest(dio);
      });
    });

    group("when no internet connection is available", () {
      test("Throw server error", () async {
        var cancelToken = _CancelTokenMock();
        var requestOptions = RequestOptions(path: "v3/test");
        var dioError = DioError(requestOptions: requestOptions);
        dioError.requestOptions.cancelToken = cancelToken;
        dioError.response = Response(requestOptions: requestOptions, statusCode: 404);
        dioError.error = const SocketException("No internet message");
        when(() => cancelToken.isCancelled).thenAnswer((invocation) => false);
        _whenDioRequest(dio).thenThrow(dioError);

        var networkService = _TestNetworkService(dio: dio);
        var response = await _executeRequest(
          networkService,
          parser: (data) => data,
        );
        expect(response.isSuccess, false);
        expect(response.getError(), isA<ConnectionError>());
        _verifyDioRequest(dio);
      });
    });

    group("when request returns generic error", () {
      test("Throw server error", () async {
        var error = "generic error";
        _whenDioRequest(dio).thenThrow(error);

        var networkService = _TestNetworkService(dio: dio);
        var response = await _executeRequest(
          networkService,
          parser: (data) => data,
        );
        expect(response.isSuccess, false);
        expect(response.getError(), isA<ServerError>());
        expect((response.getError() as ServerError).statusCode, null);
        _verifyDioRequest(dio);
      });
    });
  });
}

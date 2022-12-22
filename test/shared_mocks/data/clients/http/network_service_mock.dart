import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/data/clients/http/network_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mocktail/mocktail.dart';
import 'package:typed_result/typed_result.dart';

class NetworkServiceMock extends Mock implements NetworkService {
  Future<void> mock<T>({required String response}) async {
    var options = RequestOptions(path: '', responseType: ResponseType.json);
    var jsonResponse = ResponseBody.fromString(response, 200, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType]
    });

    var transformed = await DefaultTransformer().transformResponse(options, jsonResponse) as dynamic;

    when(() => execute<T>(request: captureAny(named: "request"))).thenAnswer((invocation) => SynchronousFuture(
          Ok((invocation.namedArguments[const Symbol("request")] as NetworkRequest<T>).parser(transformed)),
        ));
  }
}

import 'dart:io';

import 'package:cifraclub/data/clients/http/network_request.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:dio/dio.dart';
import 'package:typed_result/typed_result.dart';

abstract class NetworkService {
  NetworkService({required dioClient}) : _dio = dioClient;

  final Dio _dio;

  Future<Result<T, RequestError>> execute<T>({required NetworkRequest<T> request}) async {
    try {
      final response = await _dio.request(
        request.path,
        data: request.data ?? {},
        queryParameters: request.queryParams,
        options: Options(
          method: request.type.name,
          headers: request.headers,
        ),
      );
      return Ok(request.parser(response.data));
    } on DioError catch (error) {
      if (error.requestOptions.cancelToken?.isCancelled ?? false) {
        return Err(RequestCancelled());
      }
      if (error.error is SocketException) {
        return Err(ConnectionError());
      }
      return Err(ServerError(statusCode: error.response?.statusCode));
    } catch (error) {
      // Todo: logar erro ao crashlytics
      return Err(ServerError());
    }
  }
}

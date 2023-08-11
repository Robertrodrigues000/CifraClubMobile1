sealed class RequestError {}

class ServerError implements RequestError {
  final int? statusCode;

  ServerError({this.statusCode});
}

class ConnectionError implements RequestError {}

class RequestCancelled implements RequestError {}

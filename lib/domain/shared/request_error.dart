abstract class RequestError {}

class ServerError extends RequestError {
  final int? statusCode;

  ServerError({this.statusCode});
}

class ConnectionError extends RequestError {}

class RequestCancelled extends RequestError {}

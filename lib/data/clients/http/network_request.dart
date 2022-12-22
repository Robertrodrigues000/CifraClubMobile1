enum NetworkRequestType { get, post, put, delete }

class NetworkRequest<T> {
  const NetworkRequest({
    required this.type,
    required this.path,
    required this.parser,
    this.data,
    this.queryParams,
    this.headers,
  });

  final NetworkRequestType type;
  final String path;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? queryParams;
  final Map<String, String>? headers;
  final T Function(dynamic) parser;
}

enum RequestResultState {
  serverError,
  connectionError,
}

typedef EmptyRequestResult = RequestResult<void>;

abstract class RequestResult<T> {
  const RequestResult();

  R when<R>({
    required R Function(T data) success,
    required R Function(RequestResultState requestResultState, dynamic error) error,
  }) {
    if (this is RequestResultLoaded) {
      return success.call((this as RequestResultLoaded).data);
    }
    if (this is RequestResultError) {
      return error.call((this as RequestResultError).state, (this as RequestResultError).error);
    }
    throw Exception("Unhandled RequestResultState type: $runtimeType");
  }

  RequestResult<B> transform<B>(B Function(T data) transform) {
    if (this is RequestResultLoaded) {
      return RequestResultLoaded<B>(data: transform((this as RequestResultLoaded).data));
    } else {
      return RequestResultError<B>(
        state: (this as RequestResultError).state,
        error: (this as RequestResultError).error,
      );
    }
  }
}

class RequestResultLoaded<T> extends RequestResult<T> {
  final T data;

  const RequestResultLoaded({required this.data});

  static EmptyRequestResult empty() => const RequestResultLoaded<void>(data: null);
}

class RequestResultError<T> extends RequestResult<T> {
  final RequestResultState state;
  final dynamic error;

  const RequestResultError({required this.state, this.error});
}

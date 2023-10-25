import 'package:cifraclub/domain/shared/request_error.dart';

sealed class SongbookError {}

class SongbookRequestError implements SongbookError {
  final RequestError requestError;

  SongbookRequestError(this.requestError);
}

class SongbookRepeatedSongError implements SongbookError {}

class SongbookVersionsLimitReachedError implements SongbookError {
  final int versionsLimit;

  SongbookVersionsLimitReachedError(this.versionsLimit);
}

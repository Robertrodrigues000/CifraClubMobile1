import 'package:cifraclub/domain/shared/request_error.dart';

abstract class SongbookResult {}

class OnVersionDeleted extends SongbookResult {}

class OnVersionDeletedFailed extends SongbookResult {
  final RequestError? error;

  OnVersionDeletedFailed({this.error});
}

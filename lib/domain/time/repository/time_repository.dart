import 'package:cifraclub/domain/shared/request_result.dart';

abstract class TimeRepository {
  Future<RequestResult<DateTime>> getCurrentTime();
}

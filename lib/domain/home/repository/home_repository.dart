import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

abstract class HomeRepository {
  CancelableOperation<Result<HomeInfo, RequestError>> getHomeInfos(String? genreUrl);
}

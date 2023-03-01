// coverage:ignore-file
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:cifraclub/domain/home/repository/home_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetHomeInfo {
  final HomeRepository _homeRepository;
  GetHomeInfo(this._homeRepository);

  Future<Result<HomeInfo, RequestError>> call([String? genreUrl]) {
    return _homeRepository.getHomeInfos(genreUrl);
  }
}

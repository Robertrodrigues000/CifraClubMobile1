import 'package:async/async.dart' hide Result;
import 'package:cifraclub/data/home/data_source/home_data_source.dart';
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:cifraclub/domain/home/repository/home_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource _homeDataSource;
  HomeRepositoryImpl(this._homeDataSource);

  @override
  CancelableOperation<Result<HomeInfo, RequestError>> getHomeInfo(String? genreUrl) {
    return _homeDataSource.getHomeInfo(genreUrl).then((result) => result.map((homeDto) => homeDto.toDomain()));
  }
}

import 'package:cifraclub/data/home/data_souce/home_data_source.dart';
import 'package:cifraclub/domain/home/models/home_info.dart';
import 'package:cifraclub/domain/home/repository/home_repository.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:typed_result/typed_result.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource _homeDataSource;
  HomeRepositoryImpl(this._homeDataSource);

  @override
  Future<Result<HomeInfo, RequestError>> getHomeInfos(String? genreUrl) async {
    return (await _homeDataSource.getHomeInfos(genreUrl)).map((value) => value.toDomain());
  }
}

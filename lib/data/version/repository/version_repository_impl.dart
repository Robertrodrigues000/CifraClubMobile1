import 'package:cifraclub/data/version/data_source/version_data_source.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/repository/version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@Injectable(as: VersionRepository)
class VersionRepositoryImpl extends VersionRepository {
  final VersionDataSource _dataSource;

  VersionRepositoryImpl(this._dataSource);

  @override
  Future<Result<VersionData, RequestError>> getVersionData({
    required String artistUrl,
    required String songUrl,
    String? instrumentUrl,
    String? versionUrl,
  }) async {
    return (await _dataSource.getVersionData(artistUrl, songUrl, instrumentUrl, versionUrl))
        .map((value) => value.toDomain());
  }

  @override
  Future<Result<VersionData, RequestError>> getVersionDataByVersionId({
    required int versionId,
    required int apiType,
  }) async {
    return (await _dataSource.getVersionDataByVersionId(versionId, apiType)).map((value) => value.toDomain());
  }
}

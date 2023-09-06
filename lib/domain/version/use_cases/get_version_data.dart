// coverage:ignore-file
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:cifraclub/domain/version/repository/version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetVersionData {
  final VersionRepository _versionRepository;

  GetVersionData(this._versionRepository);

  Future<Result<VersionData, RequestError>> call({
    required String artistUrl,
    required String songUrl,
    String? instrumentUrl,
    String? versionUrl,
  }) {
    return _versionRepository.getVersionData(
      artistUrl: artistUrl,
      songUrl: songUrl,
      instrumentUrl: instrumentUrl,
      versionUrl: versionUrl,
    );
  }
}

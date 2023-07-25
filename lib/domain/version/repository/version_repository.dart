import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/version_data.dart';
import 'package:typed_result/typed_result.dart';

abstract class VersionRepository {
  Future<Result<VersionData, RequestError>> getVersionData({
    required String artistDns,
    required String songDns,
    String? type,
    String? label,
  });
}

import 'package:cifraclub/domain/remote_config/use_cases/get_versions_limit_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetVersionsLimit {
  final GetVersionsLimitConstants _getVersionsLimitConstants;
  GetVersionsLimit(this._getVersionsLimitConstants);

  int call(bool isPro) {
    final versionsLimitConstants = _getVersionsLimitConstants();
    return isPro ? versionsLimitConstants.maxVersionsForPro : versionsLimitConstants.maxVersionsForFree;
  }
}

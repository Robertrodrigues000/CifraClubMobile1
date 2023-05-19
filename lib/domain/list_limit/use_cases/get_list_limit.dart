import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetListLimit {
  final GetListLimitConstants _getListLimitConstants;
  GetListLimit(this._getListLimitConstants);

  int call(bool isPro) {
    final listLimitConstants = _getListLimitConstants();
    return isPro ? listLimitConstants.maxListsForPro : listLimitConstants.maxListsForFree;
  }
}

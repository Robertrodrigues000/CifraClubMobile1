// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/limit_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTabsLimit {
  final ListLimitConstants _listLimitConstants;
  GetTabsLimit(this._listLimitConstants);

  int call(bool isPro) {
    return isPro ? _listLimitConstants.maxTabsForPro : _listLimitConstants.maxTabsForFree;
  }
}

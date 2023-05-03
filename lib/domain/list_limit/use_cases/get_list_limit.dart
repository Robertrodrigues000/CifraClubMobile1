// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/limit_constants.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetListLimit {
  final ListLimitConstants _listLimitConstants;
  GetListLimit(this._listLimitConstants);

  int call(bool isPro) {
    return isPro ? _listLimitConstants.maxListsForPro : _listLimitConstants.maxListsForFree;
  }
}

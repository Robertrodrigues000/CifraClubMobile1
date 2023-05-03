// coverage:ignore-file
import 'package:cifraclub/domain/list_limit/models/limit_constants.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ListLimitModule {
  ListLimitConstants getListLimitConstants() => ListLimitConstants(
        maxListsForFree: 10,
        maxListsForPro: 1000,
        maxTabsForFree: 100,
        maxTabsForPro: 1000,
        listWarningCountThreshold: 2,
        tabsWarningCountThreshold: 10,
      );
}

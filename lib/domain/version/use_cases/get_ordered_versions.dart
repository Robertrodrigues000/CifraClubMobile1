import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetOrderedVersions {
  List<Version> call(ListOrderType selectedOrderCapsule, List<Version> versions, ListType listType) {
    switch (selectedOrderCapsule) {
      case ListOrderType.alphabeticOrder:
        return versions..sortBy((element) => element.name);
      case ListOrderType.custom:
        return versions..sort((a, b) => a.order.compareTo(b.order));
      case ListOrderType.oldest:
        return switch (listType) {
          ListType.recents => versions..sort((a, b) => _compareDate(a.lastUpdate, b.lastUpdate)),
          _ => versions..sort((a, b) => _compareId(a.remoteDatabaseId, b.remoteDatabaseId))
        };
      case ListOrderType.recent:
        return switch (listType) {
          ListType.recents => versions..sort((a, b) => _compareDate(b.lastUpdate, a.lastUpdate)),
          _ => versions..sort((a, b) => _compareId(b.remoteDatabaseId, a.remoteDatabaseId))
        };
    }
  }

  int _compareId(int? a, int? b) {
    return (a ?? 0).compareTo(b ?? 0);
  }

  int _compareDate(DateTime? a, DateTime? b) {
    return (a ?? DateTime.fromMillisecondsSinceEpoch(0)).compareTo(b ?? DateTime.fromMillisecondsSinceEpoch(0));
  }
}

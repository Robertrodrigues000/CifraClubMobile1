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
        return versions..shuffle(); // coverage:ignore-line
      case ListOrderType.oldest:
        return switch (listType) {
          ListType.recents => versions..sort((a, b) => _compareId(a.localDatabaseID, b.localDatabaseID)),
          _ => versions..sort((a, b) => _compareId(a.remoteDatabaseID, b.remoteDatabaseID))
        };
      case ListOrderType.recent:
        return switch (listType) {
          ListType.recents => versions..sort((a, b) => _compareId(b.localDatabaseID, a.localDatabaseID)),
          _ => versions..sort((a, b) => _compareId(b.remoteDatabaseID, a.remoteDatabaseID))
        };
    }
  }

  int _compareId(int? a, int? b) {
    return (a ?? 0).compareTo(b ?? 0);
  }
}

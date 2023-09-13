import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/version/use_cases/get_ordered_versions.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';

void main() {
  group("When 'onSelectedOrderCapsule' is called", () {
    test("and selected alphabetic order should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(name: "Zoe"),
        getFakeVersion(name: "Emma"),
        getFakeVersion(name: "Maya"),
        getFakeVersion(name: "Ethan"),
      ];

      final expectNameOrder = ["Emma", "Ethan", "Maya", "Zoe"];

      final orderedList = GetOrderedVersions()(ListOrderType.alphabeticOrder, desorderedList, ListType.user);

      expect(orderedList.length, 4);
      expect(orderedList[0].name, expectNameOrder[0]);
      expect(orderedList[1].name, expectNameOrder[1]);
      expect(orderedList[2].name, expectNameOrder[2]);
      expect(orderedList[3].name, expectNameOrder[3]);
    });

    test("and selected recent order should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(remoteDatabaseId: 10),
        getFakeVersion(remoteDatabaseId: 8),
        getFakeVersion(remoteDatabaseId: 15),
        getFakeVersion(remoteDatabaseId: 9),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.recent, desorderedList, ListType.user);

      expect(orderedList.length, 4);
      expect(orderedList[0].remoteDatabaseId, 15);
      expect(orderedList[1].remoteDatabaseId, 10);
      expect(orderedList[2].remoteDatabaseId, 9);
      expect(orderedList[3].remoteDatabaseId, 8);
    });

    test("and selected recent order and is recent songbook should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(localDatabaseId: 10, lastUpdate: DateTime.fromMillisecondsSinceEpoch(5000)),
        getFakeVersion(localDatabaseId: 8, lastUpdate: DateTime.fromMillisecondsSinceEpoch(6000)),
        getFakeVersion(localDatabaseId: 15, lastUpdate: DateTime.fromMillisecondsSinceEpoch(7000)),
        getFakeVersion(localDatabaseId: 9, lastUpdate: DateTime.fromMillisecondsSinceEpoch(8000)),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.recent, desorderedList, ListType.recents);

      expect(orderedList.length, 4);
      expect(orderedList[0].localDatabaseId, 9);
      expect(orderedList[1].localDatabaseId, 15);
      expect(orderedList[2].localDatabaseId, 8);
      expect(orderedList[3].localDatabaseId, 10);
    });

    test("and selected oldest order should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(remoteDatabaseId: 10),
        getFakeVersion(remoteDatabaseId: 8),
        getFakeVersion(remoteDatabaseId: 15),
        getFakeVersion(remoteDatabaseId: 9),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.oldest, desorderedList, ListType.user);

      expect(orderedList.length, 4);
      expect(orderedList[0].remoteDatabaseId, 8);
      expect(orderedList[1].remoteDatabaseId, 9);
      expect(orderedList[2].remoteDatabaseId, 10);
      expect(orderedList[3].remoteDatabaseId, 15);
    });

    test("and selected oldest order and is recent songbook should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(localDatabaseId: 8, lastUpdate: DateTime.fromMillisecondsSinceEpoch(6000)),
        getFakeVersion(localDatabaseId: 10, lastUpdate: DateTime.fromMillisecondsSinceEpoch(5000)),
        getFakeVersion(localDatabaseId: 9, lastUpdate: DateTime.fromMillisecondsSinceEpoch(8000)),
        getFakeVersion(localDatabaseId: 15, lastUpdate: DateTime.fromMillisecondsSinceEpoch(7000)),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.oldest, desorderedList, ListType.recents);

      expect(orderedList.length, 4);
      expect(orderedList[0].localDatabaseId, 10);
      expect(orderedList[1].localDatabaseId, 8);
      expect(orderedList[2].localDatabaseId, 15);
      expect(orderedList[3].localDatabaseId, 9);
    });

    test("and selected custom order should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(order: 10),
        getFakeVersion(order: 8),
        getFakeVersion(order: 15),
        getFakeVersion(order: 9),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.custom, desorderedList, ListType.user);

      expect(orderedList.length, 4);
      expect(orderedList[0].order, 8);
      expect(orderedList[1].order, 9);
      expect(orderedList[2].order, 10);
      expect(orderedList[3].order, 15);
    });
  });
}

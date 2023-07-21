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
        getFakeVersion(remoteDatabaseID: 10),
        getFakeVersion(remoteDatabaseID: 8),
        getFakeVersion(remoteDatabaseID: 15),
        getFakeVersion(remoteDatabaseID: 9),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.recent, desorderedList, ListType.user);

      expect(orderedList.length, 4);
      expect(orderedList[0].remoteDatabaseID, 15);
      expect(orderedList[1].remoteDatabaseID, 10);
      expect(orderedList[2].remoteDatabaseID, 9);
      expect(orderedList[3].remoteDatabaseID, 8);
    });

    test("and selected recent order and is recent songbook should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(localDatabaseID: 10),
        getFakeVersion(localDatabaseID: 8),
        getFakeVersion(localDatabaseID: 15),
        getFakeVersion(localDatabaseID: 9),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.recent, desorderedList, ListType.recents);

      expect(orderedList.length, 4);
      expect(orderedList[0].localDatabaseID, 15);
      expect(orderedList[1].localDatabaseID, 10);
      expect(orderedList[2].localDatabaseID, 9);
      expect(orderedList[3].localDatabaseID, 8);
    });

    test("and selected oldest order should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(remoteDatabaseID: 10),
        getFakeVersion(remoteDatabaseID: 8),
        getFakeVersion(remoteDatabaseID: 15),
        getFakeVersion(remoteDatabaseID: 9),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.oldest, desorderedList, ListType.user);

      expect(orderedList.length, 4);
      expect(orderedList[0].remoteDatabaseID, 8);
      expect(orderedList[1].remoteDatabaseID, 9);
      expect(orderedList[2].remoteDatabaseID, 10);
      expect(orderedList[3].remoteDatabaseID, 15);
    });

    test("and selected oldest order and is recent songbook should sort correctly", () async {
      final desorderedList = [
        getFakeVersion(localDatabaseID: 10),
        getFakeVersion(localDatabaseID: 8),
        getFakeVersion(localDatabaseID: 15),
        getFakeVersion(localDatabaseID: 9),
      ];

      final orderedList = GetOrderedVersions()(ListOrderType.oldest, desorderedList, ListType.recents);

      expect(orderedList.length, 4);
      expect(orderedList[0].localDatabaseID, 8);
      expect(orderedList[1].localDatabaseID, 9);
      expect(orderedList[2].localDatabaseID, 10);
      expect(orderedList[3].localDatabaseID, 15);
    });
  });
}

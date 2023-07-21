import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

enum ListOrderType {
  custom("CUSTOM_KEY"),
  recent("RECENT_KEY"),
  oldest("OLDEST_KEY"),
  alphabeticOrder("ALPHABETIC_KEY");

  final String key;
  const ListOrderType(this.key);

  String getName(BuildContext context) {
    return switch (this) {
      custom => context.text.customOrder,
      recent => context.text.recentOrder,
      oldest => context.text.oldestOrder,
      alphabeticOrder => context.text.alphabeticalOrder,
    };
  }

  static List<ListOrderType> getValuesByListType(ListType listType) => switch (listType) {
        ListType.user => ListOrderType.values,
        _ => List<ListOrderType>.from(ListOrderType.values)..removeAt(0)
      };

  static ListOrderType getOrderTypeByKey(String? key) =>
      ListOrderType.values.singleWhere((element) => element.key == key, orElse: () => ListOrderType.custom);
}

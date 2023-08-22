// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

enum SearchFilter {
  songs("2"),
  artists("1"),
  lists("5"),
  albums("6");

  final String? searchType;
  const SearchFilter(this.searchType);

  SearchFilter? getSearchFilterByType(String searchType) {
    return SearchFilter.values.firstWhereOrNull((element) => element.searchType == searchType);
  }

  String getSearchFilterName(BuildContext context) {
    switch (this) {
      case songs:
        return context.text.songs(2);
      case artists:
        return context.text.artists;
      case lists:
        return context.text.lists;
      case albums:
        return context.text.albums;
    }
  }
}

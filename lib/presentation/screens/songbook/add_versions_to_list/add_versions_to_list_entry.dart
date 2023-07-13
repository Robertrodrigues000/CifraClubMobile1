// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AddVersionsToListEntry extends ScreenEntry {
  static const name = "addVersionsToList";
  static const songbookIdKey = "songbookIdKey";

  static Map<String, String> declareParams(int songbookId) {
    return {songbookIdKey: songbookId.toString()};
  }

  AddVersionsToListEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    final songbookId = int.parse(params[songbookIdKey] ?? "0");

    return BlocProvider(
      create: (context) => AddVersionsToListBloc(
        songbookId,
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      )..init(songbookId),
      child: const AddVersionsToListScreen(),
    );
  }
}

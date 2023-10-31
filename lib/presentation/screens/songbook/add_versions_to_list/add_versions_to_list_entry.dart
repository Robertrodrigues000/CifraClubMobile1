// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AddVersionsToListEntry extends ScreenEntry {
  static const name = "AddVersionsToList";
  static const songbookIdParamKey = "songbookId";
  static Future<void> push(Nav nav, int songbookId) {
    return nav.push(screenName: name, params: {songbookIdParamKey: songbookId.toString()});
  }

  AddVersionsToListEntry(super.params);

  int? get songbookId => int.tryParse(params[songbookIdParamKey] ?? "");

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddVersionsToListBloc(
        songbookId!,
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      )..init(),
      child: const AddVersionsToListScreen(),
    );
  }
}

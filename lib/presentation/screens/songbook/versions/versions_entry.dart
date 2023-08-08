// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class VersionsEntry extends ScreenEntry {
  static const name = "Versions";
  static const songbookIdKey = "songbookIdKey";
  static const userIdKey = "userIdKey";

  static Map<String, String> declareParams(int? songbookId, int? userId) {
    return {songbookIdKey: songbookId.toString(), userIdKey: userId.toString()};
  }

  VersionsEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    final songbookId = int.tryParse(params[songbookIdKey] ?? "");
    final userId = int.tryParse(params[userIdKey] ?? "");

    return BlocProvider(
      create: (context) => VersionsBloc(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      ),
      child: VersionsScreen(
        isTablet: false,
        userId: userId,
        songbookId: songbookId,
        listOptionsbottomSheet: getIt(),
      ),
    );
  }
}

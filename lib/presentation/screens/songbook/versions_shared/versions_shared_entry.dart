// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class VersionsSharedEntry extends ScreenEntry {
  static const name = "VersionsShared";
  static const songbookIdParamKey = "songbookId";
  static const userIdParamKey = "userId";
  VersionsSharedEntry(super.params);

  static void push(Nav nav, int songbookId, int userId) {
    nav.push(screenName: name, params: {
      songbookIdParamKey: songbookId.toString(),
      userIdParamKey: userId.toString(),
    });
  }

  int? get songbookId => int.tryParse(params[songbookIdParamKey] ?? "");
  int? get userId => int.tryParse(params[userIdParamKey] ?? "");
  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VersionsSharedBloc>(
      create: (context) => VersionsSharedBloc(
        getIt(),
        getIt(),
        getIt(),
        getIt(),
      )..init(songbookId),
      child: VersionsSharedScreen(
        userId: userId,
        songbookId: songbookId,
      ),
    );
  }
}

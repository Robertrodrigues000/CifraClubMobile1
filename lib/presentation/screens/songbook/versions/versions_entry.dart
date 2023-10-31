// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class VersionsEntry extends ScreenEntry {
  static const name = "Versions";
  static const songbookIdParamKey = "songbookId";
  static const userIdParamKey = "userId";
  VersionsEntry(super.params);

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
    return BlocProvider<VersionsBloc>(
      create: (context) => VersionsBloc(
          getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt())
        ..init(songbookId),
      child: VersionsScreen(
        isTablet: false,
        userId: userId,
        songbookId: songbookId,
        listOptionsBottomSheet: getIt(),
      ),
    );
  }
}

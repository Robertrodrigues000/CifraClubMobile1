// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class SongbookEntry extends ScreenEntry {
  static const name = "SongbookEntry";

  SongbookEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ListsBloc(
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
                  getIt(),
                  getIt(),
                  getIt(),
                  getIt(),
                  getIt(),
                  getIt(),
                )),
        BlocProvider(create: (context) => VersionsBloc(getIt())),
        BlocProvider(create: (context) => SongbookBloc(getIt(), getIt())),
      ],
      child: SongbookScreen(
        editListScreenBuilder: getIt(),
      ),
    );
  }
}

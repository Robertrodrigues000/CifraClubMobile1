// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class VersionsEntry extends ScreenEntry {
  static const name = "VersionsEntry";

  VersionsEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VersionsBloc(getIt()),
      child: VersionsScreen(
        isTablet: false,
        songbook: Songbook(
          id: 10031583,
          name: "Aquelas",
          isPublic: true,
          createdAt: DateTime(12),
          totalSongs: 1,
          type: ListType.user,
          preview: const [],
        ),
        editListScreenBuilder: getIt(),
      ),
    );
  }
}

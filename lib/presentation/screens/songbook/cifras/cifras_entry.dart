// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/cifras/cifras_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class CifrasEntry extends ScreenEntry {
  static const name = "CifrasEntry";

  CifrasEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CifrasBloc(),
      child: CifrasScreen(
        isTablet: false,
        songbook: Songbook(
          name: "fds.afd,m.sa fm,n.d sddd ss efdsr a",
          isPublic: false,
          createdAt: DateTime(12),
          totalSongs: 1,
          type: ListType.user,
        ),
      ),
    );
  }
}

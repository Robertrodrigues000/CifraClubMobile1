// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/lists_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_screen.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class SongbookEntry extends ScreenEntry {
  static const name = "Songbook";

  SongbookEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return DeviceTypeBuilder(builder: (context, deviceType) {
      return MultiBlocProvider(providers: [
        BlocProvider<ListsBloc>(
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
                )..init()),
        BlocProvider<SongbookBloc>(create: (context) => SongbookBloc(getIt(), getIt())..init()),
        if (deviceType == DeviceType.tablet)
          BlocProvider<VersionsBloc>(
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
              getIt(),
              getIt(),
              getIt(),
            ),
          ),
      ], child: SongbookScreen(deviceType, getIt()));
    });
  }
}

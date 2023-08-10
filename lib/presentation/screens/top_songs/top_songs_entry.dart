// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_bloc.dart';
import 'package:cifraclub/presentation/screens/top_songs/top_songs_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class TopSongsEntry extends ScreenEntry {
  static const name = "TopSongs";

  TopSongsEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopSongsBloc>(
      create: (context) => TopSongsBloc(
        getIt(),
        getIt(),
        getIt(),
      )..init(),
      child: TopSongsScreen(getIt()),
    );
  }
}

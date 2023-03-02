// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_bloc.dart';
import 'package:cifraclub/presentation/screens/top_artists/top_artists_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class TopArtistsEntry extends ScreenEntry {
  static const name = "TopArtists";

  TopArtistsEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TopArtistsBloc>(
      create: (context) => TopArtistsBloc(
        getIt(),
        getIt(),
      ),
      child: const TopArtistsScreen(),
    );
  }
}

// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class ArtistEntry extends ScreenEntry {
  static const name = "ArtistEntry";
  static const artistUrlParamKey = "artistUrl";

  ArtistEntry(super.params);

  static void push(Nav nav, String artistUrl) {
    nav.push(screenName: name, params: {
      artistUrlParamKey: artistUrl,
    });
  }

  String? get artistUrl => params[artistUrlParamKey];

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArtistBloc>(
      create: (context) => ArtistBloc(
        artistUrl ?? "",
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
      )..init(),
      child: ArtistScreen(
        versionOptionsBottomSheet: getIt(),
      ),
    );
  }
}

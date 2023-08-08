import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/content_middleware.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_loader_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class VersionEntry extends ScreenEntry {
  static const name = "Version";
  static const artistUrlParamKey = "artistUrl";
  static const songUrlParamKey = "songUrl";
  static const artistNameParamKey = "artistName";
  static const songNameParamKey = "songName";
  static const songbookVersionIdKey = "songbookVersionIdKey";

  VersionEntry(super.params);

  static void pushFromSongbook(Nav nav, int songbookVersionId) {
    nav.push(screenName: name, params: {songbookVersionIdKey: songbookVersionId.toString()});
  }

  static void pushFromSong(Nav nav, String artistUrl, String songUrl, String artistName, String songName) {
    nav.push(
      screenName: name,
      params: {
        artistUrlParamKey: artistUrl,
        songUrlParamKey: songUrl,
        artistNameParamKey: artistName,
        songNameParamKey: songName,
      },
    );
  }

  String? get artistUrl => params[artistUrlParamKey];
  String? get songUrl => params[songUrlParamKey];
  String? get artistName => params[artistNameParamKey];
  String? get songName => params[songNameParamKey];
  int? get songbookVersionId => int.tryParse(params[songbookVersionIdKey] ?? "");

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VersionBloc>(
      create: (context) => VersionBloc([getIt<VersionLoaderMiddleware>(), getIt<ContentMiddleware>()], getIt())
        ..add(OnVersionInit(
          artistName: artistName,
          songName: songName,
          artistUrl: artistUrl,
          songUrl: songUrl,
          songbookVersionId: songbookVersionId,
        )),
      child: const VersionScreen(),
    );
  }
}

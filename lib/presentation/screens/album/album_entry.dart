// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/album/album_bloc.dart';
import 'package:cifraclub/presentation/screens/album/album_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AlbumEntry extends ScreenEntry {
  static const name = "Album";
  static const artistUrlParamKey = "artistUrl";
  static const albumUrlParamKey = "albumUrl";
  static const albumNameParamKey = "albumName";

  AlbumEntry(super.params);

  static void push(Nav nav, String artistUrl, String albumUrl, String albumName) {
    nav.push(
      screenName: name,
      params: {albumNameParamKey: albumName, albumUrlParamKey: albumUrl, artistUrlParamKey: artistUrl},
    );
  }

  String? get artistUrl => params[artistUrlParamKey];
  String? get albumUrl => params[albumUrlParamKey];
  String? get albumName => params[albumNameParamKey];

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
      create: (context) => AlbumBloc(artistUrl, albumUrl, getIt())..init(),
      child: AlbumScreen(
        name: albumName ?? "",
        versionOptionsBottomSheet: VersionOptionsBottomSheet(getIt()),
      ),
    );
  }
}

// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/albums/albums_bloc.dart';
import 'package:cifraclub/presentation/screens/albums/albums_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AlbumsEntry extends ScreenEntry {
  static const name = "Albums";
  static const artistUrlParamKey = "artistUrl";
  static const artistNameParamKey = "artistName";
  static const totalAlbumsParamKey = "totalAlbums";

  AlbumsEntry(super.params);

  static void push(Nav nav, String artistUrl, String artistName, String totalAlbums) {
    nav.push(
      screenName: name,
      params: {artistUrlParamKey: artistUrl, artistNameParamKey: artistName, totalAlbumsParamKey: totalAlbums},
    );
  }

  String? get artistUrl => params[artistUrlParamKey];
  String? get artistName => params[artistNameParamKey];
  String? get totalAlbums => params[totalAlbumsParamKey];

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumsBloc>(
      create: (context) => AlbumsBloc(
        artistUrl,
        getIt(),
      )..init(),
      child: AlbumsScreen(
        artistName: artistName ?? "",
        totalAlbums: totalAlbums ?? "",
      ),
    );
  }
}

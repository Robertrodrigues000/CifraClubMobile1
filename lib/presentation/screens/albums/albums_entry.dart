// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/albums/albums_bloc.dart';
import 'package:cifraclub/presentation/screens/albums/albums_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AlbumsEntry extends ScreenEntry {
  static const name = "Albums";

  AlbumsEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumsBloc(
        params['url'] as String,
        getIt(),
      )..init(),
      child: AlbumsScreen(
        artistName: params['name'] as String,
        totalAlbums: params['totalAlbums'] as String,
      ),
    );
  }
}

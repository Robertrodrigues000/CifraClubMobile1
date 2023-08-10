// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:nav/nav.dart';
import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenreEntry extends ScreenEntry {
  static const name = "Genre";
  static const genreUrlParamKey = "genreUrl";
  static const genreNameParamKey = "genreName";

  GenreEntry(super.params);

  static void push(Nav nav, String genreUrl, String genreName) {
    nav.push(screenName: name, params: {
      genreUrlParamKey: genreUrl,
      genreNameParamKey: genreName,
    });
  }

  String? get genreUrl => params[genreUrlParamKey];
  String? get genreName => params[genreNameParamKey];

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    assert(genreUrl != null, "Invalid genre url");
    return BlocProvider<GenreBloc>(
      create: (context) => GenreBloc(
        genreUrl ?? "",
        genreName,
        getIt(),
      )..init(),
      child: const GenreScreen(),
    );
  }
}

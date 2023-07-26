// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:nav/nav.dart';
import 'package:cifraclub/presentation/screens/genre/genre_bloc.dart';
import 'package:cifraclub/presentation/screens/genre/genre_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenreEntry extends ScreenEntry {
  static const name = "Genre";
  static const genreUrlParamKey = "genreUrlParamKey";
  static const genreNameParamKey = "genreNameParamKey";

  GenreEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    assert(params[genreUrlParamKey] != null, "Invalid genre url");
    final genreUrl = params[genreUrlParamKey] ?? "";
    final genreName = params[genreNameParamKey];
    return BlocProvider<GenreBloc>(
      create: (context) => GenreBloc(
        genreUrl,
        genreName,
        getIt(),
      ),
      child: const GenreScreen(),
    );
  }
}

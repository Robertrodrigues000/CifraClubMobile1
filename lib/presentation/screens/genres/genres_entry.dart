// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/genres/genres_bloc.dart';
import 'package:cifraclub/presentation/screens/genres/genres_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class GenresEntry extends ScreenEntry {
  static const name = "genres";

  GenresEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GenresBloc>(
      create: (context) => GenresBloc(
        getIt(),
      ),
      child: const GenresScreen(),
    );
  }
}

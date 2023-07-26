// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class SearchEntry extends ScreenEntry {
  static const name = "Search";

  const SearchEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(getIt())..init(),
      child: const SearchScreen(),
    );
  }
}

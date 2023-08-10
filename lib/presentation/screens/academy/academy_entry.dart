// coverage:ignore-file
import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/presentation/screens/academy/academy_bloc.dart';
import 'package:cifraclub/presentation/screens/academy/academy_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class AcademyEntry extends ScreenEntry {
  static const name = "Academy";

  AcademyEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AcademyBloc>(
      create: (context) => AcademyBloc(getIt(), getIt())..init(),
      child: const AcademyScreen(),
    );
  }
}

import 'package:cifraclub/di/di_setup.dart';
import 'package:nav/nav.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_bloc.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NtpTestEntry extends ScreenEntry {
  static const name = "ntpTestEntry";
  static const colorParamKey = "color";

  NtpTestEntry(super.params);

  @override
  String get screenName => name;

  @override
  String? get screenViewName => name;

  @override
  Widget build(BuildContext context) {
    final color = Color(int.tryParse(params[colorParamKey] ?? "0") ?? 0);
    return BlocProvider<NtpTestBloc>(
      create: (context) => NtpTestBloc(
        getCurrentTime: getIt(),
      ),
      child: NtpTestScreen(color: color),
    );
  }
}

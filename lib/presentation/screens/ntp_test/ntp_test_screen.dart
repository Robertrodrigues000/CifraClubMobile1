import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_bloc.dart';
import 'package:cifraclub/presentation/screens/ntp_test/ntp_test_state.dart';
import 'package:cifraclub/presentation/style/app_color_scheme/app_color_scheme.dart';
import 'package:cifraclub/presentation/style/app_typography_scheme/app_typography_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NtpTestScreen extends StatefulWidget {
  final Color color;

  const NtpTestScreen({Key? key, required this.color}) : super(key: key);

  @override
  State<NtpTestScreen> createState() => _NtpTestScreenState();
}

class _NtpTestScreenState extends State<NtpTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(
          context.text.ntpScreen,
          style: AppTypographyScheme.of(context).exoticScreenAppBarStyle,
        ),
      ),
      body: BlocBuilder<NtpTestBloc, NtpTestState>(
        builder: (BuildContext context, NtpTestState state) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_getStateMessage(context, state),
                    style: TextStyle(
                      color: AppColorScheme.of(context).screenCenterMessageColor,
                    )),
                const SizedBox(height: 16.0),
                if (state is NtpTestLoadingState)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: BlocProvider.of<NtpTestBloc>(context).requireCurrentTime,
                    child: Text(
                      context.text.getIt,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getStateMessage(BuildContext context, NtpTestState state) {
    switch (state.runtimeType) {
      case NtpTestInitialState:
        return context.text.pressTheButtonToGetTheCurrentTime;
      case NtpTestLoadedState:
        state as NtpTestLoadedState;
        return context.text.currentTimeIs(state.currentTime.toString());
      case NtpTestLoadingState:
        return context.text.loading;
      default:
        return context.text.failToLoad;
    }
  }
}

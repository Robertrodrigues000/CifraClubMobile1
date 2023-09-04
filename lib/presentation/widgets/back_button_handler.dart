import 'dart:io';

import 'package:flutter/widgets.dart';

class BackButtonHandler extends StatelessWidget {
  final Widget child;
  final Future<bool> Function() onWillPop;
  final bool isIos;

  BackButtonHandler({
    super.key,
    bool? isIos,
    required this.onWillPop,
    required this.child,
  }) : isIos = isIos ?? Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIos) {
      return child;
    } else {
      return WillPopScope(
        onWillPop: onWillPop,
        child: child,
      );
    }
  }
}

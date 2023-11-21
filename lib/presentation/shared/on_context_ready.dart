import 'package:flutter/material.dart';

mixin OnContextReady<T extends StatefulWidget> on State<T> {
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      isInitialized = true;
      onContextReady(context);
    }
  }

  void onContextReady(BuildContext context);
}

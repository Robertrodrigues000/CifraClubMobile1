import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final VoidCallback? tryAgain;

  const AppErrorWidget({
    super.key,
    this.tryAgain,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tryAgain,
      customBorder: const CircleBorder(),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Text(context.text.failToLoad),
            ),
            if (tryAgain != null) Text(context.text.tryAgain),
          ],
        ),
      ),
    );
  }
}

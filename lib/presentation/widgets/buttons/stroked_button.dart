import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

// coverage:ignore-file
class StrokedButton extends StatelessWidget {
  const StrokedButton({
    super.key,
    required this.text,
    required this.onClick,
    this.padding = EdgeInsets.zero,
  });
  final String text;
  final VoidCallback onClick;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: OutlinedButton(
        onPressed: onClick,
        child: Text(
          text,
          style: context.typography.body9,
        ),
      ),
    );
  }
}

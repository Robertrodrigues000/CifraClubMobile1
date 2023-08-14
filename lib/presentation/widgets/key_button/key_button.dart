// coverage:ignore-file
import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class KeyButton extends StatelessWidget {
  final KeyButtonState keyButtonState;
  final String text;
  final double size;
  final Function(String) onTap;

  const KeyButton(
      {super.key, required this.text, required this.keyButtonState, required this.onTap, required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(text),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: keyButtonState.getBorderColor(context)),
          shape: BoxShape.circle,
          color: keyButtonState.getBackgroundColor(context),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Text(text,
              style: context.typography.subtitle3.copyWith(
                color: keyButtonState.getTextColor(context),
              )),
        ),
      ),
    );
  }
}

enum KeyButtonState {
  selected(),
  unselected(),
  original();

  Color getBackgroundColor(BuildContext context) {
    return switch (this) {
      KeyButtonState.selected => context.colors.primary,
      KeyButtonState.unselected => Colors.transparent,
      KeyButtonState.original => Colors.transparent
    };
  }

  Color getTextColor(BuildContext context) {
    return switch (this) {
      KeyButtonState.selected => Colors.white,
      KeyButtonState.unselected => context.colors.textSecondary,
      KeyButtonState.original => context.colors.primary
    };
  }

  Color getBorderColor(BuildContext context) {
    return switch (this) {
      KeyButtonState.selected => context.colors.primary,
      KeyButtonState.unselected => context.colors.neutralTertiary,
      KeyButtonState.original => context.colors.primary
    };
  }
}

import 'package:cifraclub/presentation/style/typography/app_typography_scheme.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

// coverage:ignore-file
class CifraButton extends StatelessWidget {
  final ButtonType type;
  final VoidCallback? onPressed;
  final Widget? child;
  final EdgeInsets padding;
  final double? height;

  const CifraButton(
      {Key? key, required this.type, this.onPressed, this.child, this.padding = EdgeInsets.zero, this.height = 48})
      : super(key: key);

  TextStyle _getTitleTextStyle(BuildContext context, CosmosColorScheme colorScheme, bool enabled) {
    final label = AppTypographyScheme.of(context).body9;
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return label.copyWith(color: enabled ? colorScheme.textPrimaryInverse : colorScheme.disabled);
      case ButtonType.tertiary:
        return label.copyWith(color: enabled ? colorScheme.textPrimaryInverse : colorScheme.successTertiary);
      case ButtonType.outline:
      case ButtonType.ghost:
        return label.copyWith(color: enabled ? colorScheme.textPrimary : colorScheme.disabled);
    }
  }

  Color _getBackgroundColor(CosmosColorScheme colorScheme, Set<MaterialState> states) {
    switch (type) {
      case ButtonType.primary:
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.neutralSecondary;
        }
        return colorScheme.primary;
      case ButtonType.secondary:
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.neutralSecondary;
        }
        return colorScheme.textPrimary;
      case ButtonType.tertiary:
        return colorScheme.successPrimary;
      case ButtonType.outline:
        return CosmosColors.transparent;
      case ButtonType.ghost:
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.neutralSecondary;
        }
        return CosmosColors.transparent;
    }
  }

  Color _getOverlayColor(CosmosColorScheme colorScheme) {
    switch (type) {
      case ButtonType.primary:
        return colorScheme.tertiary;
      case ButtonType.secondary:
        return colorScheme.neutralTenth;
      case ButtonType.tertiary:
        return colorScheme.successTertiary;
      case ButtonType.outline:
        return colorScheme.neutralTertiary;
      case ButtonType.ghost:
        return colorScheme.neutralTertiary;
    }
  }

  BorderSide _getBorderColor(CosmosColorScheme colorScheme, Set<MaterialState> states) {
    final Color color;
    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
      case ButtonType.tertiary:
      case ButtonType.ghost:
        color = CosmosColors.transparent;
        break;
      case ButtonType.outline:
        color = _getOutlineBorderColor(colorScheme, states);
        break;
    }
    return BorderSide(width: 1.0, color: color);
  }

  Color _getOutlineBorderColor(CosmosColorScheme colorScheme, Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return colorScheme.neutralQuintenary;
    } else if (states.contains(MaterialState.disabled)) {
      return colorScheme.neutralSecondary;
    }
    return colorScheme.neutralTertiary;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = CosmosColorScheme.of(context);
    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith((states) {
                return states.contains(MaterialState.pressed) ? _getOverlayColor(colorScheme) : null;
              }),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) => _getBackgroundColor(colorScheme, states)),
              side: MaterialStateProperty.resolveWith<BorderSide>((states) => _getBorderColor(colorScheme, states)),
              splashFactory: InkRipple.splashFactory),
          child: child != null
              ? DefaultTextStyle(style: _getTitleTextStyle(context, colorScheme, onPressed != null), child: child!)
              : null,
        ),
      ),
    );
  }
}

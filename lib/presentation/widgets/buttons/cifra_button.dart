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
  final double height;
  final double? width;

  const CifraButton(
      {Key? key,
      required this.type,
      this.onPressed,
      this.child,
      this.padding = EdgeInsets.zero,
      this.height = 48,
      this.width})
      : super(key: key);

  TextStyle _getTitleTextStyle(BuildContext context, CosmosColorScheme colorScheme, bool enabled) {
    final label = AppTypographyScheme.of(context).body9;
    switch (type) {
      case ButtonType.solidOrange:
      case ButtonType.solidBlack:
        return label.copyWith(color: enabled ? colorScheme.textPrimaryInverse : colorScheme.disabled);
      case ButtonType.solidGreen:
        return label.copyWith(color: enabled ? colorScheme.textPrimaryInverse : colorScheme.successTertiary);
      case ButtonType.outline:
      case ButtonType.ghostWhite:
        return label.copyWith(color: enabled ? colorScheme.textPrimary : colorScheme.disabled);
    }
  }

  Color _getBackgroundColor(CosmosColorScheme colorScheme, Set<MaterialState> states) {
    switch (type) {
      case ButtonType.solidOrange:
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.neutralSecondary;
        }
        return colorScheme.primary;
      case ButtonType.solidBlack:
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.neutralSecondary;
        }
        return colorScheme.textPrimary;
      case ButtonType.solidGreen:
        return colorScheme.successPrimary;
      case ButtonType.outline:
        return CosmosColors.transparent;
      case ButtonType.ghostWhite:
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.neutralSecondary;
        }
        return CosmosColors.transparent;
    }
  }

  Color _getOverlayColor(CosmosColorScheme colorScheme) {
    switch (type) {
      case ButtonType.solidOrange:
        return colorScheme.tertiary;
      case ButtonType.solidBlack:
        return colorScheme.neutralTenth;
      case ButtonType.solidGreen:
        return colorScheme.successTertiary;
      case ButtonType.outline:
        return colorScheme.neutralTertiary;
      case ButtonType.ghostWhite:
        return colorScheme.neutralTertiary;
    }
  }

  BorderSide _getBorderColor(CosmosColorScheme colorScheme, Set<MaterialState> states) {
    final Color color;
    switch (type) {
      case ButtonType.solidOrange:
      case ButtonType.solidBlack:
      case ButtonType.solidGreen:
      case ButtonType.ghostWhite:
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
        width: width,
        child: OutlinedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((states) {
              return states.contains(MaterialState.pressed) ? _getOverlayColor(colorScheme) : null;
            }),
            backgroundColor:
                MaterialStateProperty.resolveWith<Color>((states) => _getBackgroundColor(colorScheme, states)),
            side: MaterialStateProperty.resolveWith<BorderSide>((states) => _getBorderColor(colorScheme, states)),
            splashFactory: InkRipple.splashFactory,
            minimumSize: MaterialStateProperty.resolveWith((states) => const Size(162, 32)),
          ),
          child: child != null
              ? DefaultTextStyle(style: _getTitleTextStyle(context, colorScheme, onPressed != null), child: child!)
              : null,
        ),
      ),
    );
  }
}

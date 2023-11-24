import 'package:cifraclub/domain/chord/models/bar.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:flutter/material.dart';

class BarWidget extends StatelessWidget {
  final Bar bar;
  final ChordUISettings gridUiSettings;

  const BarWidget({
    super.key,
    required this.bar,
    required this.gridUiSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: gridUiSettings.getBarWidth(bar: bar),
        height: gridUiSettings.barHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: context.colors.textPrimary,
        ));
  }
}

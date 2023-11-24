import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/style/typography/font_families.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class CapoWidget extends StatelessWidget {
  final ChordUISettings settings;
  final Capo capo;
  const CapoWidget({super.key, required this.settings, required this.capo});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: settings.width,
      height: settings.capoHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgImage(
            assetPath: AppSvgs.guitarCapo,
            width: settings.chordGridWidth - settings.stringsPadding,
            height: settings.capoHeight,
            color: context.colors.textPrimary,
          ),
          Positioned(
            top: ((settings.capoHeight + settings.capoNutHeight - settings.barHeight) / 2).ceilToDouble(),
            left: settings.startX - (settings.barPadding / 2).floorToDouble(),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                width: settings.neckIndicatorWidth,
                alignment: Alignment.topCenter,
                child: Text(
                  capo.capoId.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: settings.neckFontSize,
                      color: context.colors.textPrimary,
                      fontFamily: FontFamilies.montserrat),
                  textAlign: TextAlign.right,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: settings.getBarWidth(),
                height: settings.barHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: context.colors.textPrimary,
                ),
                child: Text(
                  context.text.chordCapo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: settings.capoFontSize,
                    letterSpacing: settings.capoWordSpacing,
                    color: context.colors.textPrimaryInverse,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

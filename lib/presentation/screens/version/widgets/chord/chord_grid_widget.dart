import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/bar_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/finger_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChordGridWidget extends StatelessWidget {
  final ChordRepresentation chordRepresentation;
  final ChordUISettings chordUiSettings;
  final bool isLeftHanded;

  const ChordGridWidget({
    super.key,
    required this.chordRepresentation,
    required this.chordUiSettings,
    required this.isLeftHanded,
  });

  @override
  Widget build(BuildContext context) {
    final stringsHeight = chordUiSettings.chordGridHeight;
    final stringsWidth = chordUiSettings.chordGridWidth - 2 * chordUiSettings.stringsPadding;
    final stringsHeightTruncated = stringsHeight.floorToDouble();
    final stringsWidthTruncated = stringsWidth.floorToDouble();
    return SizedBox(
      width: chordUiSettings.chordGridWidth,
      child: Transform.flip(
        flipX: isLeftHanded,
        transformHitTests: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SvgImage(
              assetPath: chordUiSettings.frets,
              height: stringsHeightTruncated,
              width: stringsWidthTruncated,
              color: context.colors.neutralQuaternary,
            ),
            if (chordRepresentation.capo != null &&
                chordRepresentation.capo != Capo.noCapo &&
                chordRepresentation.neck.start == 0)
              Positioned(
                top: 0,
                child: SvgPicture.asset(
                  AppSvgs.guitarHeadCapo,
                  width: stringsWidthTruncated,
                  color: context.colors.textPrimary,
                ),
              ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: getGradientStops(),
                  colors: getGradientColors(context),
                ).createShader(bounds);
              },
              child: SvgImage(
                assetPath: chordUiSettings.strings,
                width: stringsWidthTruncated,
                height: stringsHeightTruncated,
                color: context.colors.textPrimary,
              ),
            ),
            if (chordRepresentation.neck.start == 0 && (chordRepresentation.capo ?? Capo.noCapo) == Capo.noCapo)
              Positioned(
                top: 0,
                child: SvgPicture.asset(
                  chordUiSettings.head,
                  width: stringsWidthTruncated,
                  color: context.colors.textPrimary,
                ),
              ),
            if (chordRepresentation.bar != null)
              Positioned(
                left: chordUiSettings.getBarPosition(bar: chordRepresentation.bar!).dx,
                top: chordUiSettings.getBarPosition(bar: chordRepresentation.bar!).dy,
                child: BarWidget(bar: chordRepresentation.bar!, gridUiSettings: chordUiSettings),
              ),
            for (var finger in chordRepresentation.fingers)
              Positioned(
                left: chordUiSettings.getFingerPosition(fret: finger.fret, string: finger.string).dx,
                top: chordUiSettings.getFingerPosition(fret: finger.fret, string: finger.string).dy,
                child: Transform.flip(
                  flipX: isLeftHanded,
                  child: FingerWidget(
                    ballSize: chordUiSettings.ballSize.toDouble(),
                    fontSize: chordUiSettings.ballFontSize,
                    id: finger.id,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<Color> getGradientColors(BuildContext context) {
    List<Color> colors = [];
    if (chordRepresentation.neck.start > 0) {
      colors = [
        Colors.transparent,
        context.colors.textPrimary,
        context.colors.textPrimary,
        Colors.transparent,
      ];
    } else {
      colors = [
        Colors.transparent,
        context.colors.textPrimary,
        context.colors.textPrimary,
        context.colors.textPrimary,
        Colors.transparent,
      ];
    }

    if (chordRepresentation.capo != null &&
        chordRepresentation.capo != Capo.noCapo &&
        chordRepresentation.neck.start == 0) {
      colors[0] = context.colors.textPrimary;
    }

    return colors;
  }

  List<double> getGradientStops() {
    if (chordRepresentation.neck.start > 0) {
      return const [0.0, 0.2, 0.8, 1];
    } else {
      return const [0.0, 0.05, 0.05, 0.8, 1];
    }
  }
}

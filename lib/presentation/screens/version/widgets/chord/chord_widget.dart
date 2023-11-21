import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_grid_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_title_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/fret_number_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/string_play_indication_widget.dart';
import 'package:flutter/material.dart';

class ChordWidget extends StatelessWidget {
  final ChordRepresentation chordRepresentation;
  final ChordUISettings chordUiSettings;
  final String? count;
  final String? subtitle;
  final bool isLeftHanded;
  final bool isSelected;

  const ChordWidget({
    super.key,
    required this.chordRepresentation,
    required this.chordUiSettings,
    required this.isLeftHanded,
    this.isSelected = false,
    this.count,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: chordUiSettings.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: chordUiSettings.neckIndicatorWidth,
                bottom: subtitle != null ? chordUiSettings.titlePaddingToSubtitle : chordUiSettings.titlePadding),
            child: ChordTitleWidget(chordName: chordRepresentation.name, settings: chordUiSettings),
          ),
          if (subtitle != null)
            Padding(
              padding:
                  EdgeInsets.only(left: chordUiSettings.neckIndicatorWidth, bottom: chordUiSettings.subtitlePadding),
              child: SizedBox(
                width: chordUiSettings.chordGridWidth,
                height: chordUiSettings.subtitleHeight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    subtitle!,
                    maxLines: 1,
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.normal,
                      fontSize: chordUiSettings.subtitleFontSize,
                      height: 1.286,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
          if (count != null)
            Padding(
              padding: EdgeInsets.only(left: chordUiSettings.neckIndicatorWidth, bottom: chordUiSettings.countPadding),
              child: SizedBox(
                width: chordUiSettings.chordGridWidth,
                height: chordUiSettings.countHeight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    count!,
                    maxLines: 1,
                    style: TextStyle(
                      color: context.colors.textSecondary,
                      fontWeight: FontWeight.normal,
                      fontSize: chordUiSettings.countFontSize,
                      height: 1.333,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (chordRepresentation.neck.start > 0)
                Padding(
                  padding: EdgeInsets.only(top: chordUiSettings.getNeckPosition(neck: chordRepresentation.neck).dy),
                  child: FretNumberWidget(settings: chordUiSettings, fret: chordRepresentation.neck.start),
                )
              else
                SizedBox(width: chordUiSettings.neckIndicatorWidth),
              ChordGridWidget(
                chordRepresentation: chordRepresentation,
                chordUiSettings: chordUiSettings,
                isLeftHanded: isLeftHanded,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: chordUiSettings.neckIndicatorWidth,
              top: chordUiSettings.stringPlayIndicationPadding,
            ),
            child: StringPlayIndicationWidget(
              chordRepresentation: chordRepresentation,
              chordUiSettings: chordUiSettings,
              isLeftHanded: isLeftHanded,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            margin: EdgeInsets.symmetric(horizontal: chordUiSettings.neckIndicatorWidth),
            width: chordUiSettings.width,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              color: isSelected ? context.colors.primary : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}

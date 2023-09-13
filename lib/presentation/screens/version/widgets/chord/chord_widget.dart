import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_grid_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_title_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/fret_number_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/string_play_indication_widget.dart';
import 'package:flutter/material.dart';

class ChordWidget extends StatelessWidget {
  final ChordRepresentation chordRepresentation;
  final ChordUISettings chordUiSettings;
  final bool isLeftHanded;

  const ChordWidget({
    super.key,
    required this.chordRepresentation,
    required this.chordUiSettings,
    required this.isLeftHanded,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: chordUiSettings.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: chordUiSettings.neckIndicatorWidth, bottom: chordUiSettings.titlePadding),
            child: ChordTitleWidget(chordName: chordRepresentation.name, settings: chordUiSettings),
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
                left: chordUiSettings.neckIndicatorWidth, top: chordUiSettings.stringPlayIndicationPadding),
            child: StringPlayIndicationWidget(
              chordRepresentation: chordRepresentation,
              chordUiSettings: chordUiSettings,
              isLeftHanded: isLeftHanded,
            ),
          ),
        ],
      ),
    );
  }
}

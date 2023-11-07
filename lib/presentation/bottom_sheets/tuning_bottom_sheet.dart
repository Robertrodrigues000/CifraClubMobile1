import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/tuning.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter/material.dart';

class TuningBottomSheet extends StatelessWidget {
  final Tuning selectedTuning;
  final Function(Tuning tuning) onTap;
  final Instrument instrument;
  const TuningBottomSheet({
    super.key,
    required this.onTap,
    required this.selectedTuning,
    required this.instrument,
  });

  // coverage:ignore-start
  static void show(
    BuildContext context,
    Function(Tuning tuning) onTap,
    final Tuning selectedTuning,
    final Instrument instrument,
  ) {
    DefaultBottomSheet.showBottomSheet(
        context: context,
        child: TuningBottomSheet(
          onTap: onTap,
          selectedTuning: selectedTuning,
          instrument: instrument,
        ));
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: context.appDimensionScheme.screenMargin,
                right: context.appDimensionScheme.screenMargin,
                bottom: 16,
              ),
              child: Text(
                context.text.tuning,
                style: context.typography.title5,
              ),
            ),
            ...Tuning.getTuningsByInstrument(instrument).map((tuning) {
              final isSelected = tuning == selectedTuning;

              return SelectableItem(
                isSelected: isSelected,
                onTap: () {
                  onTap(tuning);
                  DefaultBottomSheet.close(context);
                },
                text: tuning.name,
                isVerified: false,
                trailingIcon: null,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

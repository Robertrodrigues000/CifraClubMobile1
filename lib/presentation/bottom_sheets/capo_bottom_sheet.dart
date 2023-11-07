import 'package:cifraclub/domain/version/models/capo.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/selectable_item.dart';
import 'package:flutter/material.dart';

class CapoBottomSheet extends StatelessWidget {
  final Capo selectedCapo;
  final Function(Capo capo) onTap;
  const CapoBottomSheet({
    super.key,
    required this.onTap,
    required this.selectedCapo,
  });

  // coverage:ignore-start
  static void show(
    BuildContext context,
    Function(Capo capo) onTap,
    final Capo selectedCapo,
  ) {
    DefaultBottomSheet.showBottomSheet(
        heightMaxFactor: 0.7,
        context: context,
        child: CapoBottomSheet(
          onTap: onTap,
          selectedCapo: selectedCapo,
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
                context.text.capo,
                style: context.typography.title5,
              ),
            ),
            ...Capo.values.map((capo) {
              final isSelected = capo == selectedCapo;

              return SelectableItem(
                isSelected: isSelected,
                onTap: () {
                  onTap(capo);
                  DefaultBottomSheet.close(context);
                },
                text: capo.getCapoName(context),
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

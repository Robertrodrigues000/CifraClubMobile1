import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_widget.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChordShapeBottomSheet extends StatefulWidget {
  final ChordRepresentation selectedChord;
  final List<ChordRepresentation> shapes;
  final Instrument instrument;
  final Function(ChordRepresentation chord) onTap;

  const ChordShapeBottomSheet({
    super.key,
    required this.selectedChord,
    required this.shapes,
    required this.instrument,
    required this.onTap,
  });

  // coverage:ignore-start
  static void show(
    BuildContext context,
    ChordRepresentation selectedChord,
    List<ChordRepresentation> shapes,
    Instrument instrument,
    Function(ChordRepresentation chord) onTap,
  ) {
    DefaultBottomSheet.showBottomSheet(
      context: context,
      child: ChordShapeBottomSheet(
        instrument: instrument,
        selectedChord: selectedChord,
        shapes: shapes,
        onTap: onTap,
      ),
    );
  }

  @override
  State<ChordShapeBottomSheet> createState() => _ChordShapeBottomSheetState();
}

class _ChordShapeBottomSheetState extends State<ChordShapeBottomSheet> {
  late var index = widget.shapes.indexWhere((element) => element.original == widget.selectedChord.original);
  late var shouldShowArrowButtons = widget.shapes.length > 1;
  // coverage:ignore-end
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                if (shouldShowArrowButtons)
                  IgnorePointer(
                    key: const ValueKey("leftArrow"),
                    ignoring: index == 0,
                    child: InkWell(
                      onTap: () => setChordIndex(index - 1),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: SvgPicture.asset(
                          AppSvgs.backArrowIcon,
                          fit: BoxFit.none,
                          color: index == 0 ? context.colors.disabled : context.colors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: LayoutBuilder(builder: (layoutcontext, constraints) {
                      var maxWidth = MediaQuery.of(layoutcontext).size.width;
                      var maxHeight = MediaQuery.of(layoutcontext).size.height;

                      //TODO: Selecionar ChordUiSettings de acordo com instrumento
                      final chordSettings = ChordUISettings.guitar().scaledToFit(
                          width: maxWidth / 2,
                          height: maxHeight / 3,
                          hasCount: true,
                          hasSubtitle: true,
                          hasCapo: widget.shapes[index].capo != null);
                      return ChordWidget(
                        key: ValueKey(widget.shapes[index].original),
                        chordRepresentation: widget.shapes[index],
                        chordUiSettings: chordSettings,
                        isLeftHanded: false,
                        count: context.text.chordCount(index + 1, widget.shapes.length),
                        subtitle: "dó maior",
                      );
                    })),
                if (shouldShowArrowButtons)
                  IgnorePointer(
                    key: const ValueKey("rightArrow"),
                    ignoring: index == widget.shapes.length - 1,
                    child: InkWell(
                      onTap: () => setChordIndex(index + 1),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Transform.flip(
                          flipX: true,
                          child: SvgPicture.asset(
                            AppSvgs.backArrowIcon,
                            fit: BoxFit.none,
                            color: index == widget.shapes.length - 1
                                ? context.colors.disabled
                                : context.colors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
            CifraClubButton(
              type: ButtonType.outline,
              onPressed: index > 0 ? () => setChordIndex(0) : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgImage(
                    key: const ValueKey("restoreButton"),
                    assetPath: AppSvgs.refreshIcon,
                    height: 24,
                    width: 24,
                    color: index > 0 ? context.colors.textPrimary : context.colors.disabled,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(context.text.restore),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void setChordIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  void dispose() {
    widget.onTap(widget.shapes[index]);
    super.dispose();
  }
}

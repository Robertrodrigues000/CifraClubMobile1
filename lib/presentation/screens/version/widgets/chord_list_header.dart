// coverage:ignore-file
import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ChordListHeader extends StatefulWidget {
  final bool isChordListPinned;
  final bool isScrolledUnder;
  final List<ChordRepresentation> chordRepresentations;
  final String? selectedChord;
  final Function(ChordRepresentation) onTap;

  const ChordListHeader({
    super.key,
    required this.isChordListPinned,
    required this.isScrolledUnder,
    required this.chordRepresentations,
    required this.selectedChord,
    required this.onTap,
  });

  @override
  State<ChordListHeader> createState() => _ChordListHeaderState();
}

class _ChordListHeaderState extends State<ChordListHeader> {
  final ScrollController _scrollController = ScrollController();
  double? chordWidth;
  var isFirstCall = true;

  @override
  void didUpdateWidget(covariant ChordListHeader oldWidget) {
    if (oldWidget.selectedChord != widget.selectedChord && widget.selectedChord != null && chordWidth != null) {
      final position = widget.chordRepresentations.indexWhere((element) => element.name == widget.selectedChord);
      if (position >= 0) {
        final upperLimit = (chordWidth! * widget.chordRepresentations.length) - MediaQuery.of(context).size.width;
        if (upperLimit <= 0) {
          return;
        }
        final offset = (position * chordWidth!).clamp(0, upperLimit).toDouble();
        // https://github.com/flutter/flutter/issues/20480#issuecomment-415332934

        Future.delayed(Duration.zero, () {
          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 400),
            curve: Curves.linear,
          );
        });
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: widget.isChordListPinned,
      delegate: _ChordListHeaderDelegate(
        isScrolledUnder: widget.isScrolledUnder,
        maxExtend: 110,
        isPinned: widget.isChordListPinned,
        chords: widget.chordRepresentations,
        selectedChord: widget.selectedChord,
        scrollController: _scrollController,
        isFirstCall: isFirstCall,
        onTap: widget.onTap,
        onChordWidth: (width) {
          chordWidth = width;
          isFirstCall = false;
        },
      ),
    );
  }
}

class _ChordListHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final bool isScrolledUnder;
  final bool isPinned;
  final List<ChordRepresentation> chords;
  final String? selectedChord;
  final ScrollController scrollController;
  final Function(double) onChordWidth;
  final bool isFirstCall;
  final Function(ChordRepresentation) onTap;

  _ChordListHeaderDelegate({
    required this.maxExtend,
    required this.isScrolledUnder,
    required this.isPinned,
    required this.chords,
    required this.selectedChord,
    required this.scrollController,
    required this.onChordWidth,
    required this.isFirstCall,
    required this.onTap,
  });

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => isPinned ? maxExtend : 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      child: Container(
        color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
        height: maxExtend,
        child: ListView.builder(
          addAutomaticKeepAlives: false,
          itemCount: chords.length,
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          itemBuilder: (context, index) {
            final chord = chords[index];
            final height = maxExtend - 16;
            final chordUiSettings = ChordUISettings.getChordSettingsForInstrument(
              instrument: chord.instrument,
              height: height,
              hasSelector: true,
              hasCapo: chord.capo != null,
            );

            if (index == 0 && isFirstCall) {
              return Builder(builder: (context) {
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    final renderBox = (context.findRenderObject() as RenderBox).size;
                    onChordWidth(renderBox.width);
                  },
                );
                return InkWell(
                  onTap: () => onTap(chord),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: ChordWidget(
                      chordRepresentation: chord,
                      chordUiSettings: chordUiSettings,
                      isLeftHanded: false,
                      isSelected: chord.name == selectedChord,
                    ),
                  ),
                );
              });
            }
            return InkWell(
              onTap: () => onTap(chord),
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: ChordWidget(
                  chordRepresentation: chord,
                  chordUiSettings: chordUiSettings,
                  isLeftHanded: false,
                  isSelected: chord.name == selectedChord,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! _ChordListHeaderDelegate ||
        oldDelegate.isScrolledUnder != isScrolledUnder ||
        oldDelegate.selectedChord != selectedChord ||
        oldDelegate.minExtent != minExtent ||
        !(const ListEquality().equals(oldDelegate.chords, chords));
  }
}

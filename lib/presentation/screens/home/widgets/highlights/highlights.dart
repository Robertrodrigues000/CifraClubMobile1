// coverage:ignore-file

import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlight_card.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:flutter/material.dart';

class Highlights extends StatelessWidget {
  final List<Highlight> highlights;

  const Highlights({
    super.key,
    required this.highlights,
  });

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    final width = MediaQuery.of(context).size.width;
    final deviceType = getDeviceType(context);
    //this calculus is to make the highlight always occupy the same proportion of the screen in a phone.
    //in a tablet the size will be absolute.
    var highlightCardSize = width * 0.833;
    if (deviceType == DeviceType.tablet) {
      highlightCardSize = 410;
    }
    final viewportFraction = (highlightCardSize + dimensions.internalMargin) / width;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: highlightCardSize,
        child: PageView.builder(
          padEnds: false,
          controller: PageController(viewportFraction: viewportFraction),
          itemCount: highlights.length,
          itemBuilder: (_, index) {
            final isLastItem = index == highlights.length - 1;
            return Padding(
              padding:
                  EdgeInsets.only(left: dimensions.internalMargin, right: isLastItem ? dimensions.internalMargin : 0),
              child: HighlightCard(
                highlight: highlights[index],
                size: highlightCardSize,
                borderRadius: dimensions.highlighCardBorderRadius,
                internalPadding: dimensions.internalMargin,
              ),
            );
          },
        ),
      ),
    );
  }
}

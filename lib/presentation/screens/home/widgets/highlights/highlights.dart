import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/home/widgets/highlights/highlight_section.dart';
import 'package:cifraclub/presentation/screens/home/widgets/list_animation.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Highlights extends StatelessWidget {
  final List<Highlight> highlights;

  const Highlights({
    super.key = const Key("highlights"),
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: SizedBox(
          height: highlightCardSize,
          child: AnimationLimiter(
            child: PageView.builder(
              padEnds: false,
              controller: PageController(viewportFraction: viewportFraction),
              itemCount: highlights.length,
              itemBuilder: (_, index) {
                final isLastItem = index == highlights.length - 1;
                return AnimationConfiguration.staggeredList(
                  duration: ListAnimation.duration,
                  position: index,
                  child: ListAnimation(
                    verticalOffset: null,
                    horizontalOffset: 100,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: dimensions.internalMargin,
                        right: isLastItem ? dimensions.internalMargin : 0,
                      ),
                      child: HighlightSection(
                        key: Key(highlights[index].title),
                        highlight: highlights[index],
                        size: highlightCardSize,
                        borderRadius: dimensions.highlightCardBorderRadius,
                        internalPadding: dimensions.internalMargin,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

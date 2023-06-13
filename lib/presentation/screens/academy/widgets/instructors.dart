import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/instructor_card.dart';
import 'package:flutter/material.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class Instructors extends StatelessWidget {
  const Instructors({
    super.key,
    required this.instructors,
    required this.offset,
  });

  final List<String> instructors;
  final double offset;

  @override
  Widget build(BuildContext context) {
    return ScrollLoopAutoScroll(
      scrollDirection: Axis.horizontal,
      delayAfterScrollInput: Duration.zero,
      enableScrollInput: false,
      gap: 0,
      duplicateChild: 2,
      duration: const Duration(seconds: 30),
      delay: Duration.zero,
      child: Transform.translate(
        offset: Offset(offset, 0),
        child: Row(
          children: instructors
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.paddingBetweenInstructors),
                    child: InstructorCard(assetName: e),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

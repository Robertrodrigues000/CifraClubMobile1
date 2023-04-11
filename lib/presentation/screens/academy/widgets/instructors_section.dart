import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/iterable.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/instructors.dart';
import 'package:flutter/material.dart';

class InstructorsSection extends StatelessWidget {
  const InstructorsSection({super.key, required this.instructors, required this.isTablet});
  final List<String> instructors;
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    const cardWidth = 170;
    const cardPadding = 24;
    const secondRowOffset = -(cardWidth + cardPadding) / 2;

    return Column(
      mainAxisSize: isTablet ? MainAxisSize.min : MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppWebp.logoAcademy,
          height: context.appDimensionScheme.academyLogoHeight,
          fit: BoxFit.fitHeight,
          filterQuality: FilterQuality.high,
        ),
        SizedBox(height: context.appDimensionScheme.academyLogoBottomPadding),
        Flexible(
          child: Instructors(
            instructors: instructors,
            offset: 0,
          ),
        ),
        if (isTablet)
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Instructors(offset: secondRowOffset, instructors: getShiftedInstructors(instructors)),
          )
        else
          const SizedBox(height: 16),
      ],
    );
  }

  List<String> getShiftedInstructors(List<String> instructors) => instructors
      .mapIndexed((e, i) => instructors[(i + (instructors.length / 2).floor()) % instructors.length])
      .toList();
}

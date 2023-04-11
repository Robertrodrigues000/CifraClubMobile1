import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/academy_background_image.dart';
import 'package:cifraclub/presentation/screens/academy/widgets/instructors_section.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
import 'package:flutter/material.dart';

class AcademyScreenTablet extends StatelessWidget {
  const AcademyScreenTablet(
      {super.key,
      required this.safeAreaTopOffset,
      required this.backgroundImagePath,
      required this.instructors,
      required this.isAcademyInstalled,
      required this.openAppOrStore});

  final double safeAreaTopOffset;
  final String backgroundImagePath;
  final List<String> instructors;
  final bool isAcademyInstalled;
  final VoidCallback openAppOrStore;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AcademyBackgroundImage(backgroundImagePath: backgroundImagePath),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InstructorsSection(instructors: instructors, isTablet: true),
            Padding(
              padding: const EdgeInsets.only(left: 72, right: 72, top: 40),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 582),
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: context.appDimensionScheme.verticalMarginAcademyInfo,
                ),
                decoration: BoxDecoration(
                  color: context.colors.neutralPrimary,
                  borderRadius: const BorderRadiusDirectional.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: context.typography.title3,
                        children: [
                          TextSpan(
                            text: context.text.academyScreenTitle1,
                          ),
                          TextSpan(
                            text: context.text.academyScreenTitle2,
                            style: context.typography.title3.copyWith(color: context.colors.primary),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.text.academyScreenDescription,
                      style: context.typography.body10,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    if (context.text.portugueseOnly != "") ...[
                      Text(context.text.portugueseOnly, style: context.typography.subtitle7),
                      const SizedBox(height: 8),
                    ],
                    CifraButton(
                      type: ButtonType.secondary,
                      padding: EdgeInsets.zero,
                      onPressed: openAppOrStore,
                      child: Text(isAcademyInstalled ? context.text.openAcademy : context.text.downloadAcademy),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

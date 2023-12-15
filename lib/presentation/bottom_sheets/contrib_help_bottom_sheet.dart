import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/video_dialog.dart';
import 'package:cifraclub/presentation/screens/contrib/widgets/contrib_bottom_rules.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/default_placeholder.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:flutter/material.dart';

class ContribHelpBottomSheet extends StatelessWidget {
  const ContribHelpBottomSheet({super.key, required this.onTap, required this.youtubeThumbnail});

  final String? youtubeThumbnail;
  final VoidCallback onTap;

  void show(BuildContext context) {
    DefaultBottomSheet.showBottomSheet(
      context: context,
      child: ContribHelpBottomSheet(
        onTap: onTap,
        youtubeThumbnail: youtubeThumbnail,
      ),
      heightMaxFactor: 400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.text.contribDoubt,
                style: context.typography.title5,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                context.text.checkCompleteTutorial,
                style: context.typography.body10,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  ContainerWithRippleEffect(
                    key: const Key("open-video"),
                    width: 100,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: RemoteImage(
                      imageUrl: youtubeThumbnail,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: const DefaultPlaceholder(
                        width: 100,
                        height: 56,
                        svgIcon: AppSvgs.videoPlaceholder,
                        isLarge: false,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      VideoDialog.show(context: context);
                    },
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      "Cifra Club - Aprenda a enviar uma cifra",
                      style: context.typography.subtitle3,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        ContribBottomRules(openUrl: onTap),
      ],
    );
  }
}

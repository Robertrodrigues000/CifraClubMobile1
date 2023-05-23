import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultDialog extends StatelessWidget {
  final String? image;
  final Widget title;
  final Widget? description;
  final Widget? buttons;
  final bool hasCloseIcon;
  final EdgeInsets? insetPadding;
  final double? width;
  const DefaultDialog(
      {Key? key,
      this.image,
      required this.title,
      this.description,
      this.buttons,
      required this.hasCloseIcon,
      this.insetPadding,
      this.width})
      : super(key: key);

  // coverage:ignore-start
  static Future<T?> show<T>(
      {required BuildContext context,
      required Widget title,
      Widget? description,
      Widget? buttons,
      String? image,
      required bool hasCloseIcon}) {
    return showDialog(
        context: context,
        builder: (context) {
          return DefaultDialog(
            title: title,
            description: description,
            buttons: buttons,
            image: image,
            hasCloseIcon: hasCloseIcon,
          );
        });
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    final colorScheme = CosmosColorScheme.of(context);
    return Dialog(
      insetPadding: insetPadding,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: colorScheme.neutralPrimary,
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasCloseIcon) ...[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  alignment: Alignment.topRight,
                  child: Material(
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.pop(context),
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: Center(
                          child: SvgPicture.asset(
                            AppSvgs.closeIcon,
                            height: 24,
                            width: 24,
                            color: colorScheme.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (image != null) ...[
                    Image.asset(image!),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                  title,
                  if (description != null) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    description!
                  ],
                  if (buttons != null) ...[
                    const SizedBox(
                      height: 24,
                    ),
                    buttons!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

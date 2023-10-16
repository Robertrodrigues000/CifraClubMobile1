import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountSelectedVersions extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onClear;
  final int versionsCount;

  const CountSelectedVersions({
    super.key,
    required this.onSave,
    required this.onClear,
    required this.versionsCount,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 48,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Divider(
              height: 1,
              color: context.colors.neutralTertiary,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: context.appDimensionScheme.rightPaddingCard, right: 4),
                child: InkWell(
                  key: const Key("onClearTap"),
                  borderRadius: BorderRadius.circular(24),
                  onTap: onClear,
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: Center(
                      child: SvgPicture.asset(
                        AppSvgs.closeIcon,
                        height: 24,
                        width: 24,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    context.text.selectedVersionsCount(versionsCount),
                    style: context.typography.subtitle4,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              InkWell(
                key: const Key("onSaveTap"),
                onTap: onSave,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    context.text.save,
                    style: context.typography.subtitle4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

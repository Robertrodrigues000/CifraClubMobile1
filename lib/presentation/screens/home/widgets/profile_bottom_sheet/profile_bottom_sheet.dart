import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:cifraclub/presentation/widgets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({
    super.key,
    required this.user,
    required this.onOpenProfile,
    required this.onLogout,
  });

  final User user;
  final VoidCallback onOpenProfile;
  final VoidCallback onLogout;

  void open(BuildContext context) {
    _showProfileBottomSheet(context);
  }

  void _showProfileBottomSheet(
    BuildContext context,
  ) {
    DefaultBottomSheet.showBottomSheet(
      child: ProfileBottomSheet(
        user: user,
        onOpenProfile: onOpenProfile,
        onLogout: onLogout,
      ),
      context: context,
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
          child: Text(
            context.text.profile,
            style: context.typography.title3,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          height: 72,
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RemoteImage(
                imageUrl: user.avatarUrl,
                imageBuilder: (image, imageProvider) => Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                placeholder: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(AppSvgs.profilePlaceholderIcon),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name ?? "",
                      style: context.typography.subtitle3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email ?? "",
                      style: context.typography.subtitle5,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(
            height: 1,
            color: context.colors.neutralTertiary,
          ),
        ),
        IconTextTile(
          onClick: () {
            onOpenProfile();
            DefaultBottomSheet.close(context);
          },
          leadingIconAsset: AppSvgs.editIcon,
          text: context.text.editProfile,
        ),
        IconTextTile(
          onClick: () {
            onLogout();
            DefaultBottomSheet.close(context);
          },
          leadingIconAsset: AppSvgs.exitArrowIcon,
          text: context.text.logout,
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}

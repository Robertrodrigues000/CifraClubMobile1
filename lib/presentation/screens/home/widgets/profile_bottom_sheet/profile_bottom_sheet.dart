import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/icon_text_tile.dart';
import 'package:cifraclub/presentation/widgets/default_bottom_sheet.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({
    super.key,
    required this.user,
    required this.onOpenProfile,
    required this.onOpenMyLists,
    required this.onLogout,
  });

  final User user;
  final VoidCallback onOpenProfile;
  final VoidCallback onOpenMyLists;
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
        onOpenMyLists: onOpenMyLists,
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
            style: CosmosTypography.of(context).title3,
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
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name ?? "",
                      style: CosmosTypography.of(context).subtitle3,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user.email ?? "",
                      style: CosmosTypography.of(context).subtitle5,
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
            color: CosmosColorScheme.of(context).neutralTertiary,
          ),
        ),
        IconTextTile(
          onClick: () {
            onOpenProfile();
            DefaultBottomSheet.close(context);
          },
          leadingIcon: AppSvgs.editIcon,
          text: context.text.editProfile,
        ),
        IconTextTile(
          onClick: () {
            onOpenMyLists();
            DefaultBottomSheet.close(context);
          },
          leadingIcon: AppSvgs.playlistIcon,
          text: context.text.myLists,
        ),
        IconTextTile(
          onClick: () {
            onLogout();
            DefaultBottomSheet.close(context);
          },
          leadingIcon: AppSvgs.exitArrowIcon,
          text: context.text.logout,
        ),
        const SizedBox(height: 16)
      ],
    );
  }
}

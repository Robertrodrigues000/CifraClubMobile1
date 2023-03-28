import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User? user;
  final VoidCallback onLogoutTap;
  final VoidCallback onTap;

  const UserCard({super.key, this.user, required this.onLogoutTap, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.colors.neutralTertiary,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              RemoteImage(
                imageUrl: user?.avatarUrl,
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
                placeholder: SvgImage(
                    assetPath: AppSvgs.profilePlaceholderIcon,
                    height: 40,
                    width: 40,
                    color: context.colors.textPrimary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? context.text.login,
                      style: context.typography.subtitle2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user?.email ?? context.text.loginSubtitle,
                      style: context.typography.subtitle5,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (user != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Material(
                    child: InkWell(
                      onTap: onLogoutTap,
                      child: SvgImage(
                          assetPath: AppSvgs.logoutIcon, height: 24, width: 24, color: context.colors.textPrimary),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

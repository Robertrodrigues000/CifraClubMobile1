import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserCard extends StatefulWidget {
  final User? user;
  final VoidCallback onLogoutTap;
  final VoidCallback? onSync;
  final VoidCallback onTap;
  final bool isSyncing;

  const UserCard({
    super.key,
    this.user,
    required this.onLogoutTap,
    required this.onTap,
    this.onSync,
    this.isSyncing = false,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  void didUpdateWidget(covariant UserCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSyncing != widget.isSyncing) {
      // coverage:ignore-start
      if (widget.isSyncing) {
        _animationController.forward(from: 0);
      } else {
        _animationController.stop();
        _animationController.reset();
      }
      // coverage:ignore-end
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.colors.neutralTertiary,
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: context.appDimensionScheme.screenMargin),
              if ((widget.user?.avatarUrl ?? "").isEmpty)
                const _UserCardPlaceholder()
              else
                RemoteImage(
                  imageUrl: widget.user?.avatarUrl,
                  // coverage:ignore-start
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
                  // coverage:ignore-end
                  placeholder: const _UserCardPlaceholder(),
                ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.user?.name ?? context.text.login,
                      style: context.typography.subtitle2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.user?.email ?? context.text.loginSubtitle,
                      style: context.typography.subtitle5,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (widget.user != null) ...[
                const SizedBox(width: 4),
                if (widget.onSync != null)
                  ContainerWithRippleEffect(
                    onTap: widget.onSync!,
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: SvgImage(
                        assetPath: AppSvgs.refreshIcon,
                        height: 24,
                        width: 24,
                        color: context.colors.textSecondary,
                      ).animate(
                        autoPlay: false,
                        controller: _animationController,
                        effects: const [RotateEffect(duration: Duration(milliseconds: 1500))],
                        onComplete: (controller) => controller.repeat(),
                      ),
                    ),
                  ),
                ContainerWithRippleEffect(
                  onTap: widget.onLogoutTap,
                  height: 48,
                  width: 48,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Center(
                    child: SvgImage(
                      assetPath: AppSvgs.logoutIcon,
                      height: 24,
                      width: 24,
                      color: context.colors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(width: context.appDimensionScheme.rightPaddingCard),
              ] else
                SizedBox(width: context.appDimensionScheme.screenMargin),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserCardPlaceholder extends StatelessWidget {
  const _UserCardPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colors.neutralTertiary,
      ),
      child: SvgPicture.asset(
        AppSvgs.artistsAvatarPlaceHolder,
        color: context.colors.neutralQuaternary,
      ),
    );
  }
}

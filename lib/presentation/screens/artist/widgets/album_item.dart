import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/default_placeholder.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class AlbumItem extends StatefulWidget {
  final Album album;
  final VoidCallback onTap;
  final double size;
  const AlbumItem({
    super.key,
    required this.album,
    required this.onTap,
    required this.size,
  });

  @override
  State<AlbumItem> createState() => _AlbumItemState();
}

class _AlbumItemState extends State<AlbumItem> with SingleTickerProviderStateMixin {
  bool isPressing = false;
  final animationDurationMs = const Duration(milliseconds: 200);
  late final AnimationController fadeAnimationController = AnimationController(
    vsync: this,
    duration: animationDurationMs,
    upperBound: 0.2,
  );
  late final Animation<double> fadeAnimation = CurvedAnimation(
    parent: fadeAnimationController,
    curve: Curves.linear,
    reverseCurve: Curves.linear,
  );

  @override
  void initState() {
    super.initState();
    fadeAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed && !isPressing) {
          fadeAnimationController.reverse();
        }
      },
    );
  }

  @override
  void dispose() {
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = context.typography;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        isPressing = true;
        fadeAnimationController.forward();
      },
      onTapUp: (details) {
        // coverage:ignore-start
        isPressing = false;
        if (fadeAnimationController.isCompleted) {
          fadeAnimationController.reverse();
        } else {
          fadeAnimationController.value = 1;
        }
        // coverage:ignore-end
        widget.onTap();
      },
      // coverage:ignore-start
      onTapCancel: () {
        isPressing = false;
        if (fadeAnimationController.isCompleted) {
          fadeAnimationController.reverse();
        }
      },
      // coverage:ignore-end
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          AnimatedBuilder(
            animation: fadeAnimation,
            builder: (context, child) {
              return ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (rect) => LinearGradient(
                  colors: [
                    CosmosColors.white.withOpacity(fadeAnimation.value),
                    CosmosColors.white.withOpacity(fadeAnimation.value),
                  ],
                ).createShader(rect),
                child: child,
              );
            },
            child: RemoteImage(
              // coverage:ignore-start
              imageUrl: widget.album.image?.image,
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              // coverage:ignore-end
              placeholder: DefaultPlaceholder(
                height: widget.size,
                width: widget.size,
                svgIcon: AppSvgs.albumPlaceholder,
                isLarge: true,
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topLeft,
              color: context.colors.neutralPrimary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    widget.album.title,
                    style: styles.subtitle3,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${widget.album.totalSongs} ${context.text.songs(widget.album.totalSongs ?? 0)} • ${widget.album.releaseYear}",
                    style: styles.subtitle5,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

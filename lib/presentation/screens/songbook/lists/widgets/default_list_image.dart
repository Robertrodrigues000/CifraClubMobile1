import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class DefaultListImage extends StatelessWidget {
  const DefaultListImage({super.key, required this.image});
  final String? image;
  @override
  Widget build(BuildContext context) {
    if ((image ?? "").isEmpty) {
      return const _ListImagePlaceholder();
    }
    return RemoteImage(
      // coverage:ignore-start
      imageUrl: image,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: imageProvider),
        ),
      ),
      // coverage:ignore-end
      placeholder: const _ListImagePlaceholder(),
    );
  }
}

class _ListImagePlaceholder extends StatelessWidget {
  const _ListImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colors.neutralQuaternary,
        shape: BoxShape.circle,
      ),
      child: const SvgImage(
        assetPath: AppSvgs.playlistIcon,
        height: 22,
        width: 22,
        color: CosmosColors.white,
      ),
    );
  }
}

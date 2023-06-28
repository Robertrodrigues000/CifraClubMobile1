import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultListImage extends StatelessWidget {
  const DefaultListImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
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
      placeholder: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: CosmosColors.grey90,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            height: 22,
            width: 22,
            decoration: const BoxDecoration(
              color: CosmosColors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                AppSvgs.imagePlaceholder,
                fit: BoxFit.fill,
                height: 10,
                width: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

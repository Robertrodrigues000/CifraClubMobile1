// coverage:ignore-file
import 'package:cifraclub/domain/home/models/highlight.dart';
import 'package:cifraclub/presentation/constants/app_colors.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HighlightCard extends StatelessWidget {
  final double size;
  final double borderRadius;
  final double internalPadding;
  final Highlight highlight;

  const HighlightCard({
    super.key,
    required this.size,
    required this.highlight,
    required this.borderRadius,
    required this.internalPadding,
  });

  @override
  Widget build(BuildContext context) {
    final styles = CosmosTypography.of(context);

    return RemoteImage(
      imageUrl: highlight.images.large,
      placeholder: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            image: const DecorationImage(image: AssetImage(AppWebp.highlightPlaceholder), fit: BoxFit.cover)),
      ),
      imageBuilder: (context, imageProvider) => Container(
        padding: EdgeInsets.all(internalPadding),
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              highlight.title,
              style: styles.title4,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              highlight.subtitle,
              style: styles.title2.copyWith(color: CosmosColors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration:
                  BoxDecoration(color: CosmosColors.grey10.withOpacity(0.4), borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (highlight.icon.isNotEmpty)
                    ClipPath(
                      clipper: DescriptionClipper(),
                      child: Container(
                        height: 28,
                        padding: const EdgeInsets.only(left: 8, bottom: 6, top: 6, right: 8),
                        decoration: BoxDecoration(
                          color: AppColors.orangeMerigold.withOpacity(0.4),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                          ),
                        ),
                        child: Image.asset(
                          getBadge(highlight.icon),
                          fit: BoxFit.fill,
                          height: 16.0,
                          width: 16.0,
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Text(
                      highlight.description,
                      style: styles.subtitle6.copyWith(
                        color: CosmosColors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width - 8, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(DescriptionClipper oldClipper) => false;
}

String getBadge(String name) {
  switch (name) {
    case 'violao':
      return AppWebp.acousticGuitarBadge;
    case 'baixo':
      return AppWebp.bassBadge;
    case 'cavaco':
      return AppWebp.cavacoBadge;
    case 'guitarra':
      return AppWebp.guitarBadge;
    default:
      return AppWebp.acousticGuitarBadge;
  }
}

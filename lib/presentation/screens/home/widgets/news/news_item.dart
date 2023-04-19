import 'package:cifraclub/domain/home/models/news.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.news, required this.onTap});
  final News news;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final typography = context.typography;
    return ContainerWithRippleEffect(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.appDimensionScheme.screenMargin,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.appDimensionScheme.newsItemThumbPadding),
              child: RemoteImage(
                // coverage:ignore-start
                imageUrl: news.image,
                imageBuilder: (context, imageProvider) => Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                // coverage:ignore-end
                placeholder: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: CosmosColors.grey90,
                  ),
                  child: Center(
                    child: Container(
                      height: 56,
                      width: 56,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: CosmosColors.white,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppSvgs.newsPlaceholder,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: context.appDimensionScheme.newsItemTextPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      news.headline,
                      style: typography.subtitle2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

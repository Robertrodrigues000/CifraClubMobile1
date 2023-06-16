import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/color.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/home/widgets/list_animation.dart';
import 'package:cifraclub/presentation/widgets/color_approximator.dart';
import 'package:cifraclub/presentation/widgets/container_with_ripple_effect.dart';
import 'package:cifraclub/presentation/widgets/pick_shaped_image.dart';
import 'package:cifraclub/presentation/widgets/remote_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTopArtists extends StatelessWidget {
  const HomeTopArtists({super.key = const Key("home top artists"), required this.artists, required this.onTap});

  final List<Artist> artists;
  final Function(Artist) onTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.all(context.appDimensionScheme.screenMargin),
      sliver: AnimationLimiter(
        child: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.appDimensionScheme.topArtistsItemsPerRow,
            crossAxisSpacing: context.appDimensionScheme.internalMargin,
            mainAxisSpacing: context.appDimensionScheme.internalMargin,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: artists.length,
            (context, index) => AnimationConfiguration.staggeredGrid(
              duration: ListAnimation.duration,
              position: index,
              columnCount: context.appDimensionScheme.topArtistsItemsPerRow,
              child: ListAnimation(child: _ArtistCard(artists[index], onTap)),
            ),
          ),
        ),
      ),
    );
  }
}

class _ArtistCard extends StatelessWidget {
  const _ArtistCard(this._artist, this._onTap);
  final Artist _artist;
  final Function(Artist) _onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: ContainerWithRippleEffect(
        onTap: () => _onTap(_artist),
        child: Stack(
          children: [
            RemoteImage(
              // coverage:ignore-start
              imageUrl: _artist.image?.size250 ?? "",
              imageBuilder: (context, imageProvider) => ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    CosmosColors.black.withOpacity(1),
                    CosmosColors.black.withOpacity(0),
                  ],
                ).createShader(bounds),
                blendMode: BlendMode.srcOver,
                child: Container(
                  key: const Key("Artists image"),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
              ),
              // coverage:ignore-end
              placeholder: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    CosmosColors.black.withOpacity(1),
                    CosmosColors.black.withOpacity(0),
                  ],
                ).createShader(bounds),
                blendMode: BlendMode.srcOver,
                child: Container(
                  key: const Key("Artists placeholder"),
                  color: CosmosColors.grey90,
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(context.appDimensionScheme.internalMargin),
                        child: PickShapeImage(
                          size: 56,
                          backgroundColor: Colors.white,
                          child: SvgPicture.asset(AppSvgs.artistsAvatarPlaceHolder),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 4,
                color: ColorApproximator.of(context).getNearestColor(
                  context,
                  HexColor.fromHex(_artist.image?.color ?? ""),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(context.appDimensionScheme.internalMargin),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _artist.name,
                      style: context.typography.subtitle4.copyWith(color: CosmosColors.grey80),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _artist.genre?.name ?? "",
                      style: context.typography.subtitle4.copyWith(color: CosmosColors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

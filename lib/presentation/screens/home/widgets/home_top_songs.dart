import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/home/widgets/list_animation.dart';
import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTopSongs extends StatefulWidget {
  const HomeTopSongs({
    super.key = const Key("top songs"),
    required this.topSongs,
    required this.onTap,
  });

  final List<Song> topSongs;
  final Function(Song) onTap;

  @override
  State<HomeTopSongs> createState() => _HomeTopSongsState();
}

class _HomeTopSongsState extends State<HomeTopSongs> {
  late double textHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textHeight = context.typography.subtitle3.getTextSize(context: context).height;
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: context.appDimensionScheme.screenMargin),
      sliver: AnimationLimiter(
        child: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.appDimensionScheme.topSongsItemsPerRow,
            mainAxisExtent: (2 * textHeight) + 32,
          ),
          delegate: SliverChildBuilderDelegate(
            childCount: widget.topSongs.length,
            (context, index) {
              final song = widget.topSongs[index];
              return AnimationConfiguration.staggeredGrid(
                duration: ListAnimation.duration,
                columnCount: context.appDimensionScheme.topSongsItemsPerRow,
                position: index,
                child: SlideAnimation(
                  verticalOffset: 75,
                  child: FadeInAnimation(
                    curve: Curves.linear,
                    child: TopListItem(
                      key: Key(song.name),
                      onTap: () => widget.onTap(song),
                      title: song.name,
                      imageUrl: song.artist?.image?.size162,
                      subtitle: song.artist?.name,
                      trailing: song.isVerified ? SvgPicture.asset(AppSvgs.verifiedIcon) : null,
                      ranking: (index + 1).toString(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

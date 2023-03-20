import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTopCifras extends StatelessWidget {
  const HomeTopCifras({
    super.key = const Key("top cifras"),
    required this.topSongs,
    required this.onTap,
  });

  final List<Song> topSongs;
  final Function(Song) onTap;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: context.appDimensionScheme.screenMargin),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: context.appDimensionScheme.topCifrasItemsPerRow,
          mainAxisExtent: 72,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: topSongs.length,
          (context, index) {
            final song = topSongs[index];
            return TopListItem(
              key: Key(song.name),
              onTap: () => onTap(song),
              title: song.name,
              imageUrl: song.artist?.image?.size162,
              subtitle: song.artist?.name,
              trailing: song.isVerified ? SvgPicture.asset(AppSvgs.verifiedIcon) : null,
              ranking: (index + 1).toString(),
            );
          },
        ),
      ),
    );
  }
}

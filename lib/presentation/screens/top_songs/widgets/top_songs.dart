import 'package:cifraclub/domain/song/models/song.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopSongs extends StatelessWidget {
  final List<Song> topSongs;
  final Function(Song) onTap;
  final String selectedGenre;
  const TopSongs({super.key, required this.topSongs, required this.onTap, required this.selectedGenre});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: topSongs.length + 1,
        (context, index) {
          if (index >= topSongs.length) {
            return Container(
              height: context.appDimensionScheme.scrollContentToBottom,
            );
          }
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
    );
  }
}

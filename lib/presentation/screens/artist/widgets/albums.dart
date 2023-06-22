import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/album_item.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';

class Albums extends StatefulWidget {
  final List<Album> albums;

  const Albums({
    super.key = const Key("albums"),
    required this.albums,
  });

  @override
  State<Albums> createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  late double textHeight;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textHeight = context.typography.subtitle3.getTextSize(context: context).height +
        context.typography.subtitle5.getTextSize(context: context).height;
  }

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;
    final width = MediaQuery.of(context).size.width;
    //this calculus is to make the cards occupy the same space in the screen.
    final imageSize = (width - (dimensions.albumsPerRow + 1) * dimensions.screenMargin) / dimensions.albumsPerRow;
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: dimensions.screenMargin),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: dimensions.albumsPerRow,
          crossAxisSpacing: dimensions.screenMargin,
          mainAxisSpacing: dimensions.screenMargin,
          mainAxisExtent: textHeight + imageSize + 18,
        ),
        delegate: SliverChildBuilderDelegate(
          childCount: widget.albums.length,
          (context, index) {
            return AlbumItem(
              key: Key(widget.albums[index].albumUrl),
              album: widget.albums[index],
              // coverage:ignore-start
              onTap: () {},
              // coverage:ignore-end
              size: imageSize,
            );
          },
        ),
      ),
    );
  }
}

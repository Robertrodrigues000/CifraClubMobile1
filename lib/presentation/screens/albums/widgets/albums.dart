import 'package:cifraclub/domain/artist/models/album.dart';
import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/extensions/text_style.dart';
import 'package:cifraclub/presentation/screens/album/album_entry.dart';
import 'package:cifraclub/presentation/screens/albums/widgets/album_item.dart';
import 'package:flutter/material.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:nav/nav.dart';

class Albums extends StatefulWidget {
  final List<Album>? albums;
  final List<SearchItem>? searchItems;

  const Albums({
    super.key = const Key("albums"),
    this.albums,
    this.searchItems,
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
        delegate: widget.albums != null
            ? SliverChildBuilderDelegate(
                childCount: widget.albums!.length,
                (context, index) {
                  final album = widget.albums![index];
                  return AlbumItem(
                    key: Key(album.albumUrl),
                    title: album.title,
                    subtitle: "${album.totalSongs} ${context.text.songs(album.totalSongs ?? 0)} • ${album.releaseYear}",
                    cover: album.image?.image,
                    // coverage:ignore-start
                    onTap: () => AlbumEntry.push(Nav.of(context), album.artistUrl, album.albumUrl),
                    // coverage:ignore-end
                    size: imageSize,
                  );
                },
              )
            : SliverChildBuilderDelegate(
                childCount: widget.searchItems!.length,
                (context, index) {
                  final searchAlbum = widget.searchItems![index];
                  if (searchAlbum is AlbumSearch) {
                    return AlbumItem(
                      key: Key(searchAlbum.albumUrl),
                      title: searchAlbum.albumName,
                      subtitle: searchAlbum.artistName,
                      cover: searchAlbum.albumCover,
                      // coverage:ignore-start
                      onTap: () => AlbumEntry.push(Nav.of(context), searchAlbum.artistUrl, searchAlbum.albumUrl),
                      // coverage:ignore-end
                      size: imageSize,
                    );
                  }
                  return null;
                },
              ),
      ),
    );
  }
}

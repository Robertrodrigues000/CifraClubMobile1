import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

class SongsByMostAccessedTab extends StatelessWidget {
  const SongsByMostAccessedTab(
      {super.key,
      required this.songsFilteredBySearch,
      this.songsError,
      required this.onTapReload,
      required this.isLoading,
      required this.onTapVersion,
      required this.onTapVersionOptions,
      required this.hasVideoLesson,
      required this.rankingPrefixes});
  final List<ArtistSong> songsFilteredBySearch;
  final RequestError? songsError;
  final VoidCallback onTapReload;
  final bool isLoading;
  final Function(ArtistSong) onTapVersion;
  final Function(ArtistSong) onTapVersionOptions;
  final List<String> rankingPrefixes;
  final Function(ArtistSong) hasVideoLesson;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (context) {
        return CustomScrollView(
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            if (songsError != null)
              SliverFillRemaining(
                child: Center(
                  child: SingleChildScrollView(
                    child: ErrorDescriptionWidget(
                      typeError: songsError! is ConnectionError
                          ? ErrorDescriptionWidgetType.connection
                          : ErrorDescriptionWidgetType.server,
                      onClick: onTapReload,
                    ),
                  ),
                ),
              )
            else if (isLoading)
              const SliverFillRemaining(child: Center(child: LoadingIndicator()))
            else if (songsFilteredBySearch.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: songsFilteredBySearch.length,
                  (context, index) {
                    final song = songsFilteredBySearch[index];
                    return ArtistSongItem(
                        onTap: () => onTapVersion(song),
                        onOptionsTap: () => onTapVersionOptions(song),
                        name: song.name,
                        prefix: rankingPrefixes[index],
                        isVerified: song.verified,
                        hasVideoLessons: hasVideoLesson(song));
                  },
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.only(top: context.appDimensionScheme.artistSongsHeaderSpace),
                sliver: const SliverToBoxAdapter(
                  child: ErrorDescriptionWidget(
                    typeError: ErrorDescriptionWidgetType.resultNotFound,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

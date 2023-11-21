import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:collection/collection.dart';
import 'package:cosmos/cosmos.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

class SongsByAlphabeticalOrderTab extends StatelessWidget {
  const SongsByAlphabeticalOrderTab(
      {super.key,
      required this.songsFilteredBySearch,
      this.songsError,
      required this.onTapReload,
      required this.isLoading,
      required this.onTapVersion,
      required this.onTapVersionOptions,
      required this.alphabeticalPrefixes,
      required this.hasVideoLesson});
  final List<ArtistSong> songsFilteredBySearch;
  final RequestError? songsError;
  final VoidCallback onTapReload;
  final bool isLoading;
  final Function(ArtistSong) onTapVersion;
  final Function(ArtistSong) onTapVersionOptions;
  final List<String> alphabeticalPrefixes;
  final Function(ArtistSong) hasVideoLesson;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (context) {
        final alphabeticalSongs = songsFilteredBySearch.sortedBy((a) => removeDiacritics(a.name).toLowerCase());
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
            else if (alphabeticalSongs.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: alphabeticalSongs.length,
                  (context, index) {
                    final song = alphabeticalSongs[index];
                    return ArtistSongItem(
                        // coverage:ignore-start
                        onTap: () => onTapVersion(song),
                        onOptionsTap: () => onTapVersionOptions(song),
                        // coverage:ignore-end
                        name: song.name,
                        prefix: alphabeticalPrefixes[index],
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

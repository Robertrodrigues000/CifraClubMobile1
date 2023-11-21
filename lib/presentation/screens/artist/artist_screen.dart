import 'package:cifraclub/domain/artist/models/artist_song.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/screens/albums/albums_entry.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_event.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_title.dart';
import 'package:cifraclub/presentation/screens/albums/widgets/albums.dart';
import 'package:cifraclub/presentation/screens/artist_songs/artist_songs_entry.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/shared/on_context_ready.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';
import 'package:rxdart/rxdart.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key, required this.versionOptionsBottomSheet});
  final VersionOptionsBottomSheet versionOptionsBottomSheet;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> with SubscriptionHolder, OnContextReady {
  late final ArtistBloc _bloc = BlocProvider.of<ArtistBloc>(context);
  final _scrollController = ScrollController();
  static const maxSongs = 10;
  static const maxAlbums = 4;

  @override
  void onContextReady(BuildContext context) {
    _bloc.artistEventStream.listen((event) {
      switch (event) {
        case FavoriteError():
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: event.error is ServerError
                    ? Text(context.text.serverErrorDescription)
                    : Text(context.text.connectionErrorDescription)),
          );
      }
    }).addTo(subscriptions);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    disposeAll();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(
      bloc: _bloc,
      builder: (_, state) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              ArtistHeader(
                scrollController: _scrollController,
                maxOffset: context.appDimensionScheme.artistHeaderHeight - context.appDimensionScheme.appBarHeight,
                isLoading: state.isLoading,
                isFavorite: state.isFavorite,
                onFavorite: () {
                  if (state.user != null) {
                    _bloc.onFavorite();
                  } else {
                    _bloc.openLoginPage();
                  }
                },
                onShare: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                  final link = AppUrls.artistUrlFormat(state.artistInfo?.url ?? "");
                  await _bloc.shareLink(link, rect);
                },
                genreName: state.artistInfo?.genre.name ?? "",
                artistName: state.artistInfo?.name ?? "",
                image: state.artistInfo?.headImageDto?.image ?? state.artistInfo?.imagesDto?.size250 ?? "",
                color: state.artistInfo?.headImageDto?.color ?? state.artistInfo?.imagesDto?.color ?? "",
              ),
              if (state.isLoading)
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: context.appDimensionScheme.screenMargin,
                      ),
                      const Center(child: CircularProgressIndicator())
                    ],
                  ),
                )
              else if (state.error != null)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      ErrorDescriptionWidget(
                        typeError: state.error is ConnectionError
                            ? ErrorDescriptionWidgetType.connection
                            : ErrorDescriptionWidgetType.server,
                        // coverage:ignore-start
                        onClick: () => _bloc.fetchArtistInfo(),
                        // coverage:ignore-end
                      ),
                    ],
                  ),
                )
              else ...[
                SliverToBoxAdapter(
                  child: FilterCapsuleList(
                    capsulePadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: context.appDimensionScheme.screenMargin,
                    ),
                    filters: [
                      Filter(
                        label: context.text.all,
                        onTap: () => _bloc.onInstrumentSelected(null),
                        isSelected: state.selectedInstrument == null,
                      ),
                      ...state.instruments
                          .map((instrument) => Filter(
                                label: instrument.getInstrumentName(context),
                                onTap: () => _bloc.onInstrumentSelected(instrument),
                                isSelected: instrument == state.selectedInstrument,
                              ))
                          .toList()
                    ],
                  ),
                ),
                ArtistSectionTitle(
                  title: context.text.mostAccessed,
                  bottom: context.appDimensionScheme.screenMargin,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.songs.take(maxSongs).length,
                    (_, index) => ArtistSongItem(
                      onTap: () {
                        VersionEntry.pushFromSong(
                          Nav.of(context),
                          state.artistInfo?.url ?? "",
                          state.songs[index].url,
                          state.artistInfo?.name ?? "",
                          state.songs[index].name,
                        );
                      },
                      onOptionsTap: () async {
                        await widget.versionOptionsBottomSheet.show(
                          context: context,
                          artistUrl: state.artistInfo?.url ?? "",
                          songUrl: state.songs[index].url,
                          songId: state.songs[index].id,
                        );
                      },
                      name: state.songs[index].name,
                      prefix: (index + 1).toString(),
                      isVerified: state.songs[index].verified,
                      hasVideoLessons: _hasInstrumentVideoLesson(
                        state.selectedInstrument,
                        state.songs[index],
                      ),
                    ),
                  ),
                ),
                if (state.songs.length > maxSongs && state.artistInfo != null)
                  SliverToBoxAdapter(
                    child: CifraClubButton(
                      type: ButtonType.outline,
                      // coverage:ignore-start
                      onPressed: () => ArtistSongsEntry.push(Nav.of(context), state.artistInfo!.url,
                          state.selectedInstrument?.name ?? "", state.artistInfo!.name),
                      // coverage:ignore-end
                      padding: EdgeInsets.only(
                        left: context.appDimensionScheme.screenMargin,
                        right: context.appDimensionScheme.screenMargin,
                        top: 16,
                        bottom: 32,
                      ),
                      child: Text(context.text.artistMoreSongs),
                    ),
                  ),
                if (state.albums.isNotEmpty) ...[
                  ArtistSectionTitle(
                    title: context.text.albums,
                    bottom: context.appDimensionScheme.screenMargin,
                  ),
                  Albums(albums: state.albums.take(maxAlbums).toList()),
                  if (state.albums.length > maxAlbums)
                    SliverToBoxAdapter(
                      child: CifraClubButton(
                        type: ButtonType.outline,
                        // coverage:ignore-start
                        onPressed: () => AlbumsEntry.push(Nav.of(context), state.artistInfo!.url,
                            state.artistInfo!.name, state.albums.length.toString()),
                        // coverage:ignore-end
                        padding: EdgeInsets.only(
                          left: context.appDimensionScheme.screenMargin,
                          right: context.appDimensionScheme.screenMargin,
                          top: context.appDimensionScheme.screenMargin,
                          bottom: 32,
                        ),
                        child: Text(context.text.moreAlbums),
                      ),
                    )
                ],
              ]
            ],
          ),
        );
      },
    );
  }

  bool _hasInstrumentVideoLesson(Instrument? instrument, ArtistSong song) {
    if (instrument == null && song.videoLessons > 0) {
      return true;
    } else {
      return song.videoLessonsInstruments?.contains(instrument) ?? false;
    }
  }
}

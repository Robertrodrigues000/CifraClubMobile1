// coverage:ignore-file
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/albums/albums_entry.dart';
import 'package:cifraclub/presentation/screens/artist/artist_bloc.dart';
import 'package:cifraclub/presentation/screens/artist/artist_state.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_header.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_title.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';

class ArtistScreen extends StatefulWidget {
  const ArtistScreen({super.key, required this.name});
  final String name;
  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  late ArtistBloc _bloc;
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ArtistBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistState>(
      bloc: _bloc,
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              ArtistHeader(
                scrollController: _scrollController,
                maxOffset: context.appDimensionScheme.artistHeaderHeight - 56,
                isLoading: _bloc.state.isLoading,
                onFavorite: () {},
                onShare: () {},
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
                        onClick: () => _bloc.init(),
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
                    childCount: state.songs.length,
                    (context, index) => ArtistSongItem(
                      onTap: () {},
                      onOptionsTap: () {},
                      name: state.songs[index].name,
                      ranking: index + 1,
                      isVerified: state.songs[index].verified,
                      hasVideoLessons: state.songs[index].videoLessons > 0,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CifraClubButton(
                    type: ButtonType.outline,
                    // coverage:ignore-start
                    onPressed: () {},
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
                  Albums(albums: state.albums.take(4).toList()),
                  SliverToBoxAdapter(
                    child: CifraClubButton(
                      type: ButtonType.outline,
                      // coverage:ignore-start
                      onPressed: () => Nav.of(context).push(screenName: AlbumsEntry.name, params: {
                        'url': state.artistInfo!.url,
                        'name': state.artistInfo!.name,
                        'totalAlbums': state.albums.length.toString(),
                      }),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

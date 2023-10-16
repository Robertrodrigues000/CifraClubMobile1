// coverage:ignore-file
import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/version/models/musical_scale.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/instruments_versions_bottom_sheet/instruments_versions_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_key_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_widget.dart';
import 'package:cifraclub/presentation/screens/version/widgets/version_header.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nav/nav.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VersionScreen extends StatefulWidget {
  final ListenBottomSheet listenBottomSheet;
  final VersionOptionsBottomSheet versionOptionsBottomSheet;

  const VersionScreen(
    this.listenBottomSheet, {
    super.key,
    required this.versionOptionsBottomSheet,
  });

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> with SubscriptionHolder {
  late final _bloc = BlocProvider.of<VersionBloc>(context);
  final _scrollController = TrackingScrollController();
  var isFooterBarVisible = true;
  var isUserDraggingScreen = false;
  String? selectedKey; // Todo: remover isso aqui quando transpose estiver funcionando

  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);

    _bloc.versionEffectStream.listen((effect) async {
      switch (effect) {
        case OnShowYouTubeVideo():
          if (_youtubePlayerController == null) {
            _youtubePlayerController = YoutubePlayerController(
              params: const YoutubePlayerParams(
                mute: false,
                showControls: true,
                showFullscreenButton: true,
              ),
            );
            await _youtubePlayerController?.loadVideoById(videoId: effect.videoId);
          }

        case OnCloseYouTubeVideo():
          await _youtubePlayerController?.close();
          _youtubePlayerController = null;
        case OnAutoScrollTickEffect():
          if (isUserDraggingScreen) {
            return;
          }
          _scrollController.animateTo(
            _scrollController.offset + effect.delta,
            duration: const Duration(milliseconds: 20),
            curve: Curves.linear,
          );
      }
    }).addTo(subscriptions);
  }

  void onScroll() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      _bloc.add(OnAutoScrollStop());
    }
    final currentOffset = _scrollController.offset;
    final previousOffset = _scrollController.initialScrollOffset;
    final currentIsFooterBarVisible = currentOffset < previousOffset;

    if (!_bloc.state.autoScrollState.isAutoScrollRunning && currentIsFooterBarVisible != isFooterBarVisible) {
      setState(() {
        isFooterBarVisible = currentIsFooterBarVisible;
      });
    }
  }

  @override
  void dispose() {
    disposeAll();
    _youtubePlayerController?.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VersionBloc, VersionState>(
      builder: (context, state) {
        selectedKey ??= state.version?.stdKey; // Todo: remover isso aqui quando transpose estiver funcionando
        return Scaffold(
          appBar: CosmosAppBar(
            actions: [
              TextButton(
                onPressed: () => _bloc.add(OnToggleIsChordPinned()),
                child: Text(
                  state.isChordListPinned ? context.text.hideChords : context.text.fixChords,
                  style: context.typography.body9.copyWith(letterSpacing: 0),
                ),
              ),
            ],
          ),
          body: Listener(
            onPointerDown: (_) {
              isUserDraggingScreen = true;
            },
            onPointerUp: (_) {
              isUserDraggingScreen = false;
            },
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    if (state.isYouTubeVisible && _youtubePlayerController != null)
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: YouTubeHeaderDelegate(
                          MediaQuery.sizeOf(context).width * 9 / 16,
                          _youtubePlayerController!,
                        ),
                      ),
                    SliverToBoxAdapter(
                      child: VersionHeader(
                        songName: state.versionHeaderState.songName,
                        artistName: state.versionHeaderState.artistName,
                        isFavorite: state.versionHeaderState.isFavorite,
                        onTapFavoriteIcon: () {/*TODO*/},
                        onTapArtistName: () => ArtistEntry.push(Nav.of(context), state.versionHeaderState.artistUrl),
                        onTapOptionsIcon: () async {
                          await widget.versionOptionsBottomSheet.show(
                            context: context,
                            artistUrl: state.versionHeaderState.artistUrl,
                            songUrl: state.versionHeaderState.songUrl,
                            songId: state.version!.song.songId,
                          );
                        },
                        filters: state.versionHeaderState.versionFilters,
                        selectedFilter: state.versionHeaderState.selectedVersionFilter,
                        onTapFilter: (filter) => _bloc.add(OnVersionSelected(filter)),
                        onTapMoreFilters: () {
                          if (state.version != null) {
                            InstrumentVersionsBottomSheet.show(
                              context,
                              state.version!.instrumentVersions ?? [],
                              state.version!.instrument,
                              state.version!.versionName,
                              (versionFilter) {
                                _bloc.add(OnVersionSelected(versionFilter));
                              },
                            );
                          }
                        },
                      ),
                    ),
                    if (state.isLoading)
                      const SliverFillRemaining(
                        child: Center(
                          child: LoadingIndicator(),
                        ),
                      )
                    else ...[
                      SliverPersistentHeader(
                        pinned: state.isChordListPinned,
                        delegate: ChordListHeaderDelegate(
                          haveScroll: false,
                          maxExtend: 110,
                          child: const Text("Acordes"),
                          isPinned: state.isChordListPinned,
                          chords: state.chordState.chordRepresentations,
                        ),
                      ),
                      SliverList.builder(
                        itemCount: state.sections.length,
                        itemBuilder: (context, index) {
                          final section = state.sections[index];
                          return Text.rich(
                            TextSpan(children: section.getSpans()),
                            style: context.typography.body8,
                          );
                        },
                      ),
                    ],
                  ],
                ),
                AnimatedPositioned(
                  bottom: isFooterBarVisible ? 0 : -32,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    height: 32,
                    width: 300,
                    color: Colors.amber,
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              _bloc.add(
                                  state.autoScrollState.isAutoScrollRunning ? OnAutoScrollStop() : OnAutoScrollStart());
                            },
                            child: const Icon(Icons.video_chat)),
                        TextButton(
                            onPressed: () {
                              widget.listenBottomSheet.open(
                                context: context,
                                artistName: state.version?.artist?.name ?? "",
                                songName: state.version?.song.name ?? "",
                              );
                            },
                            child: const Icon(Icons.arrow_outward)),
                        TextButton(
                            onPressed: () async {
                              var newKey = await VersionKeyBottomSheet(
                                musicalScale: state.version!.stdKey!.contains("m")
                                    ? MusicalScale.minorScale
                                    : MusicalScale.majorScale,
                                originalKey: state.version!.stdKey!,
                                selectedKey: selectedKey!,
                              ).open(
                                context: context,
                              );
                              if (newKey != null) {
                                setState(() {
                                  selectedKey = newKey;
                                });
                              }
                            },
                            child: const Icon(Icons.settings)),
                        TextButton(
                            onPressed: () {
                              state.isYouTubeVisible
                                  ? _bloc.add(OnYouTubeVideoClosed())
                                  : _bloc.add(
                                      OnYouTubeVideoSelected(state.version?.videoLesson?.youtubeId ?? "Pt9elq3DYNM"),
                                    );
                            },
                            child: const Icon(Icons.youtube_searched_for_outlined))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// https://pub.dev/packages/youtube_player_iframe
class YouTubeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final YoutubePlayerController controller;

  YouTubeHeaderDelegate(this.height, this.controller);

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return YoutubePlayerScaffold(
      controller: controller,
      builder: (context, player) {
        return player;
      },
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! YouTubeHeaderDelegate ||
        oldDelegate.height != height ||
        oldDelegate.controller != controller;
  }
}

class ChordListHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final Widget child;
  final bool haveScroll;
  final bool isPinned;
  final List<ChordRepresentation> chords;

  ChordListHeaderDelegate({
    required this.maxExtend,
    required this.child,
    required this.haveScroll,
    required this.isPinned,
    required this.chords,
  });

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => isPinned ? maxExtend : 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      reverse: true,
      child: Container(
        color: context.colors.neutralPrimary,
        height: maxExtend,
        child: ListView.builder(
          itemCount: chords.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final chord = chords[index];
            return Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 12),
              child: ChordWidget(
                  chordRepresentation: chord,
                  chordUiSettings: ChordUISettings.guitar().scaledToFit(height: maxExtend - 16),
                  isLeftHanded: false),
            );
          },
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! ChordListHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child ||
        oldDelegate.chords != chords;
  }
}

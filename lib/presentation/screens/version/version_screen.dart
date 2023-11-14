// coverage:ignore-file

import 'package:cifraclub/domain/chord/models/chord_representation.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/instruments_versions_bottom_sheet/instruments_versions_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/bottom_sheets/chord_shape_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_ui_settings.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord/chord_widget.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:cifraclub/presentation/screens/version/widgets/version_header.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visibility_detector/visibility_detector.dart';
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
            duration: const Duration(milliseconds: 110),
            curve: Curves.linear,
          );
        case OnShowListenBottomSheetEffect():
          if (context.mounted) {
            widget.listenBottomSheet.open(
              context: context,
              artistName: _bloc.state.version?.artist?.name ?? "",
              songName: _bloc.state.version?.song.name ?? "",
            );
          }
        case OnShowOptionsBottomSheetEffect():
          if (context.mounted) {
            widget.versionOptionsBottomSheet.show(
                context: context,
                artistUrl: _bloc.state.versionHeaderState.artistUrl,
                songUrl: _bloc.state.versionHeaderState.songUrl,
                songId: _bloc.state.version!.song.songId,
                isVersionBottomSheet: true,
                versionData: _bloc.state.version!,
                isPro: false,
                onAction: (action) {
                  _bloc.add(OnVersionOptionsAction(action: action));
                });
          }
        case OnShowSelectVersionBottomSheetEffect():
          if (context.mounted) {
            InstrumentVersionsBottomSheet.show(
              context,
              _bloc.state.version!.instrumentVersions ?? [],
              _bloc.state.version!.instrument,
              _bloc.state.version!.versionName,
              (versionSelected) {
                _bloc.add(OnVersionSelected(versionSelected));
              },
            );
          }
        case OnShowChordShapeBottomSheetEffect():
          if (context.mounted) {
            ChordShapeBottomSheet.show(
              context,
              effect.selectedChord,
              effect.chords,
              Instrument.guitar,
              (chord) => _bloc.add(OnChordShapeChange(chord: chord)),
            );
          }
        case OnFavoriteError():
          if (!context.mounted) {
            break;
          }
          switch (effect.haveError) {
            case FavoriteVersionError():
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(context.text.favoriteVersionErrorMessage)));
            case UnFavoriteVersionError():
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(context.text.unFavoriteVersionErrorMessage)));
            default:
              break;
          }
        case OnChangeVersionKeyEffect():
          setState(() {
            selectedKey = effect.newKey;
          });
        case OnShowFontSizeFooterBarEffect():
          _bloc.add(OnFloatingFooterBarAction(action: FloatingFooterBarDidTapOnResetFontSize()));
        case OnShowTuningBottomSheetEffect():
        case OnShowCapoBottomSheetEffect():
      }
    }).addTo(subscriptions);
  }

  void onScroll() {
    final currentOffset = _scrollController.offset;
    if (currentOffset >= _scrollController.position.maxScrollExtent) {
      _bloc.add(OnAutoScrollStop());
      return;
    }
    if (currentOffset <= 0) {
      return;
    }

    final previousOffset = _scrollController.initialScrollOffset;
    final currentIsFooterBarVisible = currentOffset < previousOffset;

    if (isUserDraggingScreen && currentIsFooterBarVisible != isFooterBarVisible) {
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
        return VisibilityDetector(
          key: const Key("version_screen_visibility"),
          onVisibilityChanged: (info) {
            final visiblePercentage = info.visibleFraction * 100;

            if (visiblePercentage < 1 && _youtubePlayerController != null) {
              _youtubePlayerController!.pauseVideo();
            }
          },
          child: Scaffold(
            appBar: CosmosAppBar(
              automaticallyImplyLeading: false,
              leading: Padding(
                padding: EdgeInsets.only(left: context.appDimensionScheme.appBarMargin),
                child: InkWell(
                  onTap: () => Nav.of(context).pop(), // coverage:ignore-line
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: SvgPicture.asset(
                      AppSvgs.backArrowIcon,
                      fit: BoxFit.none,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _bloc.add(OnToggleIsChordPinned());
                  },
                  child: Text(
                    state.isChordListPinned ? context.text.hideChords : context.text.fixChords,
                    style: context.typography.body9,
                  ),
                ),
              ],
            ),
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Listener(
                  onPointerDown: (_) {
                    isUserDraggingScreen = true;
                  },
                  onPointerUp: (_) {
                    isUserDraggingScreen = false;
                  },
                  child: CustomScrollView(
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
                          onTapFavoriteIcon: () {
                            _bloc.add(OnTapFavoriteButton());
                          },
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
                            onTap: (chord) {
                              _bloc.add(
                                OnChordTap(
                                  selectedChord: chord,
                                  instrument: state.version!.instrument,
                                ),
                              );
                            },
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
                      const SliverFillRemaining(),
                    ],
                  ),
                ),
                FloatingFooterBar(
                  mode: state.floatingFooterBarState.mode,
                  isVisible: isFooterBarVisible,
                  isAutoScrollRunning: state.autoScrollState.isAutoScrollRunning,
                  autoScrollSpeedFactor: state.autoScrollState.speedFactor,
                  isVideoOpen: state.isYouTubeVisible,
                  videoThumb: state.version?.videoLesson?.thumb,
                  onAction: (action) {
                    _bloc.add(OnFloatingFooterBarAction(action: action));
                  },
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
  final Function(ChordRepresentation chord) onTap;
  final List<ChordRepresentation> chords;

  ChordListHeaderDelegate({
    required this.maxExtend,
    required this.child,
    required this.haveScroll,
    required this.isPinned,
    required this.chords,
    required this.onTap,
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
            return InkWell(
              onTap: () => onTap(chord),
              child: Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 12),
                child: ChordWidget(
                    chordRepresentation: chord,
                    chordUiSettings: ChordUISettings.guitar().scaledToFit(height: maxExtend - 16),
                    isLeftHanded: false),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

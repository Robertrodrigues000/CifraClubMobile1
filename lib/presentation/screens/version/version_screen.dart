// coverage:ignore-file

import 'dart:async';
import 'package:cifraclub/data/song/song_player_manager.dart';
import 'package:cifraclub/domain/songbook/models/email_options_result.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/instruments_versions_bottom_sheet/instruments_versions_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/version/models/player_action.dart';
import 'package:cifraclub/presentation/screens/version/widgets/audio_player.dart';
import 'package:cifraclub/presentation/bottom_sheets/version_options_bottom_sheet/version_options_bottom_sheet.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/dialogs/incompatible_version_dialog.dart';
import 'package:cifraclub/presentation/dialogs/confirm_register_dialog.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/bottom_sheets/chord_shape_bottom_sheet.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_effect.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/screens/version/widgets/blocked_content.dart';
import 'package:cifraclub/presentation/screens/version/widgets/chord_list_header.dart';
import 'package:cifraclub/presentation/shared/on_context_ready.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar.dart';
import 'package:cifraclub/presentation/widgets/floating_footer_bar/floating_footer_bar_action.dart';
import 'package:cifraclub/presentation/screens/version/widgets/version_header.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _VersionScreenState extends State<VersionScreen> with SubscriptionHolder, OnContextReady, WidgetsBindingObserver {
  late final _bloc = BlocProvider.of<VersionBloc>(context);
  final _scrollController = TrackingScrollController();
  var isYoutubeFullScreen = false;
  var isFooterBarVisible = true;
  var isUserTouchingScreen = false;
  var isUserDragingScreen = false;
  Timer? timerToHideFooterBar;
  String? selectedKey; // Todo: remover isso aqui quando transpose estiver funcionando
  late final YoutubePlayerController _youtubePlayerController = YoutubePlayerController(
    params: const YoutubePlayerParams(
      mute: false,
      showControls: true,
      showFullscreenButton: true,
      loop: false,
    ),
  );
  late Orientation _orientation = MediaQuery.of(context).orientation;

  void _startTimerToHideAutoScrollFooterBar() {
    if (!_bloc.state.autoScrollState.isAutoScrollRunning || !isFooterBarVisible) {
      return;
    }

    timerToHideFooterBar?.cancel();
    timerToHideFooterBar = Timer(const Duration(seconds: 2), () {
      if (_bloc.state.autoScrollState.isAutoScrollRunning && isFooterBarVisible) {
        setState(() {
          isFooterBarVisible = false;
        });
      }
    });
  }

  void _stopTimerToHideAutoScrollFooterBar() {
    timerToHideFooterBar?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);

    _youtubePlayerController.setFullScreenListener((value) => isYoutubeFullScreen = value);
  }

  @override
  void onContextReady(BuildContext context) {
    WidgetsBinding.instance.addObserver(this);
    _bloc.versionEffectStream.listen((effect) async {
      switch (effect) {
        case OnShowVideoLessonVersionDialog():
          {
            await IncompatibleVersionDialog.show(
              context: context,
              onChangeVersion: () => _bloc.add(OnRestoreVersion()),
              onKeepVersion: () => _bloc.add(OnYouTubeVideoOpened(_bloc.state.version!.videoLesson!.youtubeId)),
            );
          }
        case OnShowYouTubeVideo():
          await _youtubePlayerController.loadVideoById(videoId: effect.videoId);
        case OnCloseYouTubeVideo():
          await _youtubePlayerController.close();
        case OnAutoScrollStartEffect():
          _startTimerToHideAutoScrollFooterBar();
        case OnAutoScrollTickEffect():
          if (isUserTouchingScreen) {
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
              onTapYoutube: (videoId) {
                if (_bloc.state.songState.songPlayerState != SongPlayerState.disposed ||
                    _bloc.state.songState.songPlayerState != SongPlayerState.canceled) {
                  _bloc.add(OnPlayerControllerAction(PlayerAction.cancel));
                }
                _bloc.add(OnYouTubeVideoSelected(videoId));
              },
              onTapSong: (path) {
                if (_bloc.state.isYouTubeVisible) {
                  _bloc.add(OnYouTubeVideoClosed());
                }
                _bloc.add(OnSongSelected(path));
              },
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
                isTabsVisible: _bloc.state.isTabsVisible,
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
              effect.instrument,
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
        case OnReadyToProcessContentEffect():
          if (!context.mounted) {
            break;
          }
          _bloc.add(OnContentProcess(
            screenWidth: MediaQuery.of(context).size.width,
            screenMargin: context.appDimensionScheme.screenMargin,
          ));
        case OnEmailValidateEffect():
          if (!context.mounted) {
            break;
          }
          switch (effect.result) {
            case SendEmailSuccess():
              ConfirmRegisterDialog.show(context: context);
            case SendEmailNetworkError():
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.noConnection)));
            case SendEmailError():
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.text.serverErrorDescription)));
            default:
              break;
          }
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

    if (isUserTouchingScreen && currentIsFooterBarVisible != isFooterBarVisible) {
      setState(() {
        isFooterBarVisible = currentIsFooterBarVisible;
      });
    }
  }

  @override
  void dispose() {
    disposeAll();
    _youtubePlayerController.close();
    _scrollController.dispose();
    _stopTimerToHideAutoScrollFooterBar();
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    if (_orientation != orientation) {
      _bloc.add(OnContentProcess(
        screenWidth: MediaQuery.of(context).size.width,
        screenMargin: context.appDimensionScheme.screenMargin,
      ));
      _orientation = orientation;
    }

    return OnWillNavPop(
      onWillPop: () async {
        if (isYoutubeFullScreen) {
          _youtubePlayerController.exitFullScreen();
          return false;
        } else {
          return true;
        }
      },
      child: YoutubePlayerScaffold(
          controller: _youtubePlayerController,
          builder: (context, player) {
            return BlocBuilder<VersionBloc, VersionState>(
              builder: (context, state) {
                selectedKey ??= state.version?.stdKey; // Todo: remover isso aqui quando transpose estiver funcionando
                return VisibilityDetector(
                  key: const Key("version_screen_visibility"),
                  onVisibilityChanged: (info) {
                    final visiblePercentage = info.visibleFraction * 100;

                    if (visiblePercentage < 1 && state.isYouTubeVisible) {
                      _youtubePlayerController.pauseVideo();
                      _bloc.add(OnPlayerControllerAction(PlayerAction.pause));
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
                        if ((state.version?.instrument.isCifraInstrument ?? false) && !state.restrictContent)
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
                    body: ScrolledUnderBuilder(builder: (context, isScrolledUnder) {
                      return Column(
                        children: [
                          if (state.songState.totalDuration != null)
                            AudioPlayer(
                              totalDuration: state.songState.totalDuration!,
                              actualTime: state.songState.actualTime,
                              state: state.songState.songPlayerState,
                              onTimeChanged: (duration) => _bloc.add(OnSongTimeChanged(duration: duration)),
                              onCancel: () => _bloc.add(OnPlayerControllerAction(PlayerAction.cancel)),
                              onPlay: () => _bloc.add(OnPlayerControllerAction(PlayerAction.play)),
                              onPause: () => _bloc.add(OnPlayerControllerAction(PlayerAction.pause)),
                              isScrolledUnder: isScrolledUnder,
                            ),
                          Flexible(
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Listener(
                                  onPointerDown: (_) {
                                    isUserTouchingScreen = true;
                                  },
                                  onPointerUp: (_) {
                                    if (!isUserDragingScreen) {
                                      setState(() {
                                        isFooterBarVisible = !isFooterBarVisible;
                                      });
                                    }
                                    _startTimerToHideAutoScrollFooterBar();
                                    isUserTouchingScreen = false;
                                    isUserDragingScreen = false;
                                  },
                                  onPointerMove: (_) {
                                    isUserDragingScreen = true;
                                  },
                                  child: CustomScrollView(
                                    controller: _scrollController,
                                    slivers: [
                                      if (state.isYouTubeVisible)
                                        SliverPersistentHeader(
                                            pinned: true,
                                            delegate: YouTubeHeaderDelegate(
                                                MediaQuery.sizeOf(context).width * 9 / 16, player)),
                                      SliverToBoxAdapter(
                                        child: VersionHeader(
                                          songName: state.versionHeaderState.songName,
                                          artistName: state.versionHeaderState.artistName,
                                          isFavorite: state.versionHeaderState.isFavorite,
                                          onTapFavoriteIcon: () {
                                            _bloc.add(OnTapFavoriteButton());
                                          },
                                          onTapArtistName: () =>
                                              ArtistEntry.push(Nav.of(context), state.versionHeaderState.artistUrl),
                                          onTapOptionsIcon: () async {
                                            await widget.versionOptionsBottomSheet.show(
                                              context: context,
                                              artistUrl: state.versionHeaderState.artistUrl,
                                              songUrl: state.versionHeaderState.songUrl,
                                              songId: state.version!.song.songId,
                                              isTabsVisible: state.isTabsVisible,
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
                                          isScrolledUnder: isScrolledUnder,
                                          restrictContent: state.restrictContent,
                                        ),
                                      ),
                                      if (state.isLoading)
                                        const SliverFillRemaining(
                                          child: Center(
                                            child: LoadingIndicator(),
                                          ),
                                        ),
                                      if (state.restrictContent)
                                        SliverToBoxAdapter(
                                          child: BlockedContent(
                                            artistName: state.version?.artist?.name,
                                            onChangeEmail: (email) {
                                              _bloc.add(OnChangeEmail(email: email));
                                            },
                                            onTapSendEmail: (email) {
                                              _bloc.add(OnSendEmail(email: email));
                                            },
                                            isValidEmail: state.isValidEmail,
                                            isConflictError: state.isConflictError,
                                          ),
                                        )
                                      else if (state.version?.instrument.isCifraInstrument ?? false) ...[
                                        ChordListHeader(
                                          isChordListPinned: state.isChordListPinned,
                                          isScrolledUnder: isScrolledUnder,
                                          chordRepresentations: state.chordState.chordRepresentations,
                                          selectedChord: state.chordState.selectedChord,
                                          onTap: (chord) {
                                            _bloc.add(OnChangeSelectedChord(selectedChord: chord.name));
                                            _bloc.add(
                                              OnChordTap(
                                                selectedChord: chord,
                                                instrument: state.version!.instrument,
                                              ),
                                            );
                                          },
                                        ),
                                        SliverPadding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
                                          sliver: SliverList.builder(
                                            itemCount: state.filteredSections.length,
                                            itemBuilder: (context, index) {
                                              final section = state.filteredSections[index];
                                              return Text.rich(
                                                TextSpan(children: section.getSpans(
                                                  (chord) {
                                                    _bloc.add(OnChangeSelectedChord(selectedChord: chord));
                                                  },
                                                )),
                                                textScaleFactor: 1,
                                                style: context.typography.body8
                                                    .copyWith(fontSize: state.fontSizeState.fontSize.toDouble()),
                                              );
                                            },
                                          ),
                                        ),
                                      ] else
                                        SliverToBoxAdapter(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: context.appDimensionScheme.screenMargin),
                                              child: Text(
                                                state.version?.content ?? "",
                                                textScaleFactor: 1,
                                                style: context.typography.body8
                                                    .copyWith(fontSize: state.fontSizeState.fontSize.toDouble()),
                                              ),
                                            ),
                                          ),
                                        ),
                                      const SliverToBoxAdapter(child: SizedBox(height: 16)),
                                    ],
                                  ),
                                ),
                                if (!state.restrictContent)
                                  Listener(
                                    onPointerDown: (_) {
                                      _stopTimerToHideAutoScrollFooterBar();
                                    },
                                    onPointerUp: (_) {
                                      _startTimerToHideAutoScrollFooterBar();
                                    },
                                    child: FloatingFooterBar(
                                      mode: state.floatingFooterBarState.mode,
                                      isVisible: isFooterBarVisible,
                                      isAutoScrollRunning: state.autoScrollState.isAutoScrollRunning,
                                      autoScrollSpeedFactor: state.autoScrollState.speedFactor,
                                      isVideoOpen: state.isYouTubeVisible,
                                      videoThumb: state.version?.videoLesson?.thumb,
                                      isFontDecreaseEnabled: state.fontSizeState.isDecreaseEnabled,
                                      isFontIncreaseEnabled: state.fontSizeState.isIncreaseEnabled,
                                      onAction: (action) {
                                        _bloc.add(OnFloatingFooterBarAction(action: action));
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                );
              },
            );
          }),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      _bloc.add(OnAutoScrollStop());
    }
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    _bloc.add(OnAutoScrollStop());
    return super.didPushRouteInformation(routeInformation);
  }
}

// https://pub.dev/packages/youtube_player_iframe
class YouTubeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget player;

  YouTubeHeaderDelegate(this.height, this.player);

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return player;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! YouTubeHeaderDelegate || oldDelegate.height != height || oldDelegate.player != player;
  }
}

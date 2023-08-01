import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_event.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:cifraclub/presentation/widgets/subscription_holder.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VersionScreen extends StatefulWidget {
  const VersionScreen({super.key});

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> with SubscriptionHolder {
  late final _bloc = BlocProvider.of<VersionBloc>(context);
  final _scrollController = TrackingScrollController();
  var isFooterBarVisible = true;

  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);

    _bloc.versionEventStream.listen((event) async {
      switch (event) {
        case OnYouTubeVideoSelected():
          if (_youtubePlayerController == null) {
            _youtubePlayerController = YoutubePlayerController(
              params: const YoutubePlayerParams(
                mute: false,
                showControls: true,
                showFullscreenButton: true,
              ),
            );
            await _youtubePlayerController?.loadVideoById(videoId: event.videoId);
          }
          break;
        case OnYouTubeVideoClosed():
          await _youtubePlayerController?.close();
          _youtubePlayerController = null;
          break;
      }
    }).addTo(subscriptions);
  }

  void onScroll() {
    final currentOffset = _scrollController.offset;
    final previousOffset = _scrollController.initialScrollOffset;
    final currentIsFooterBarVisible = currentOffset < previousOffset;

    if (currentIsFooterBarVisible != isFooterBarVisible) {
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
        return Scaffold(
          //persistentFooterButtons: [Container(height: 40, width: 300,color:Colors.amber),],
          appBar: CosmosAppBar(
            actions: [
              TextButton(
                  onPressed: () {
                    _bloc.toggleChordPinnedState();
                  },
                  child: Text(state.isChordListPinned ? "Ocultar acordes na tela" : "Fixar acordes na tela")),
            ],
          ),
          body: Stack(
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
                    child: Column(
                      children: [
                        Text(state.version?.music.name ?? ""),
                        Text(state.version?.artist?.name ?? ""),
                        FilterCapsuleList(
                          filters: state.version?.songsDetail?.first.songs?.map((song) {
                                return Filter(
                                    label: song.label,
                                    isSelected: song.label == state.version?.label,
                                    onTap: () {
                                      _bloc.onVersionSelected(song);
                                    },
                                    leadingIconUri: song.verified ? AppSvgs.verifiedIcon : null);
                              }).toList() ??
                              const [],
                        ),
                      ],
                    ),
                  ),
                  SliverPersistentHeader(
                      pinned: state.isChordListPinned,
                      delegate: ChordListHeaderDelegate(
                          haveScroll: false,
                          maxExtend: 110,
                          child: const Text("Acordes"),
                          isPinned: state.isChordListPinned,
                          chords: state.version?.chords ?? [])),
                  SliverList.builder(
                    itemCount: state.sections.length,
                    itemBuilder: (context, index) {
                      final section = state.sections[index];
                      return Text(
                        section.content,
                        style: context.typography.body8,
                      );
                    },
                  ),
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
                      TextButton(onPressed: () {}, child: const Icon(Icons.video_chat)),
                      TextButton(onPressed: () {}, child: const Icon(Icons.arrow_outward)),
                      TextButton(onPressed: () {}, child: const Icon(Icons.settings)),
                      TextButton(
                          onPressed: () {
                            state.isYouTubeVisible
                                ? _bloc.closeYouTubeVideo()
                                : _bloc.loadYouTubeVideo(state.version?.videoLesson?.youtubeId ?? "Pt9elq3DYNM");
                          },
                          child: const Icon(Icons.youtube_searched_for_outlined))
                    ],
                  ),
                ),
              )
            ],
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
  final List<Chord> chords;

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
        height: maxExtend,
        color: Colors.red,
        child: ListView.builder(
          itemCount: chords.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final chord = chords[index];
            return Container(
              height: 50,
              width: 100,
              color: Colors.blue,
              child: Center(child: Text(chord.chord)),
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

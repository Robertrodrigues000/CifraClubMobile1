import 'package:cifraclub/domain/version/models/chord.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/version/version_bloc.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionScreen extends StatefulWidget {
  const VersionScreen({super.key});

  @override
  State<VersionScreen> createState() => _VersionScreenState();
}

class _VersionScreenState extends State<VersionScreen> {
  late final _bloc = BlocProvider.of<VersionBloc>(context);
  final _scrollController = TrackingScrollController();
  var isFooterBarVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(onScroll);
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // https://github.com/StudioSol/PalcoMobile/blob/development/lib/presentation/screens/podcast/podcast_screen.dart#L168

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
                  child: Text(state.isChordListPinned ? "Ocultar acordes na tela" : "Fixar acordes na tela"))
            ],
          ),
          // SliverAppBar

          // Ação pra trocar o pinned no state
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverPersistentHeader(
                    delegate: VersionInfoHeaderDelegate(
                        maxExtend: 110,
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: true,
                          child: Column(
                            children: [
                              Text(state.version?.music.name ?? ""),
                              Text(state.version?.artist?.name ?? ""),
                            ],
                          ),
                        ),
                        haveScroll: false),
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
                ),
              )
            ],
          ),
        );
      },
    );
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

class VersionInfoHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double maxExtend;
  final Widget child;
  final bool haveScroll;

  VersionInfoHeaderDelegate({
    required this.maxExtend,
    required this.child,
    required this.haveScroll,
  });

  @override
  double get maxExtent => maxExtend;

  @override
  double get minExtent => 0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtend,
      color: Colors.cyan,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is! VersionInfoHeaderDelegate ||
        oldDelegate.haveScroll != haveScroll ||
        oldDelegate.child != child;
  }
}

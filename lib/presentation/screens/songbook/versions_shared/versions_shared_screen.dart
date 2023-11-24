import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/songbook_information_section.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_fixed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/versions_shared/versions_shared_state.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class VersionsSharedScreen extends StatefulWidget {
  const VersionsSharedScreen({
    super.key,
    required this.songbookId,
    this.userId,
  });

  final int? songbookId;
  final int? userId;

  @override
  State<VersionsSharedScreen> createState() => _VersionsSharedScreenState();
}

class _VersionsSharedScreenState extends State<VersionsSharedScreen> {
  late final VersionsSharedBloc _bloc = BlocProvider.of<VersionsSharedBloc>(context);
  final scrollController = ScrollController();
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  // coverage:ignore-start
  void _onScroll() {
    final currentOffset = scrollController.offset;
    final oldScrolledUnder = isScrolledUnder;
    isScrolledUnder = currentOffset > 0 ? true : false;
    if (oldScrolledUnder != isScrolledUnder) {
      setState(() {});
    }
  }
  // coverage:ignore-end

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VersionsSharedBloc, VersionsSharedState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
              toolbarHeight: context.appDimensionScheme.appBarHeight,
              automaticallyImplyLeading: false,
              leading: Row(
                children: [
                  InkWell(
                    onTap: () => Nav.of(context).pop(),
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
                ],
              ),
              actions: [
                if (state.songbook?.id != null &&
                    widget.userId != null &&
                    state.songbook?.isPublic == true &&
                    state.songbook?.type == ListType.user)
                  Builder(builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: InkWell(
                        onTap: () async {
                          final box = context.findRenderObject() as RenderBox?;
                          final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                          final link = AppUrls.songbookUrlFormat(widget.userId!, state.songbook!.id!);
                          await _bloc.shareLink(link, rect);
                        },
                        child: SvgImage(
                          height: 48,
                          width: 48,
                          assetPath: AppSvgs.shareIcon,
                          fit: BoxFit.none,
                          color: context.colors.textPrimary,
                        ),
                      ),
                    );
                  }),
              ]),
          body: state.error != null
              ? ErrorDescriptionWidget(
                  typeError: ErrorDescriptionWidgetType.server,
                  onClick: () => _bloc.init(widget.songbookId), // coverage:ignore-line
                )
              : CustomScrollView(
                  controller: scrollController,
                  physics: state.versions.isEmpty ? const NeverScrollableScrollPhysics() : null,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SongbookInformationSection(
                        isScrolledUnder: isScrolledUnder,
                        isPublic: state.songbook?.isPublic ?? false,
                        songbookName: ListType.getListTitle(context, state.songbook),
                        preview: _bloc.getPreview(),
                        listType: state.songbook?.type ?? ListType.recents,
                        userName: state.songbook?.userName,
                      ),
                    ),
                    VersionsSharedFixedHeader(
                      isScrolledUnder: isScrolledUnder,
                      selectedOrderType: state.selectedListOrderType,
                      onSelectedOrderType: _bloc.onSelectedOrderType,
                      listType: state.songbook?.type ?? ListType.recents,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.versions.length,
                        (context, index) {
                          final item = state.versions[index];
                          return VersionTile(
                            song: item.name,
                            artist: item.artist.name,
                            type: item.instrument.getInstrumentName(context),
                            versionKey: item.key,
                            editable: false,
                            onVersionTap: () => VersionEntry.pushFromSong(
                                Nav.of(context), item.artist.url, item.songUrl, item.artist.name, item.name),
                          );
                        },
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: state.songbook?.isPublic == false && state.versions.isNotEmpty
                          ? const ErrorDescriptionWidget(
                              typeError: ErrorDescriptionWidgetType.privateList,
                            )
                          : state.versions.isEmpty
                              ? const ErrorDescriptionWidget(
                                  typeError: ErrorDescriptionWidgetType.emptyList,
                                )
                              : const SizedBox(),
                    )
                  ],
                ),
        );
      },
    );
  }
}

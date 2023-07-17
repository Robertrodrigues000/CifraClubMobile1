import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/dialogs/delete_version_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:cosmos/cosmos.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/empty_list_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class VersionsScreen extends StatefulWidget {
  const VersionsScreen({
    super.key,
    required this.isTablet,
    required this.songbookId,
    this.userId,
    required this.listOptionsbottomSheet,
    this.onDeleteSongbook,
  });

  final ListOptionsBottomSheet listOptionsbottomSheet;
  final bool isTablet;
  final int? songbookId;
  final int? userId;
  final VoidCallback? onDeleteSongbook;

  @override
  State<VersionsScreen> createState() => _VersionsScreenState();
}

class _VersionsScreenState extends State<VersionsScreen> {
  static const _searchHeight = 56.0;
  late VersionsBloc _bloc;
  final scrollController = ScrollController(initialScrollOffset: _searchHeight);
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<VersionsBloc>(context)..init(widget.songbookId);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final currentOffset = scrollController.offset;
    final oldScrolledUnder = isScrolledUnder;
    isScrolledUnder = currentOffset > _searchHeight ? true : false;
    if (oldScrolledUnder != isScrolledUnder) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant VersionsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.songbookId != widget.songbookId) {
      _bloc.init(widget.songbookId);
      scrollController.animateTo(
        _searchHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VersionsBloc, VersionsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CosmosAppBar(
            title: Text(context.text.lists, style: context.typography.title3),
            toolbarHeight: context.appDimensionScheme.appBarHeight,
            automaticallyImplyLeading: false,
            extendsUnderScroll: _searchHeight.toInt(),
            //TODO: implementar title spacing no cosmos e depois adicionar aqui
            leading: widget.isTablet
                ? null
                : Row(
                    children: [
                      SizedBox(width: context.appDimensionScheme.appBarMargin),
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
                  return InkWell(
                    onTap: () async {
                      final box = context.findRenderObject() as RenderBox?;
                      final rect = box != null ? box.localToGlobal(Offset.zero) & box.size : null;
                      final link = AppUrls.songbookUrlFormat(widget.userId!, state.songbook!.id!);
                      await _bloc.shareLink(link, rect);
                    },
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: SvgPicture.asset(
                        AppSvgs.shareIcon,
                        fit: BoxFit.none,
                        color: context.colors.textPrimary,
                      ),
                    ),
                  );
                }),
              InkWell(
                onTap: () {
                  Nav.of(context).push(
                    screenName: AddVersionsToListEntry.name,
                    params: AddVersionsToListEntry.declareParams(widget.songbookId ?? 0),
                  );
                },
                child: SizedBox(
                  height: 48,
                  width: 48,
                  child: SvgPicture.asset(
                    AppSvgs.addIcon,
                    fit: BoxFit.none,
                    color: context.colors.textPrimary,
                  ),
                ),
              ),
              if (state.songbook != null)
                InkWell(
                  onTap: () async {
                    await widget.listOptionsbottomSheet.open(
                      context: context,
                      isUserList: state.songbook?.type == ListType.user,
                      ccid: widget.userId,
                      songbook: state.songbook!,
                      onDeleteSongbook: () {
                        if (widget.isTablet) {
                          widget.onDeleteSongbook!();
                        } else {
                          Nav.of(context).pop();
                        }
                      },
                    );
                  },
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: SvgPicture.asset(
                      AppSvgs.overflowIcon,
                      fit: BoxFit.none,
                      color: context.colors.textPrimary,
                    ),
                  ),
                ),
              SizedBox(width: context.appDimensionScheme.appBarMargin),
            ],
          ),
          body: CustomScrollView(
            controller: scrollController,
            physics: state.versions.isEmpty ? const NeverScrollableScrollPhysics() : null,
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.appDimensionScheme.screenMargin,
                  ),
                  color: isScrolledUnder ? context.colors.neutralSecondary : context.colors.neutralPrimary,
                  height: _searchHeight,
                  child: Center(
                    child: CosmosSearchBar(
                      onChanged: (_) {}, // coverage:ignore-line
                      cancelText: "",
                      hintText: context.text.searchSongs,
                      labelText: context.text.searchSongs,
                      isReadOnly: true,
                      onTap: () =>
                          Nav.of(context).push(screenName: AddVersionsToListEntry.name), // coverage:ignore-line
                      // TODO : Mudar para a tela de pesquisar cifras
                    ),
                  ),
                ),
              ),
              VersionsCollapsedHeader(
                isScrolledUnder: isScrolledUnder,
                isPublic: state.songbook?.isPublic ?? false,
                songbookName: state.songbook?.name ?? "",
                preview: state.songbook?.preview,
                isTablet: widget.isTablet,
              ),
              VersionsFixedHeader(
                isScrolledUnder: isScrolledUnder,
                isPro: state.isPro,
                tabsCount: state.versionsCount,
                tabsLimit: state.versionsLimit,
                tabsLimitState: state.versionLimitState,
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.versions.length,
                  (context, index) {
                    final item = state.versions[index];
                    return VersionTile(
                      song: item.name,
                      artist: item.artist.name,
                      type: "Violão",
                      tone: item.tone ?? "",
                      // coverage:ignore-start
                      onOptionsTap: () async {
                        ListVersionOptionsBottomSheet(onTap: () async {
                          final shouldDeleteVersion = await DeleteVersionDialog.show(
                            context: context,
                            versionName: item.name,
                          );
                          if (shouldDeleteVersion) {
                            // todo: delete version from songbook
                          }
                        }).show(context);
                      },
                      onVersionTap: () {},
                      onDeleteTap: () {},
                      // coverage:ignore-end
                      editable: false,
                    );
                  },
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: state.versions.isEmpty
                    ? EmptyListEmptyState(
                        onClick: () {
                          Nav.of(context).push(
                              screenName: AddVersionsToListEntry.name,
                              params: AddVersionsToListEntry.declareParams(widget.songbookId ?? 0));
                        },
                      )
                    : Container(),
              ),
              SliverToBoxAdapter(child: SizedBox(height: context.appDimensionScheme.searchInputHeight))
            ],
          ),
        );
      },
    );
  }
}

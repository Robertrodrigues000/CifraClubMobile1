import 'package:cifraclub/domain/list_limit/models/list_limit_state.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_options_bottom_sheet/list_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_limit_pro_dialog.dart';
import 'package:cifraclub/presentation/dialogs/list_operation_dialogs/delete_version_dialog.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_entry.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_result.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/songbook_information_section.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cifraclub/presentation/widgets/limit_warning.dart';
import 'package:cifraclub/presentation/widgets/svg_image.dart';
import 'package:cosmos/cosmos.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
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
    required this.listOptionsBottomSheet,
    this.onDeleteSongbook,
  });

  final ListOptionsBottomSheet listOptionsBottomSheet;
  final bool isTablet;
  final int? songbookId;
  final int? userId;
  final VoidCallback? onDeleteSongbook;

  @override
  State<VersionsScreen> createState() => _VersionsScreenState();
}

class _VersionsScreenState extends State<VersionsScreen> {
  late final VersionsBloc _bloc = BlocProvider.of<VersionsBloc>(context);
  final scrollController = ScrollController();
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final currentOffset = scrollController.offset;
    final oldScrolledUnder = isScrolledUnder;
    isScrolledUnder = currentOffset > 0 ? true : false;
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
        0,
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
            toolbarHeight: context.appDimensionScheme.appBarHeight,
            automaticallyImplyLeading: false,
            //TODO: implementar title spacing no cosmos e depois adicionar aqui
            leading: widget.isTablet
                ? null
                : Row(
                    children: [
                      SizedBox(width: context.appDimensionScheme.appBarMargin),
                      InkWell(
                        onTap: () => Nav.of(context).pop(),
                        child: SvgImage(
                          height: 48,
                          width: 48,
                          assetPath: AppSvgs.backArrowIcon,
                          fit: BoxFit.none,
                          color: context.colors.textPrimary,
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
                    child: SvgImage(
                      height: 48,
                      width: 48,
                      assetPath: AppSvgs.shareIcon,
                      fit: BoxFit.none,
                      color: context.colors.textPrimary,
                    ),
                  );
                }),
              InkWell(
                onTap: () async {
                  if (state.versionLimitState == ListLimitState.reached) {
                    if (state.isPro) {
                      ListLimitProDialog.show(context: context, isVersionLimit: true, limitCount: state.versionsLimit);
                    } else {
                      ListLimitDialog.show(context: context, isVersionLimit: true, limitCount: state.versionsLimit);
                    }
                  } else {
                    await AddVersionsToListEntry.push(Nav.of(context), widget.songbookId ?? 0);
                    final versionsLimitState = await _bloc.getListLimitState(widget.songbookId!);
                    if (context.mounted &&
                        versionsLimitState != ListLimitState.withinLimit &&
                        versionsLimitState != state.versionLimitState) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        ListLimitWarningSnackBar.getListLimitSnackBar(
                            limit: state.versionsLimit,
                            isVersionLimit: true,
                            count: state.versionsCount,
                            listLimitState: versionsLimitState,
                            proLimit: state.proLimit,
                            isPro: state.isPro),
                      );
                    }
                  }
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
                    await widget.listOptionsBottomSheet.open(
                      context: context,
                      isUserList: state.songbook?.type == ListType.user,
                      ccid: widget.userId,
                      songbook: state.songbook!,
                      haveEditMode: true,
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
              /*SliverToBoxAdapter(
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
                      onTap: () => Nav.of(context).push(screenName: SearchEntry.name), // coverage:ignore-line
                    ),
                  ),
                ),
              )*/ // TODO : Implementar tela de pesquisa de versions e ajuste o código para a barra de pesquisa
              SliverToBoxAdapter(
                child: SongbookInformationSection(
                  isScrolledUnder: isScrolledUnder,
                  isPublic: state.songbook?.isPublic ?? false,
                  songbookName: ListType.getListTitle(context, state.songbook),
                  preview: _bloc.getPreview(),
                  listType: state.songbook?.type ?? ListType.recents,
                  isPro: state.isPro,
                ),
              ),
              VersionsFixedHeader(
                isScrolledUnder: isScrolledUnder,
                isPro: state.isPro,
                tabsCount: state.versionsCount,
                tabsLimit: state.versionsLimit,
                tabsLimitState: state.versionLimitState,
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
                      // coverage:ignore-start
                      onOptionsTap: () {
                        ListVersionOptionsBottomSheet(onTap: () async {
                          final shouldDeleteVersion = await DeleteVersionDialog.show(
                            context: context,
                            versionName: item.name,
                          );
                          if (shouldDeleteVersion) {
                            final result = await _bloc.deleteVersion(widget.songbookId, item);
                            switch (result) {
                              case OnVersionDeleted():
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(context.text.removeVersionSucceed)),
                                  );
                                }
                              case OnVersionDeletedFailed():
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(result.error is ConnectionError
                                          ? context.text.noConnection
                                          : context.text.listServerError),
                                    ),
                                  );
                                }
                            }
                          }
                        }).show(context);
                      },
                      onVersionTap: () => VersionEntry.pushFromSong(
                          Nav.of(context), item.artist.url, item.songUrl, item.artist.name, item.name),
                      // coverage:ignore-end
                      editable: false,
                    );
                  },
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: state.versions.isEmpty
                    ? ErrorDescriptionWidget(
                        typeError: ErrorDescriptionWidgetType.emptyList,
                        onClick: () => AddVersionsToListEntry.push(Nav.of(context), widget.songbookId ?? 0),
                      )
                    : Container(),
              ),
              /*SliverToBoxAdapter(child: SizedBox(height: context.appDimensionScheme.searchInputHeight))*/ // TODO : Quando tiver a barra de pesquisa vamos precisar desse box para compensar o scroll
            ],
          ),
        );
      },
    );
  }
}

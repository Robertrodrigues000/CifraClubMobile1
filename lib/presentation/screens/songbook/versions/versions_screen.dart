// coverage:ignore-file
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/bottom_sheets/list_version_options_bottom_sheet.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_collapsed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/versions_fixed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/edit_list/edit_list_screen_builder.dart';
import 'package:cifraclub/presentation/dialogs/delete_version_dialog.dart';
import 'package:cifraclub/presentation/widgets/cosmos_app_bar.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class VersionsScreen extends StatefulWidget {
  const VersionsScreen(
      {super.key, required this.isTablet, required this.songbook, required this.editListScreenBuilder});

  final bool isTablet;
  final Songbook? songbook;
  final EditListScreenBuilder editListScreenBuilder;

  @override
  State<VersionsScreen> createState() => _VersionsScreenState();
}

class _VersionsScreenState extends State<VersionsScreen> {
  late VersionsBloc _bloc;
  final scrollController = ScrollController();
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<VersionsBloc>(context);
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.getSongbook(widget.songbook);
  }

  @override
  void didUpdateWidget(covariant VersionsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.songbook != widget.songbook) {
      _bloc.getSongbook(widget.songbook);
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
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
        //TODO: adicionar à condição que a lista deve ser de terceiro
        if (!state.isPublic) {
          return Scaffold(
            appBar: CosmosAppBar(
                title: Text(context.text.lists, style: context.typography.title3),
                toolbarHeight: context.appDimensionScheme.appBarHeight,
                automaticallyImplyLeading: false),
            body: Center(
              child: ErrorDescriptionWidget(
                typeError: ErrorDescriptionWidgetType.privateList,
                onClick: () => Nav.of(context).pop(),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: CosmosAppBar(
              title: Text(context.text.lists, style: context.typography.title3),
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
                InkWell(
                  onTap: () async {
                    await widget.editListScreenBuilder
                        .push(context, state.versions, widget.songbook?.name ?? "", widget.songbook?.id ?? 0);
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
                ),
                InkWell(
                  onTap: () {},
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
                InkWell(
                  onTap: () {},
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
              slivers: [
                VersionsCollapsedHeader(
                  isScrolledUnder: isScrolledUnder,
                  isPublic: widget.songbook?.isPublic ?? false,
                  songbookName: widget.songbook?.name ?? "",
                ),
                VersionsFixedHeader(
                  isScrolledUnder: isScrolledUnder,
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
                        tone: item.tone,
                        onOptionsTap: () async {
                          ListVersionOptionsBottomSheet(onTap: () async {
                            final shouldDeleteVersion =
                                await DeleteVersionDialog.show(context: context, versionName: item.name);
                            if (shouldDeleteVersion) {
                              // todo: delete version from songbook
                            }
                          }).show(context);
                        },
                        onVersionTap: () {},
                        editable: false,
                      );
                    },
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}

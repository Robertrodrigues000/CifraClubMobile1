import 'dart:async';

import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/artist_search.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/models/search_models/songbook_search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/album/album_entry.dart';
import 'package:cifraclub/presentation/screens/artist/artist_entry.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/albums.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_app_bar.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_fixed_header.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_tile.dart';
import 'package:cifraclub/presentation/screens/version/version_entry.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nav/nav.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchBloc _bloc = BlocProvider.of<SearchBloc>(context);
  final _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late StreamSubscription<bool> keyboardSubscription;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_updateText);
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardSubscription = keyboardVisibilityController.onChange.listen((bool isVisible) {
      if (!isVisible) {
        _focusNode.unfocus();
      }
    });
  }

  void _updateText() {
    setState(() {
      _textEditingController.text;
    });
  }

  void _scrollToInit() {
    _scrollController.jumpTo(_scrollController.position.minScrollExtent);
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    _textEditingController.removeListener(_updateText);
    _textEditingController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: SearchAppBar(
            focusNode: _focusNode,
            isScrolledUnder: false,
            searchInputHeight: context.appDimensionScheme.searchInputHeight,
            onChanged: (query) {
              _bloc.search(query);
              _scrollToInit();
            },
            onTapClear: () {
              _textEditingController.clear();
              _bloc.clearList();
              _scrollToInit();
            },
            hintText: context.text.searchHint,
            textEditingController: _textEditingController,
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SearchFixedHeader(
                onTapFilter: (filter) {
                  _bloc.onFilterSelected(filter, _textEditingController.text);
                  _scrollToInit();
                },
                selectedFilter: state.selectedFilter,
                isRecent: state.shouldShowRecent,
              ),
              if (state.shouldShowRecent)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.recent.length,
                    (context, index) {
                      final version = state.recent[index];
                      return SearchTile(
                        subtitle: version.artist.name,
                        onTap: () {},
                        title: version.name,
                        imageUrl: version.artist.image?.size162,
                      );
                    },
                  ),
                )
              else ...[
                if (state.error != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: ErrorDescriptionWidget(
                        typeError: state.error! is ConnectionError
                            ? ErrorDescriptionWidgetType.connection
                            : ErrorDescriptionWidgetType.server,
                        onClick: () => _bloc.search(_textEditingController.text),
                      ),
                    ),
                  )
                else if (state.isLoading)
                  const SliverFillRemaining(child: Center(child: LoadingIndicator()))
                else if (state.result.isEmpty && _textEditingController.text.isNotEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: ErrorDescriptionWidget(
                        typeError: ErrorDescriptionWidgetType.searchResultNotFound,
                      ),
                    ),
                  )
                else if (state.selectedFilter == SearchFilter.albums)
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 24),
                    sliver: Albums(
                      searchItems: state.result,
                    ),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.result.length,
                      (context, index) {
                        final result = state.result[index];
                        switch (result) {
                          case SongSearch songResult:
                            return SearchTile(
                              // coverage:ignore-start
                              onTap: () => VersionEntry.pushFromSong(
                                Nav.of(context),
                                songResult.artistUrl,
                                songResult.songUrl,
                                songResult.artistName,
                                songResult.songName,
                              ),
                              // coverage:ignore-end
                              title: songResult.songName,
                              subtitle: songResult.artistName,
                              imageUrl: songResult.artistImage,
                              trailing: songResult.isVerified ? SvgPicture.asset(AppSvgs.verifiedIcon) : null,
                            );
                          case ArtistSearch artistResult:
                            return SearchTile(
                              // coverage:ignore-start
                              onTap: () => ArtistEntry.push(Nav.of(context), artistResult.url, artistResult.name),
                              // coverage:ignore-end
                              title: artistResult.name,
                              imageUrl: artistResult.imageUrl,
                            );
                          case SongbookSearch songbookResult:
                            return SearchTile(
                              subtitle:
                                  "${songbookResult.totalSongs} ${context.text.songs(songbookResult.totalSongs)} • ${songbookResult.userName}",
                              onTap: () {}, // coverage:ignore-line
                              title: songbookResult.songbookName,
                              listPreview: songbookResult.songbookPreview,
                            );
                          case AlbumSearch albumResult:
                            return SearchTile(
                              subtitle: "${albumResult.artistName} • ${albumResult.releaseYear}",
                              // coverage:ignore-start
                              onTap: () => AlbumEntry.push(
                                  Nav.of(context), albumResult.artistUrl, albumResult.albumUrl, albumResult.albumName),
                              // coverage:ignore-end
                              title: albumResult.albumName,
                              imageUrl: albumResult.albumCover,
                            );
                          default:
                            return null;
                        }
                      },
                    ),
                  ),
              ],
            ],
          ),
        );
      },
    );
  }
}

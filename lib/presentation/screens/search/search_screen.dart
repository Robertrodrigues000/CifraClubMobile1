// coverage:ignore-file
import 'dart:async';

import 'package:cifraclub/domain/search/models/search_models/album_search.dart';
import 'package:cifraclub/domain/search/models/search_models/artist_search.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/models/search_models/songbook_search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_app_bar.dart';
import 'package:cifraclub/presentation/screens/search/widgets/search_fixed_header.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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

  @override
  void dispose() {
    keyboardSubscription.cancel();
    _textEditingController.removeListener(_updateText);
    _textEditingController.dispose();
    _focusNode.dispose();
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
            onChanged: _bloc.search,
            onTapClear: () {
              _textEditingController.clear();
              _bloc.clearList();
            },
            hintText: context.text.searchHint,
            textEditingController: _textEditingController,
          ),
          body: CustomScrollView(
            slivers: [
              if (state.shouldShowRecent)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.recent.length,
                    (context, index) {
                      final version = state.recent[index];
                      return AddVersionTile(
                        artist: version.artist.name,
                        onTap: () {},
                        song: version.name,
                        state: SongState.toAdd,
                        imageUrl: version.artist.image?.size162,
                      );
                    },
                  ),
                )
              else ...[
                SearchFixedHeader(
                  onTapFilter: (filter) => _bloc.onFilterSelected(filter, _textEditingController.text),
                  selectedFilter: state.selectedFilter,
                ),
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
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.result.length,
                      (context, index) {
                        final result = state.result[index];
                        if (result is SongSearch) {
                          return AddVersionTile(
                            artist: result.artistName,
                            onTap: () {},
                            song: result.songName,
                            state: SongState.toAdd,
                            imageUrl: result.artistImage,
                          );
                        } else if (result is ArtistSearch) {
                          return AddVersionTile(
                            onTap: () {},
                            song: result.name,
                            state: SongState.toAdd,
                            imageUrl: result.imageUrl,
                          );
                        } else if (result is SongbookSearch) {
                          return AddVersionTile(
                            artist: "${result.userName} - ${result.totalSongs}",
                            onTap: () {},
                            song: result.songbookName,
                            state: SongState.toAdd,
                            imageUrl: result.songbookPreview?.first,
                          );
                        } else if (result is AlbumSearch) {
                          return AddVersionTile(
                            artist: result.artistName,
                            onTap: () {},
                            song: result.albumName,
                            state: SongState.toAdd,
                            imageUrl: result.albumCover,
                          );
                        } else {
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

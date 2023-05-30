import 'dart:async';
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_tabs_limit_state_by_count.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:cifraclub/domain/search/use_case/search_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_cifras.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/add_cifras_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_cifras_to_list/widgets/add_cifra_tile/song_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

class AddCifrasToListBloc extends Cubit<AddCifrasToListState> {
  final GetProStatusStream _getProStatusStream;
  final SearchSongs _searchSongs;
  final GetTabsLimit _getTabsLimit;
  final GetTotalSongbookCifras _getTotalSongbookCifras;
  final GetTabLimitStateByCount _getTabLimitStateByCount;

  AddCifrasToListBloc(
    this._searchSongs,
    this._getProStatusStream,
    this._getTabsLimit,
    this._getTotalSongbookCifras,
    this._getTabLimitStateByCount,
  ) : super(const AddCifrasToListState());

  StreamSubscription? _getProStatusSubscription;
  StreamSubscription? _searchRequestSubscription;
  CancelableOperation<Result<List<SongSearch>, RequestError>>? currentRequest;
  final BehaviorSubject<String> _searchQuery = BehaviorSubject();

  @visibleForTesting
  final mockedList = [123, 124];

  void init(int songbookId) {
    _getProStatusSubscription = _getProStatusStream().listen(_updateProStatus);
    _searchRequestSubscription = _searchQuery.debounceTime(const Duration(milliseconds: 300)).listen(_searchRequest);
    _updateLimitState(songbookId);
  }

  Future<void> _updateLimitState(int songbookId) async {
    final count = await _getTotalSongbookCifras(songbookId).first ?? 0;
    emit(state.copyWith(limitState: _getTabLimitStateByCount(state.isPro, count), tabsCount: count));
  }

  Future<void> _searchRequest(String query) async {
    currentRequest?.cancel();
    currentRequest = _searchSongs(query: query);
    final request = await currentRequest!.valueOrCancellation(Err(RequestCancelled()));

    request?.when(
      success: (songs) {
        emit(state.copyWith(songs: songs, isLoading: false));
      },
      failure: (error) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }

  Future<void> _updateProStatus(bool isPro) async {
    final tabsLimit = _getTabsLimit(isPro);
    emit(state.copyWith(
      tabsLimit: tabsLimit,
      isPro: isPro,
      limitState: _getTabLimitStateByCount(state.isPro, state.tabsCount),
    ));
  }

  void addOrRemoveCifra(SongSearch song) {
    final newList = state.selectedCifras.toList();
    var tabsCount = state.tabsCount;

    if (state.selectedCifras.contains(song)) {
      tabsCount--;
      newList.remove(song);
    } else {
      newList.add(song);
      tabsCount++;
    }

    emit(state.copyWith(
      selectedCifras: newList,
      tabsCount: tabsCount,
      limitState: _getTabLimitStateByCount(state.isPro, tabsCount),
    ));
  }

  void clearList() {
    emit(state.copyWith(songs: List.empty()));
  }

  void clearCount() {
    var tabsCount = state.tabsCount;
    tabsCount -= state.selectedCifras.length;

    emit(state.copyWith(
      selectedCifras: List.empty(),
      tabsCount: tabsCount,
      limitState: _getTabLimitStateByCount(state.isPro, tabsCount),
    ));
  }

  SongState getSongState(SongSearch song) {
    if (state.selectedCifras.contains(song)) {
      return SongState.selected;
    } else if (mockedList.any((element) => element == song.songId)) {
      return SongState.added;
    }
    return SongState.toAdd;
  }

  void searchSongs(String query) {
    if (!state.isLoading) {
      emit(state.copyWith(isLoading: true));
    }
    _searchQuery.add(query);
  }

  @override
  Future<void> close() {
    _getProStatusSubscription?.cancel();
    _searchRequestSubscription?.cancel();
    return super.close();
  }
}

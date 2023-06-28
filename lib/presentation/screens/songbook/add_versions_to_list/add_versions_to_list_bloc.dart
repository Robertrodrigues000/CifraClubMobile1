import 'dart:async';
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart';
import 'package:cifraclub/domain/search/models/song_search.dart';
import 'package:cifraclub/domain/search/use_cases/search_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_total_songbook_versions.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

class AddVersionsToListBloc extends Cubit<AddVersionsToListState> {
  final GetProStatusStream _getProStatusStream;
  final SearchSongs _searchSongs;
  final GetVersionsLimit _getVersionsLimit;
  final GetTotalSongbookVersions _getTotalSongbookVersions;
  final GetVersionLimitStateByCount _getVersionLimitStateByCount;

  AddVersionsToListBloc(
    this._searchSongs,
    this._getProStatusStream,
    this._getVersionsLimit,
    this._getTotalSongbookVersions,
    this._getVersionLimitStateByCount,
  ) : super(const AddVersionsToListState());

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
    final count = await _getTotalSongbookVersions(songbookId).first ?? 0;
    emit(state.copyWith(limitState: _getVersionLimitStateByCount(state.isPro, count), versionsCount: count));
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
    final versionsLimit = _getVersionsLimit(isPro);
    emit(state.copyWith(
      versionsLimit: versionsLimit,
      isPro: isPro,
      limitState: _getVersionLimitStateByCount(state.isPro, state.versionsCount),
    ));
  }

  void addOrRemoveVersion(SongSearch song) {
    final newList = state.selectedVersions.toList();
    var versionsCount = state.versionsCount;

    if (state.selectedVersions.contains(song)) {
      versionsCount--;
      newList.remove(song);
    } else {
      newList.add(song);
      versionsCount++;
    }

    emit(state.copyWith(
      selectedVersions: newList,
      versionsCount: versionsCount,
      limitState: _getVersionLimitStateByCount(state.isPro, versionsCount),
    ));
  }

  void clearList() {
    emit(state.copyWith(songs: List.empty()));
  }

  void clearCount() {
    var versionsCount = state.versionsCount;
    versionsCount -= state.selectedVersions.length;

    emit(state.copyWith(
      selectedVersions: List.empty(),
      versionsCount: versionsCount,
      limitState: _getVersionLimitStateByCount(state.isPro, versionsCount),
    ));
  }

  SongState getSongState(SongSearch song) {
    if (state.selectedVersions.contains(song)) {
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

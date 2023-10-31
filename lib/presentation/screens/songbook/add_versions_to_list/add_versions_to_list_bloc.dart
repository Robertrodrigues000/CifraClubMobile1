import 'dart:async';
import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit.dart';
import 'package:cifraclub/domain/list_limit/use_cases/get_versions_limit_state_by_count.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_list_limit_constants.dart';
import 'package:cifraclub/domain/search/models/search_models/song_search.dart';
import 'package:cifraclub/domain/search/use_cases/search_songs.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/subscription/use_cases/get_pro_status_stream.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/add_versions_to_list_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

class AddVersionsToListBloc extends Cubit<AddVersionsToListState> {
  final int songbookId;
  final GetProStatusStream _getProStatusStream;
  final SearchSongs _searchSongs;
  final GetVersionsLimit _getVersionsLimit;
  final GetVersionLimitStateByCount _getVersionLimitStateByCount;
  final InsertVersionToSongbook _insertVersionToSongbook;
  final GetAllVersionsFromSongbook _getAllVersionsFromSongbook;
  final GetListLimitConstants _getListLimitConstants;

  AddVersionsToListBloc(
    this.songbookId,
    this._searchSongs,
    this._getProStatusStream,
    this._getVersionsLimit,
    this._getVersionLimitStateByCount,
    this._insertVersionToSongbook,
    this._getAllVersionsFromSongbook,
    this._getListLimitConstants,
  ) : super(AddVersionsToListState(songbookId: songbookId));

  StreamSubscription? _getProStatusSubscription;
  StreamSubscription? _searchRequestSubscription;
  CancelableOperation<Result<List<SongSearch>, RequestError>>? currentRequest;
  final BehaviorSubject<String> _searchQuery = BehaviorSubject();

  Future<void> init() async {
    _getProStatusSubscription = _getProStatusStream().listen(_updateProStatus);
    _searchRequestSubscription = _searchQuery.debounceTime(const Duration(milliseconds: 300)).listen(_searchRequest);
    await _updateLimitState(songbookId);
  }

  Future<void> _updateLimitState(int songbookId) async {
    final versions = await _getAllVersionsFromSongbook(songbookId);

    final count = versions.length;
    final songsId = versions.map((e) => e.songId).toList();

    emit(state.copyWith(
      limitState: _getVersionLimitStateByCount(state.isPro, count),
      songsCount: count,
      songsId: songsId,
      prolimit: _getListLimitConstants().maxListsForPro,
    ));
  }

  Future<void> _searchRequest(String query) async {
    currentRequest?.cancel();
    currentRequest = _searchSongs(query: query);
    final request = await currentRequest!.valueOrCancellation(Err(RequestCancelled()));

    request?.when(
      success: (songs) {
        emit(state.copyWith(songs: songs, isLoading: false, isHistory: query.isEmpty ? true : false));
      },
      failure: (error) {
        emit(state.copyWith(isLoading: false, isHistory: query.isEmpty ? true : false));
      },
    );
  }

  Future<void> _updateProStatus(bool isPro) async {
    final versionsLimit = _getVersionsLimit(isPro);
    emit(state.copyWith(
      versionsLimit: versionsLimit,
      isPro: isPro,
      limitState: _getVersionLimitStateByCount(state.isPro, state.songsCount),
    ));
  }

  void addOrRemoveVersion(SongSearch song) {
    final newList = state.selectedSongs.toList();
    var songsCount = state.songsCount;

    if (state.selectedSongs.contains(song)) {
      songsCount--;
      newList.remove(song);
    } else {
      newList.add(song);
      songsCount++;
    }

    emit(state.copyWith(
      selectedSongs: newList,
      songsCount: songsCount,
      limitState: _getVersionLimitStateByCount(state.isPro, songsCount),
    ));
  }

  void clearList() {
    emit(state.copyWith(songs: List.empty()));
  }

  void clearCount() {
    var songsCount = state.songsCount;
    songsCount -= state.selectedSongs.length;

    emit(state.copyWith(
      selectedSongs: List.empty(),
      songsCount: songsCount,
      limitState: _getVersionLimitStateByCount(state.isPro, songsCount),
    ));
  }

  SongState getSongState(SongSearch song) {
    if (state.selectedSongs.contains(song)) {
      return SongState.selected;
    } else if (state.songsId.any((element) => element == song.songId)) {
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

  Future<({int songsSaved, int errorCount, SongSearch? lastSongError})> addSongsToSongbook() async {
    final List<int> songsIds = [];
    SongSearch? lastSongError;
    var errorCount = 0;

    for (var song in state.selectedSongs) {
      final result = await _insertVersionToSongbook(
        songbookId: state.songbookId,
        artistUrl: song.artistUrl,
        songUrl: song.songUrl,
        isPro: state.isPro,
      );

      result.when(
        success: songsIds.add,
        failure: (error) {
          errorCount += 1;
          lastSongError = song;
        },
      );

      emit(state.copyWith(savedSongsCount: state.savedSongsCount + 1));
    }

    final songsIdState = state.songsId.toList();
    songsIdState.addAll(songsIds);

    emit(state.copyWith(
        selectedSongs: List.empty(),
        savedSongsCount: 0,
        songsId: songsIdState,
        songsCount: state.songsCount - errorCount));

    return (songsSaved: songsIds.length, errorCount: errorCount, lastSongError: lastSongError);
  }

  @override
  Future<void> close() {
    _getProStatusSubscription?.cancel();
    _searchRequestSubscription?.cancel();
    _searchQuery.close();
    return super.close();
  }
}

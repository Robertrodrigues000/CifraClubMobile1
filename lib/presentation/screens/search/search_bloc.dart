import 'dart:async';

import 'package:async/async.dart' hide Result;
import 'package:cifraclub/domain/search/models/search_filter.dart';
import 'package:cifraclub/domain/search/models/search_models/search_item.dart';
import 'package:cifraclub/domain/search/use_cases/search.dart';
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:typed_result/typed_result.dart';

class SearchBloc extends Cubit<SearchState> {
  final GetAllVersionsFromSongbook _getAllVersionsFromSongbook;
  final Search _search;

  SearchBloc(this._getAllVersionsFromSongbook, this._search) : super(const SearchState());

  CancelableOperation<Result<List<SearchItem>, RequestError>>? currentRequest;
  StreamSubscription? _searchRequestSubscription;
  final BehaviorSubject<String> _searchQuery = BehaviorSubject();

  Future<void> init() async {
    await _getAllVersionsFromSongbook(ListType.recents.localId).then((value) {
      emit(state.copyWith(recent: value));
    });
    _searchRequestSubscription = _searchQuery.debounceTime(const Duration(milliseconds: 300)).listen(_searchRequest);
  }

  void onFilterSelected(SearchFilter? searchFilter, String query) async {
    if (searchFilter != state.selectedFilter) {
      emit(state.copyWith(selectedFilter: searchFilter));
      search(query);
    }
  }

  Future<void> _searchRequest(String query) async {
    currentRequest?.cancel();
    currentRequest = _search(query: query, searchFilter: state.selectedFilter);
    final request = await currentRequest!.valueOrCancellation(Err(RequestCancelled()));

    request?.when(
      success: (value) {
        emit(state.copyWith(result: value, isLoading: false));
      },
      failure: (error) {
        emit(state.copyWith(error: error, isLoading: false));
      },
    );
  }

  void search(String query) {
    if (query.isNotEmpty) {
      emit(state.copyWith(isLoading: true, error: null, shouldShowRecent: false));
      _searchQuery.add(query);
    } else {
      emit(state.copyWith(isLoading: false, error: null, shouldShowRecent: true));
    }
  }

  void clearList() {
    emit(state.copyWith(result: List.empty(), shouldShowRecent: true, isLoading: false));
  }

  @override
  Future<void> close() {
    _searchRequestSubscription?.cancel();
    _searchQuery.close();
    return super.close();
  }
}

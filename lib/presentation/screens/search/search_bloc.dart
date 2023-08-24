import 'dart:async';

import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Cubit<SearchState> {
  final GetAllVersionsFromSongbook _getAllVersionsFromSongbook;

  SearchBloc(this._getAllVersionsFromSongbook) : super(const SearchState());

  StreamSubscription? _searchRequestSubscription;
  final BehaviorSubject<String> _searchQuery = BehaviorSubject();

  Future<void> init() async {
    await _getAllVersionsFromSongbook(ListType.recents.localId).then((value) {
      emit(state.copyWith(recent: value));
    });
    _searchRequestSubscription = _searchQuery.debounceTime(const Duration(milliseconds: 300)).listen(_searchRequest);
  }

  Future<void> _searchRequest(String query) async {
    // TODO: implement search request
    emit(state.copyWith(shouldShowRecent: query.isEmpty));
  }

  void search(String query) {
    if (!state.isLoading) {
      emit(state.copyWith(isLoading: true));
    }
    _searchQuery.add(query);
  }

  void clearList() {
    emit(state.copyWith(shouldShowRecent: true, result: List.empty()));
  }

  @override
  Future<void> close() {
    _searchRequestSubscription?.cancel();
    return super.close();
  }
}

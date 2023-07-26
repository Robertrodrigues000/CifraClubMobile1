import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Cubit<SearchState> {
  final GetAllVersionsFromSongbook _getAllVersionsFromSongbook;

  SearchBloc(this._getAllVersionsFromSongbook) : super(const SearchState());

  Future<void> init() async {
    await _getAllVersionsFromSongbook(ListType.recents.localId).then((value) {
      emit(state.copyWith(versions: value));
    });
  }
}

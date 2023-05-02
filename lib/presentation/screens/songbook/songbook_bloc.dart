import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongbookBloc extends Cubit<SongbookState> {
  SongbookBloc() : super(const SongbookState());

  void onSelectSongbook(Songbook songbook) {
    emit(state.copyWith(selectedSongbook: songbook));
  }
}

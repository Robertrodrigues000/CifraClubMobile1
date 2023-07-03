import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/use_cases/get_all_versions_from_songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionsBloc extends Cubit<VersionsState> {
  final GetAllVersionsFromSongbook _getAllVersionsFromSongbook;

  VersionsBloc(this._getAllVersionsFromSongbook) : super(const VersionsState(isPublic: true));

  Future<void> getSongbook(Songbook? songbook) async {
    final result = await _getAllVersionsFromSongbook(songbook?.id ?? 0);
    emit(
      state.copyWith(
        versions: result,
        isPublic: songbook?.isPublic,
      ),
    );
  }
}

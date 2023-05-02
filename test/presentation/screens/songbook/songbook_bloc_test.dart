import 'package:bloc_test/bloc_test.dart';
import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_bloc.dart';
import 'package:cifraclub/presentation/screens/songbook/songbook_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("When songbook change", () {
    final bloc = SongbookBloc();
    final songbook = Songbook(
      name: "Terceiro",
      isPublic: false,
      createdAt: DateTime.now(),
      totalSongs: 12,
      type: ListType.cantPlay,
    );

    blocTest("should emit a new songbook",
        build: () => bloc,
        act: (bloc) => bloc.onSelectSongbook(songbook),
        expect: () => [isA<SongbookState>().having((state) => state.selectedSongbook, "songbook", songbook)]);
  });
}

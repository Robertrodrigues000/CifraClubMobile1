import 'dart:math';

import 'package:cifraclub/domain/artist/models/artist.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/version/models/version.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/versions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VersionsBloc extends Cubit<VersionsState> {
  VersionsBloc() : super(const VersionsState(isPublic: true));

  Future<void> getSongbook(Songbook? songbook) async {
    emit(
      state.copyWith(
        versions: List.generate(
          Random().nextInt(30),
          (index) => Version(
            name: "Cifra",
            localDatabaseID: index,
            type: 1,
            artist: const Artist(url: "url", image: null, name: "name", id: 1),
            songId: 1,
            songUrl: '',
            versionId: 10,
          ),
        ),
        isPublic: songbook?.isPublic,
      ),
    );
  }
}

import 'dart:async';

import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/insert_user_genre.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin GenresCapsuleMixin<T> on Cubit<T> {
  GetUserGenresAsStream get getUserGenresAsStream;
  InsertUserGenre get insertUserGenre;
  StreamSubscription? _userGenresStreamSubscription;

  void initGenres() {
    _userGenresStreamSubscription = getUserGenresAsStream().listen(emitGenres);
  }

  void emitGenres(List<Genre> genres);

  Future<void> insertGenre(Genre genre) async {
    await insertUserGenre(genre);
    newGenre(genre);
  }

  void newGenre(Genre genre);

  @override
  Future<void> close() {
    _userGenresStreamSubscription?.cancel();
    return super.close();
  }
}

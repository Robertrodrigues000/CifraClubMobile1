import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/use_cases/get_user_genres_as_stream.dart';
import 'package:cifraclub/domain/genre/use_cases/set_user_genre.dart';
import 'package:injectable/injectable.dart';

@injectable
class InsertUserGenre {
  final SetUserGenres setUserGenres;
  final GetUserGenresAsStream getUserGenresAsStream;

  InsertUserGenre({
    required this.getUserGenresAsStream,
    required this.setUserGenres,
  });

  Future<void> call(Genre genre) async {
    var userGenres = List<Genre>.from(await getUserGenresAsStream().first);
    userGenres.remove(genre);
    userGenres.insert(0, genre);
    if (userGenres.length > 5) {
      userGenres.removeLast();
    }
    await setUserGenres(userGenres);
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cifraclub/domain/genre/models/genre.dart';
import 'package:cifraclub/domain/genre/repository/genres_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserGenresAsStream {
  final GenresRepository genresRepository;

  GetUserGenresAsStream({
    required this.genresRepository,
  });

  Stream<List<Genre>> call() {
    return genresRepository.getUserGenresAsStream().map(
          (list) => list ?? _getDefaultGenres(),
        );
  }

  List<Genre> _getDefaultGenres() {
    return const [
      Genre(name: "Rock", url: "rock"),
      Genre(name: "Sertanejo", url: "sertanejo"),
      Genre(name: "Gospel/Religioso", url: "gospelreligioso"),
      Genre(name: "MPB", url: "mpb"),
    ];
  }
}

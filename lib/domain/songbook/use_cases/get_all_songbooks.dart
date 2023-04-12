// coverage:ignore-file
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/songbook_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class GetAllSongbooks {
  final SongbookRepository _songbookRepository;

  GetAllSongbooks(this._songbookRepository);

  Future<Result<List<Songbook>, RequestError>> call() {
    return _songbookRepository.getAllSongbooks();
  }
}

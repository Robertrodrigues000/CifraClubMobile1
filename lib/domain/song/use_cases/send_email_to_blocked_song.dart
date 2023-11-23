// coverage:ignore-file
import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/domain/song/repository/song_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:typed_result/typed_result.dart';

@injectable
class SendEmailToBlockedSong {
  final SongRepository _songRepository;

  SendEmailToBlockedSong(this._songRepository);

  Future<Result<void, RequestError>> call(String email, String url) {
    return _songRepository.sendEmail(email, url);
  }
}

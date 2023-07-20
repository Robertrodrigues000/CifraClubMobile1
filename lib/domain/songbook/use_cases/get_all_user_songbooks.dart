// coverage:ignore-file
import 'package:cifraclub/domain/remote_config/use_cases/get_artist_image_path.dart';
import 'package:cifraclub/domain/remote_config/use_cases/get_image_prefix_url.dart';
import 'package:cifraclub/domain/songbook/models/songbook.dart';
import 'package:cifraclub/domain/songbook/repository/user_songbook_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllUserSongbooks {
  final UserSongbookRepository _userSongbookRepository;
  final GetImagePrefixUrl _getImagePrefixUrl;
  final GetArtistImagePathUrl _getArtistImagePathUrl;
  GetAllUserSongbooks(this._userSongbookRepository, this._getImagePrefixUrl, this._getArtistImagePathUrl);

  Stream<List<Songbook>> call() {
    final imagePrefixUrl = _getImagePrefixUrl();
    final artistImagePath = _getArtistImagePathUrl();
    return _userSongbookRepository.getAllUserSongbooks().map((songbookList) => songbookList
        .map(
          (songbook) => songbook.copyWith(
            preview: songbook.preview.map((preview) => "$imagePrefixUrl$artistImagePath${preview ?? ""}").toList(),
          ),
        )
        .toList());
  }
}

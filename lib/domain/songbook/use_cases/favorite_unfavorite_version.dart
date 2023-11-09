import 'package:cifraclub/domain/songbook/models/list_type.dart';
import 'package:cifraclub/domain/songbook/use_cases/delete_version_from_favorites_or_can_play.dart';
import 'package:cifraclub/domain/songbook/use_cases/insert_version_to_songbook.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:cifraclub/domain/songbook/models/version_options_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class FavoriteUnfavoriteVersion {
  final InsertVersionToSongbook _insertVersionToSongbook;
  final DeleteVersionFromFavoritesOrCanPlay _deleteVersionFromFavoritesOrCanPlay;
  final UserVersionRepository _userVersionRepository;

  const FavoriteUnfavoriteVersion(
    this._insertVersionToSongbook,
    this._deleteVersionFromFavoritesOrCanPlay,
    this._userVersionRepository,
  );

  Future<VersionOptionsResult> call({
    required int songId,
    required String artistUrl,
    required String songUrl,
    required bool isFavorite,
  }) async {
    final songbookId = ListType.favorites.localId;

    if (isFavorite) {
      return _unFavoriteVersion(songbookId, songId);
    }
    return _favoriteVersion(artistUrl, songUrl, songbookId);
  }

  Future<VersionOptionsResult> _unFavoriteVersion(int songbookId, int songId) async {
    final version = await _userVersionRepository.getVersionBySongId(songbookId, songId);

    if (version == null) {
      return UnFavoriteVersionError();
    }

    final result = await _deleteVersionFromFavoritesOrCanPlay(
      songbookId: songbookId,
      version: version,
    );

    if (result.isFailure) {
      return UnFavoriteVersionError();
    }
    return UnFavoriteVersionSuccess();
  }

  Future<VersionOptionsResult> _favoriteVersion(String artistUrl, String songUrl, int songbookId) async {
    final result = await _insertVersionToSongbook(artistUrl: artistUrl, songUrl: songUrl, songbookId: songbookId);
    if (result.isFailure) {
      return FavoriteVersionError();
    }
    return FavoriteVersionSuccess();
  }
}

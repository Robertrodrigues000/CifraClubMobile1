import 'package:cifraclub/data/cifra/models/user_cifra_dto.dart';
import 'package:isar/isar.dart';

class UserCifraDataSource {
  final Isar _isar;

  UserCifraDataSource(
    this._isar,
  );

  Future<List<int>> addCifrasToSongbook(List<UserCifraDto> userCifraDtos) async {
    return _isar.writeTxn(
      () async {
        return _isar.userCifraDtos.putAll(userCifraDtos);
      },
    );
  }

  Future<void> clearAllCifras() {
    return _isar.writeTxn(
      () async {
        return _isar.userCifraDtos.clear();
      },
    );
  }

  Future<List<UserCifraDto>> getCifrasFromSongbook(int songbookId) async {
    return _isar.userCifraDtos.where().songbookIdEqualTo(songbookId).findAll();
  }

  Stream<int> getTotalSongbookCifras(int songbookId) {
    return _isar.txnSync(
      () {
        return _isar.userCifraDtos
            .where()
            .songbookIdEqualTo(songbookId)
            .watch(fireImmediately: true)
            .map((e) => e.length);
      },
    );
  }

  Future<List<String?>> getImagesPreview(int songbookId) async {
    return _isar.userCifraDtos
        .where()
        .songbookIdEqualToArtistImageIsNotNull(songbookId)
        .sortByArtistImage()
        .distinctByArtistImage()
        .limit(5)
        .artistImageProperty()
        .findAll();
  }

  Future<int?> deleteCifras(int songbookId) async {
    return _isar.writeTxn(() async {
      return _isar.userCifraDtos.where().songbookIdEqualTo(songbookId).deleteAll();
    });
  }
}

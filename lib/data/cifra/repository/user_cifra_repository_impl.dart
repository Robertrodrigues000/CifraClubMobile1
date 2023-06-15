import 'package:cifraclub/data/cifra/data_source/user_cifra_data_source.dart';
import 'package:cifraclub/data/cifra/models/user_cifra_dto.dart';
import 'package:cifraclub/domain/cifra/models/cifra.dart';
import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';

class UserCifraRepositoryImpl extends UserCifraRepository {
  final UserCifraDataSource _userCifraDataSource;

  UserCifraRepositoryImpl(this._userCifraDataSource);

  @override
  Future<List<Cifra>> getUserCifrasFromSongbook(int songbookId) async {
    return (await _userCifraDataSource.getCifrasFromSongbook(songbookId)).map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<int>> addCifrasToSongbook(List<Cifra> cifras, int songbookId) {
    return _userCifraDataSource.addCifrasToSongbook(
      cifras.map((e) => UserCifraDto.fromDomain(e, songbookId)).toList(),
    );
  }

  @override
  Future<void> clearAllCifras() {
    return _userCifraDataSource.clearAllCifras();
  }

  @override
  Stream<int> getTotalSongbookCifras(int songbookId) {
    return _userCifraDataSource.getTotalSongbookCifras(songbookId);
  }

  @override
  Future<List<String?>> getImagesPreview(int songbookId) {
    return _userCifraDataSource.getImagesPreview(songbookId);
  }

  @override
  Future<int?> deleteCifrasBySongbookId(int songbookId) {
    return _userCifraDataSource.deleteCifras(songbookId);
  }
}

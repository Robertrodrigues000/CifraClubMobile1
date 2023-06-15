import 'package:cifraclub/domain/cifra/models/cifra.dart';

abstract class UserCifraRepository {
  Future<List<int>> addCifrasToSongbook(List<Cifra> cifras, int songbookId);
  Future<List<Cifra>> getUserCifrasFromSongbook(int songbookId);
  Future<void> clearAllCifras();
  Stream<int> getTotalSongbookCifras(int songbookId);
  Future<List<String?>> getImagesPreview(int songbookId);
  Future<int?> deleteCifrasBySongbookId(int songbookId);
}

import 'package:cifraclub/domain/cifra/models/cifra.dart';

abstract class CifraRepository {
  Future<void> addUserCifraToSongbook(Cifra cifra);
  Future<List<Cifra>?> getUserCifrasFromSongbook(int songbookId);
}

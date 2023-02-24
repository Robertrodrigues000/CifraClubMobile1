import 'package:cifraclub/domain/songbook/models/songbook.dart';

abstract class SongbookRepository {
  Stream<List<Songbook>> getAllUserSongbooks();
  Future<int> insertUserSongbook(Songbook songbook);
}

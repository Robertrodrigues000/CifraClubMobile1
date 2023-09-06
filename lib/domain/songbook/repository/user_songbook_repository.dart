import 'package:cifraclub/domain/songbook/models/songbook.dart';

abstract class UserSongbookRepository {
  Stream<List<Songbook>> getAllUserSongbooks();
  Future<int> putUserSongbook(Songbook songbook);
  Future<List<int>> setUserSongbooks(List<Songbook> songbooks);
  Future<bool> deleteUserSongbook(int songbookId);
  Stream<int> getTotalSongbooks();
  Future<Songbook?> getSongbookById(int id);
  Stream<Songbook?> getSongbookStreamById(int? id);
  Future<int?> updateSongbookPreview(int songbookId, List<String?> preview);
  Future<void> deleteAll();
  Future<int?> updateTotalSongs({required int songbookId});
}

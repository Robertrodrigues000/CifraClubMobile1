import 'package:cifraclub/domain/songbook/models/songbook.dart';

abstract class UserSongbookRepository {
  Stream<List<Songbook>> getAllUserSongbooks();
  Future<int> insertUserSongbook(Songbook songbook);
  Future<List<int>> setUserSongbooks(List<Songbook> songbooks);
  Future<bool> deleteUserSongbook(int songbookId);
  Stream<int> getTotalSongbooks();
  Stream<int?> getTotalSongbookCifras(int songbookId);
  Future<Songbook?> getSongbookById(int id);
  Future<int?> deleteCifras(int songbookId);
  Future<List<int>?> getCifrasIds(int songbookId);
}

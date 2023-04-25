import 'package:cifraclub/domain/songbook/models/songbook.dart';

abstract class UserSongbookRepository {
  Stream<List<Songbook>> getAllUserSongbooks();
  Future<int> insertUserSongbook(Songbook songbook);
  Future<List<int>> setUserSongbooks(List<Songbook> songbooks);
}

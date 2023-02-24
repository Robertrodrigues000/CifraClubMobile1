import 'package:cifraclub/data/songbook/models/user_cifra_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:isar/isar.dart';

class UserCifraDataSource {
  Isar isar;
  UserCifraDataSource({
    required this.isar,
  });

  Future<void> addCifraToSongbook(int songbookId, UserCifraDto userCifraDto) async {
    await isar.writeTxn(
      () async {
        final songBook = await isar.userSongbookDtos.get(songbookId);
        await isar.userCifraDtos.put(userCifraDto);
        songBook?.userCifras.add(userCifraDto);
        await songBook?.userCifras.save();
      },
    );
  }

  Future<List<UserCifraDto>?> getCifrasFromSongbook(int songbookId) async {
    final songBook = await isar.userSongbookDtos.get(songbookId);
    await songBook?.userCifras.load();
    return songBook?.userCifras.toList();
  }
}

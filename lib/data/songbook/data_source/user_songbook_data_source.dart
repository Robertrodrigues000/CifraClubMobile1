import 'package:cifraclub/data/songbook/models/list_type_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/domain/log/repository/log_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:rxdart/rxdart.dart';

class UserSongbookDataSource {
  final Isar _isar;

  UserSongbookDataSource(this._isar);

  Stream<List<UserSongbookDto>> getAll() {
    Query<UserSongbookDto> query = _isar.userSongbookDtos.where().build();
    return query.watch(fireImmediately: true);
  }

  Future<void> deleteAll() {
    return _isar.writeTxn(
      () async {
        return _isar.userSongbookDtos.clear();
      },
    );
  }

  /// Insert or update a songbook
  Future<int> insert(UserSongbookDto userSongbookDto) async {
    if (userSongbookDto.id == Isar.autoIncrement) {
      throw Exception("Songbook should have an id set");
    }

    return _isar.writeTxn(
      () async {
        return _isar.userSongbookDtos.put(userSongbookDto);
      },
    );
  }

  Stream<int> getTotalSongbooks() {
    Query<UserSongbookDto> query = _isar.userSongbookDtos.filter().typeEqualTo(ListTypeDto.user).build();
    return query.watch(fireImmediately: true).map((songbookList) => songbookList.length);
  }

  Future<UserSongbookDto?> getSongbookById(int id) {
    return _isar.userSongbookDtos.filter().idEqualTo(id).findFirst();
  }

  Stream<UserSongbookDto?> getSongbookStreamById(int? id) {
    if (id == null) {
      logger?.log(tag: runtimeType.toString(), message: "Songbook Id is null"); // coverage:ignore-line
      return BehaviorSubject.seeded(null);
    }

    return _isar.userSongbookDtos.watchObject(id, fireImmediately: true);
  }

  /// Remove all songbooks, then insert all songbooks from [userSongbookDtos]
  Future<List<int>> setAll(List<UserSongbookDto> userSongbookDtos) async {
    if (userSongbookDtos.any((element) => element.id == Isar.autoIncrement)) {
      throw Exception("Songbook should have an id set");
    }

    return _isar.writeTxn(
      () async {
        await _isar.userSongbookDtos.clear();
        return _isar.userSongbookDtos.putAll(userSongbookDtos);
      },
    );
  }

  Future<bool> deleteSongbook(int songbookId) async {
    return _isar.writeTxn(() async {
      return _isar.userSongbookDtos.delete(songbookId);
    });
  }

  Future<int?> updatePreview(int songbookId, List<String?> preview) async {
    return _isar.writeTxn(() async {
      final songbook = await _isar.userSongbookDtos.where().idEqualTo(songbookId).findFirst();
      final updatedSongbook = songbook?.copyWith(preview: preview);
      if (updatedSongbook == null) {
        return SynchronousFuture(null);
      }
      return _isar.userSongbookDtos.put(updatedSongbook);
    });
  }
}

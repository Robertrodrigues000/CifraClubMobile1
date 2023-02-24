// coverage:ignore-file
import 'dart:io';

import 'package:cifraclub/data/genre/models/user_genre/user_genres_dto.dart';
import 'package:cifraclub/data/songbook/models/user_cifra_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

const isarAppSchemas = [UserGenresDtoSchema, UserSongbookDtoSchema, UserCifraDtoSchema];

@module
abstract class IsarModule {
  @preResolve
  @singleton
  Future<Isar> getIsar(@Named("InternalDocuments") Directory internalDocuments) {
    return Isar.open(isarAppSchemas, directory: internalDocuments.path);
  }
}

// coverage:ignore-file
import 'dart:io';

import 'package:cifraclub/data/genre/models/user_genre/user_genres_dto.dart';
import 'package:cifraclub/data/version/models/user_version_dto.dart';
import 'package:cifraclub/data/songbook/models/user_songbook_dto.dart';
import 'package:cifraclub/data/subscription/models/persisted_purchase_dto.dart';
import 'package:cifraclub/data/version/models/user_recent_version_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

const isarAppSchemas = [
  UserGenresDtoSchema,
  UserSongbookDtoSchema,
  UserVersionDtoSchema,
  PersistedPurchaseDtoSchema,
  UserRecentVersionDtoSchema,
];

@module
abstract class IsarModule {
  @preResolve
  @singleton
  Future<Isar> getIsar(@Named("InternalDocuments") Directory internalDocuments) {
    return Isar.open(isarAppSchemas, directory: internalDocuments.path);
  }
}

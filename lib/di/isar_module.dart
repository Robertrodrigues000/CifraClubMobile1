// coverage:ignore-file
import 'dart:io';

import 'package:cifraclub/data/genre/models/user_genre/user_genres_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

const isarAppSchemas = [UserGenresDtoSchema];

@module
abstract class IsarModule {
  @preResolve
  @singleton
  Future<Isar> getIsar(@Named("InternalDocuments") Directory internalDocuments) {
    return Isar.open(isarAppSchemas, directory: internalDocuments.path);
  }
}

// coverage:ignore-file
import 'package:cifraclub/data/version/data_source/user_version_data_source.dart';
import 'package:cifraclub/data/version/repository/user_version_repository_impl.dart';
import 'package:cifraclub/domain/version/repository/user_version_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@module
abstract class VersionModule {
  UserVersionDataSource getUserVersionDataSource(Isar isar) {
    return UserVersionDataSource(isar);
  }

  UserVersionRepository getUserVersionRepository(UserVersionDataSource userVersionDataSource) {
    return UserVersionRepositoryImpl(userVersionDataSource);
  }
}

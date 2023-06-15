// coverage:ignore-file
import 'package:cifraclub/data/cifra/data_source/user_cifra_data_source.dart';
import 'package:cifraclub/data/cifra/repository/user_cifra_repository_impl.dart';
import 'package:cifraclub/domain/cifra/repository/user_cifra_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@module
abstract class CifraModule {
  UserCifraDataSource getUserCifraDataSource(Isar isar) {
    return UserCifraDataSource(isar);
  }

  UserCifraRepository getUserCifraRepository(UserCifraDataSource userCifraDataSource) {
    return UserCifraRepositoryImpl(userCifraDataSource);
  }
}

// coverage:ignore-file
import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferencesModule {
  @singleton
  @preResolve
  Future<SharedPreferences> getSharedPreferences() {
    return SharedPreferences.getInstance();
  }

  SharedPreferencesRepository getPreferencesRepository(SharedPreferences sharedPreferences) {
    return SharedPreferencesRepositoryImpl(sharedPreferences);
  }
}

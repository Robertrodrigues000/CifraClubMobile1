import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {
  final SharedPreferences _prefs;
  SharedPreferencesRepositoryImpl(this._prefs);

  @override
  Future<bool> setBool(SharedPreferencesKeys preferencesKeys, bool value) {
    return _prefs.setBool(preferencesKeys.key, value);
  }

  @override
  bool? getBool(SharedPreferencesKeys preferencesKeys) {
    return _prefs.getBool(preferencesKeys.key);
  }

  @override
  Future<bool> setString(SharedPreferencesKeys preferencesKeys, String value) {
    return _prefs.setString(preferencesKeys.key, value);
  }

  @override
  String? getString(SharedPreferencesKeys preferencesKeys) {
    return _prefs.getString(preferencesKeys.key);
  }

  @override
  int? getInt(SharedPreferencesKeys preferencesKeys) {
    return _prefs.getInt(preferencesKeys.key);
  }

  @override
  Future<bool> setInt(SharedPreferencesKeys preferencesKeys, int value) {
    return _prefs.setInt(preferencesKeys.key, value);
  }
}

enum SharedPreferencesKeys {
  pro("PRO_KEY"),
  orderType("LAST_FILTER"),
  fontSize("FONT_SIZE");

  final String key;
  const SharedPreferencesKeys(this.key);
}

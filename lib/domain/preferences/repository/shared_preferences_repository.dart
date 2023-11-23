import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';

abstract class SharedPreferencesRepository {
  Future<bool> setBool(SharedPreferencesKeys preferencesKeys, bool value);
  bool? getBool(SharedPreferencesKeys preferencesKeys);
  Future<bool> setString(SharedPreferencesKeys preferencesKeys, String value);
  String? getString(SharedPreferencesKeys preferencesKeys);
  Future<bool> setInt(SharedPreferencesKeys preferencesKeys, int value);
  int? getInt(SharedPreferencesKeys preferencesKeys);
}

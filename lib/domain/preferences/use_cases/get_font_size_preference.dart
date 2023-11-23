// coverage:ignore-file
import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFontSizePreference {
  static const defaultValue = 14;
  static const minValue = 8;
  static const maxValue = 24;

  final SharedPreferencesRepository _preferencesRepository;

  const GetFontSizePreference(this._preferencesRepository);

  int call() {
    return _preferencesRepository.getInt(SharedPreferencesKeys.fontSize) ?? defaultValue;
  }
}

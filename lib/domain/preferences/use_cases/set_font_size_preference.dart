// coverage:ignore-file
import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetFontSizePreference {
  final SharedPreferencesRepository _preferencesRepository;

  const SetFontSizePreference(this._preferencesRepository);

  Future<bool> call(int value) async {
    return _preferencesRepository.setInt(SharedPreferencesKeys.fontSize, value);
  }
}

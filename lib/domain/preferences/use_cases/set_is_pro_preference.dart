// coverage:ignore-file
import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetIsProPreference {
  final SharedPreferencesRepository _preferencesRepository;

  const SetIsProPreference(this._preferencesRepository);

  Future<bool> call(bool value) async {
    return _preferencesRepository.setBool(SharedPreferencesKeys.pro, value);
  }
}

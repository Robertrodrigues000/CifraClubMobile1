// coverage:ignore-file
import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetIsProPreference {
  final SharedPreferencesRepository _preferencesRepository;

  const GetIsProPreference(this._preferencesRepository);

  bool? call() {
    return _preferencesRepository.getBool(SharedPreferencesKeys.pro) ?? false;
  }
}

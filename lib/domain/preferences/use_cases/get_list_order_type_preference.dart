// coverage:ignore-file
import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetListOrderTypePreferences {
  final SharedPreferencesRepository _preferencesRepository;

  const GetListOrderTypePreferences(this._preferencesRepository);

  String? call() {
    return _preferencesRepository.getString(SharedPreferencesKeys.orderType);
  }
}

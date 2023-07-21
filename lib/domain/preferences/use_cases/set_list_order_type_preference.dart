// coverage:ignore-file
import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:cifraclub/domain/preferences/repository/shared_preferences_repository.dart';
import 'package:cifraclub/presentation/screens/songbook/versions/widgets/list_order_type.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetListOrderTypePreferences {
  final SharedPreferencesRepository _preferencesRepository;

  const SetListOrderTypePreferences(this._preferencesRepository);

  Future<bool> call(ListOrderType orderType) async {
    return _preferencesRepository.setString(SharedPreferencesKeys.orderType, orderType.key);
  }
}

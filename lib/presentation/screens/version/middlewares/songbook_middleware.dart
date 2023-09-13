import 'package:cifraclub/domain/songbook/use_cases/insert_version_data_to_recents.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/version_middleware.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SongbookMiddleware extends VersionMiddleware {
  final InsertVersionDataToRecents _insertVersionDataToRecents;

  SongbookMiddleware(this._insertVersionDataToRecents);

  @override
  void onAction(VersionAction action, VersionState state, ActionEmitter addAction) {
    if (action is OnVersionLoaded) {
      _insertVersionDataToRecents(versionData: action.versionData);
    }
  }
}

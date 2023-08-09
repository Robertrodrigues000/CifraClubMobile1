// coverage:ignore-file
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';

abstract class VersionMiddleware {
  void onAction(VersionAction action, VersionState state, Function(VersionAction) addAction);
}

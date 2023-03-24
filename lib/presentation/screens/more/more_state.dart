import 'package:cifraclub/domain/user/models/user.dart';
import 'package:cifraclub/presentation/screens/more/models/app_item.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'more_state.g.dart';

@CopyWith()
class MoreState {
  final User? user;
  final List<AppItem> installedApps;

  MoreState({
    this.user,
    this.installedApps = const [],
  });
}

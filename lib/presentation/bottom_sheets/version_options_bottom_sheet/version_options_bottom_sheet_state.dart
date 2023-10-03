import 'package:copy_with_extension/copy_with_extension.dart';

part 'version_options_bottom_sheet_state.g.dart';

@CopyWith()
class VersionOptionsBottomSheetState {
  final bool isLoggedIn;
  final bool isFavorite;

  const VersionOptionsBottomSheetState({
    this.isLoggedIn = false,
    this.isFavorite = false,
  });
}

// All screenEntries that are the first entry in bottom navigation must implement this
abstract class BottomNavigationTapHandler {
  // ignore: comment_references
  /// This method is called by [MainScreenBloc] when the user taps on the already selected bottom navigation item
  void onReselected(bool wasAlreadyOpen);
}

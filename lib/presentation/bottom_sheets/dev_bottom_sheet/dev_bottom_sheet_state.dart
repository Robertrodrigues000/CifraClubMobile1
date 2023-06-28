// coverage:ignore-file
abstract class DevBottomSheetState {}

class DevBottomSheetLoadingState extends DevBottomSheetState {}

class DevBottomSheetLoadedState extends DevBottomSheetState {
  final List<String> genres;

  DevBottomSheetLoadedState({required this.genres});
}

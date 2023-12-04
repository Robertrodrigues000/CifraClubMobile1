import 'package:cifraclub/presentation/constants/app_svgs.dart';

enum SongSelectionState {
  added(icon: null),
  toAdd(icon: AppSvgs.addVersionIcon),
  selected(icon: AppSvgs.selectedVersionIcon);

  const SongSelectionState({required this.icon});

  final String? icon;
}

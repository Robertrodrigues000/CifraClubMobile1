import 'package:cifraclub/presentation/constants/app_svgs.dart';

enum SongState {
  added(icon: null),
  toAdd(icon: AppSvgs.addVersionIcon),
  selected(icon: AppSvgs.selectedVersionIcon);

  const SongState({required this.icon});

  final String? icon;
}

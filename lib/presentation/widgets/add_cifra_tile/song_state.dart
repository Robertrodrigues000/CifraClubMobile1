import 'package:cifraclub/presentation/constants/app_svgs.dart';

enum SongState {
  added(icon: null),
  toAdd(icon: AppSvgs.addCifraIcon),
  selected(icon: AppSvgs.selectedCifraIcon);

  const SongState({required this.icon});

  final String? icon;
}

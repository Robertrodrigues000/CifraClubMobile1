// coverage:ignore-file
import 'package:cifraclub/domain/device/url_launcher/use_cases/open_url.dart';
import 'package:cifraclub/presentation/screens/contrib/contrib_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContribScreenBloc extends Cubit<ContribScreenState> {
  final OpenUrl _openUrl;

  ContribScreenBloc(
    this._openUrl,
  ) : super(const ContribScreenState(isLoading: false));

  Future<void> openUrl(String url) => _openUrl(url);

  String? getYoutubeThumbnail() {
    const videoUrl = 'https://www.youtube.com/watch?v=2Rsz3JEbw0Y&ab';

    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
}

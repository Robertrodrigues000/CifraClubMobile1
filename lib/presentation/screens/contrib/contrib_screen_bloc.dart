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
}

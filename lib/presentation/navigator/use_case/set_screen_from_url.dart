import 'dart:async';

import 'package:cifraclub/presentation/navigator/deep_link_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:nav/nav.dart';

@singleton
@injectable
class SetScreenFromUrl {
  final DeepLinkParser _deepLinkParser;
  final _streamController = StreamController<List<ScreenEntry>>();

  late final Stream<List<ScreenEntry>> _stream = _streamController.stream.asBroadcastStream();

  SetScreenFromUrl(this._deepLinkParser);

  void call(String url) {
    final entries = _deepLinkParser.parseUrl(url);
    if (entries != null && entries.isNotEmpty) {
      _streamController.add(entries);
    }
  }

  // coverage:ignore-start
  @disposeMethod
  void dispose() {
    _streamController.close();
  }
// coverage:ignore-end
}

// To protect `_streamController`, we place [OnNewScreenSet] and [SetScreenFromUrl] in same file
@injectable
@singleton
class OnNewScreenSet {
  final SetScreenFromUrl _setScreenFromUrl;

  const OnNewScreenSet(this._setScreenFromUrl);

  Stream<List<ScreenEntry>> call() => _setScreenFromUrl._stream;
}

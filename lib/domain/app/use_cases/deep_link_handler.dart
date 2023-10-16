import 'package:cifraclub/presentation/navigator/use_case/set_screen_from_url.dart';

class DeepLinkHandler {
  static const tag = "DeepLinkHandler";
  final Future<String?> Function() _getInitialDeepLink;
  final Stream<String?> _deepLinkStream;
  final SetScreenFromUrl _setScreenFromUrl;

  const DeepLinkHandler({
    required Future<String?> Function() getInitialDeepLink,
    required SetScreenFromUrl setScreenFromUrl,
    required Stream<String?> deepLinkStream,
  })  : _getInitialDeepLink = getInitialDeepLink,
        _deepLinkStream = deepLinkStream,
        _setScreenFromUrl = setScreenFromUrl;

  Future<String?> consumeOrGetFirstDeepLink() => _getInitialDeepLink();

  Future<void> handleDeepLinks() async {
    await for (final deepLink in _deepLinkStream) {
      if (deepLink != null) {
        _setScreenFromUrl(deepLink);
      }
    }
  }
}

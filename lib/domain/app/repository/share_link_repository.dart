import 'dart:ui';

import 'package:share_plus/share_plus.dart';

abstract class ShareLinkRepository {
  Future<ShareResult> shareLink({required String link, String? subject, Rect? sharePositionOrigin});
}

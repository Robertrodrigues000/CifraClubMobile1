// coverage:ignore-file
import 'dart:ui';
import 'package:cifraclub/domain/app/repository/share_link_repository.dart';
import 'package:share_plus/share_plus.dart';

class ShareLinkRepositoryImpl extends ShareLinkRepository {
  ShareLinkRepositoryImpl();

  @override
  Future<ShareResult> shareLink({required String link, String? subject, Rect? sharePositionOrigin}) async {
    final shareResult = Share.shareWithResult(
      link,
      subject: subject,
      sharePositionOrigin: sharePositionOrigin,
    );

    return shareResult;
  }
}

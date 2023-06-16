// coverage:ignore-file
import 'dart:ui';
import 'package:cifraclub/domain/app/repository/share_link_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

@injectable
class ShareLink {
  final ShareLinkRepository _shareLinkRepository;

  const ShareLink(this._shareLinkRepository);

  Future<ShareResult> call({required String link, String? subject, Rect? sharePositionOrigin}) {
    return _shareLinkRepository.shareLink(link: link, subject: subject, sharePositionOrigin: sharePositionOrigin);
  }
}

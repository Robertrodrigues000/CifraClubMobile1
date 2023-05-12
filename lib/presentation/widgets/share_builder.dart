import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareLinkBuilder extends StatelessWidget {
  final String link;
  final String? subject;
  final Widget Function(BuildContext context, Future<ShareResult> Function() shareLink) builder;

  const ShareLinkBuilder({
    super.key,
    required this.link,
    this.subject,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) => builder(context, () => _shareLink(link: link, context: context));
}

Future<ShareResult> _shareLink({required String link, required BuildContext context, String? subject}) {
  final box = context.findRenderObject() as RenderBox?;
  final shareResult = Share.shareWithResult(
    link,
    subject: subject,
    sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
  );
  return shareResult;
}

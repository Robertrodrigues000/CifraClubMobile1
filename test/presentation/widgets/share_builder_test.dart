import 'dart:async';

import 'package:cifraclub/presentation/constants/app_urls.dart';
import 'package:cifraclub/presentation/widgets/share_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plus/share_plus.dart';

import '../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tap on widget call the shareLinkBuilder callback", (widgetTester) async {
    final completer = Completer<Future<ShareResult>>();

    await widgetTester.pumpWidgetWithWrapper(ShareLinkBuilder(
      builder: (context, shareLink) {
        return InkWell(
          onTap: () async {
            final shareResult = shareLink();
            completer.complete(shareResult);
          },
          child: const SizedBox(height: 150, width: 150),
        );
      },
      link: 'link',
    ));

    await widgetTester.tap(find.byType(InkWell));

    expect(completer.isCompleted, isTrue);
    expect(await completer.future, isInstanceOf<Future<ShareResult>>());
  });

  test("Building correctly ulr by params", () {
    const fakeCCID = 1222156230;
    const fakeIdCC = 22045223;

    final url = AppUrls.cifraListUrlFormat(fakeCCID, fakeIdCC);

    expect(url, "https://m.cifraclub.com.br/musico/1222156230/repertorio/22045223/");
  });
}

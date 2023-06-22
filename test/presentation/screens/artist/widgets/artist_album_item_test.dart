import 'dart:async';

import 'package:cifraclub/presentation/screens/artist/widgets/album_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../shared_mocks/domain/artist/models/album_mock.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tapping an item, should call onTap", (widgetTester) async {
    final completer = Completer();
    await widgetTester.pumpWidget(TestWrapper(
      child: AlbumItem(
        key: const Key('album item'),
        size: 60,
        onTap: completer.complete,
        album: getFakeAlbum(),
      ),
    ));
    await widgetTester.tap(find.byKey(const Key("album item")));
    expect(completer.isCompleted, isTrue);
  });
}

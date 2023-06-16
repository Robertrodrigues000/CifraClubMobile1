import 'dart:async';

import 'package:cifraclub/presentation/screens/home/widgets/home_top_cifras.dart';
import 'package:cifraclub/presentation/widgets/top_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../../shared_mocks/domain/song/models/song_mock.dart';
import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When topSongs is not empty should show top list items", (widgetTester) async {
    final songs = [getFakeSong(), getFakeSong()];

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(TestWrapper(
        child: CustomScrollView(
          slivers: [
            HomeTopCifras(
              topSongs: songs,
              onTap: (_) {},
            ),
          ],
        ),
      ));
    });

    await widgetTester.pumpAndSettle();

    expect(find.byType(TopListItem), findsNWidgets(2));
  });

  testWidgets("When tapping an item should call onTap", (widgetTester) async {
    final completer = Completer();
    final songs = getFakeSong();

    await widgetTester.pumpWidget(TestWrapper(
      child: CustomScrollView(
        slivers: [
          HomeTopCifras(
            topSongs: [songs],
            onTap: completer.complete,
          ),
        ],
      ),
    ));

    await widgetTester.pumpAndSettle();
    await widgetTester.tap(find.text(songs.name));

    expect(completer.isCompleted, isTrue);
  });
}

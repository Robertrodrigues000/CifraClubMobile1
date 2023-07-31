import 'dart:async';
import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/artist/widgets/artist_song_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tapping an item, should call onTap", (widgetTester) async {
    final completer = Completer();
    await widgetTester.pumpWidget(TestWrapper(
      child: ArtistSongItem(
        key: const Key('artist-song'),
        name: "Legiao Urbana",
        prefix: "1",
        onTap: completer.complete,
        onOptionsTap: () {},
        hasVideoLessons: false,
        isVerified: false,
      ),
    ));
    await widgetTester.tap(find.byKey(const Key("artist-song")));
    expect(completer.isCompleted, isTrue);
  });

  testWidgets("when hasVideoLessons is true should show subtitle", (widgetTester) async {
    await widgetTester.pumpWidget(TestWrapper(
      child: ArtistSongItem(
        key: const Key('artist-song'),
        name: "Legiao Urbana",
        prefix: "1",
        onTap: () {},
        onOptionsTap: () {},
        hasVideoLessons: true,
        isVerified: false,
      ),
    ));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate(
          (Widget widget) {
            return widget is SvgPicture &&
                widget.pictureProvider is ExactAssetPicture &&
                (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.videoLessonIcon;
          },
          description: 'video lesson icon',
        ),
        findsOneWidget);
  });

  testWidgets("when isVerified is true, should show verified icon", (widgetTester) async {
    await widgetTester.pumpWidget(TestWrapper(
      child: ArtistSongItem(
        key: const Key('artist-song'),
        name: "Legiao Urbana",
        prefix: "1",
        onTap: () {},
        onOptionsTap: () {},
        hasVideoLessons: false,
        isVerified: true,
      ),
    ));
    await widgetTester.pumpAndSettle();

    expect(
        find.byWidgetPredicate(
          (Widget widget) {
            return widget is SvgPicture &&
                widget.pictureProvider is ExactAssetPicture &&
                (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.verifiedIcon;
          },
          description: 'verified icon',
        ),
        findsOneWidget);
  });

  testWidgets("when isEnable is false should hide overflow", (widgetTester) async {
    await widgetTester.pumpWidget(TestWrapper(
      child: ArtistSongItem(
        key: const Key('artist-song'),
        name: "Legiao Urbana",
        prefix: "1",
        onTap: () {},
        onOptionsTap: () {},
        hasVideoLessons: false,
        isVerified: false,
        isEnable: false,
      ),
    ));
    await widgetTester.pumpAndSettle();

    final overflowWidget = find.byWidgetPredicate(
      (Widget widget) {
        return widget is SvgPicture &&
            widget.pictureProvider is ExactAssetPicture &&
            (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.overflowIcon;
      },
      description: 'overflow icon',
    );
    expect(overflowWidget, findsNothing);
  });
}

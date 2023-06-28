import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/song_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../test_helpers/app_localizations.dart';
import '../../../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tapping a tile, should call onTap", (tester) async {
    var isTapped = false;

    await tester.pumpWidget(
      TestWrapper(
        child: AddVersionTile(
          onTap: () => isTapped = true,
          imageUrl: "",
          song: "Musica",
          artist: "Artista",
          state: SongState.toAdd,
        ),
      ),
    );

    await tester.tap(find.byType(AddVersionTile));
    expect(isTapped, true);
  });

  group("When state is", () {
    testWidgets(" toAdd, should show toAdd icon", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: AddVersionTile(
            onTap: () {},
            imageUrl: "",
            song: "Musica",
            artist: "Artista",
            state: SongState.toAdd,
          ),
        ),
      );

      expect(
          find.byWidgetPredicate(
            (Widget widget) {
              return widget is SvgPicture &&
                  widget.pictureProvider is ExactAssetPicture &&
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addVersionIcon;
            },
            description: 'widget with add cifra icon',
          ),
          findsOneWidget);
    });

    testWidgets("added, should show on the list text", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: AddVersionTile(
            onTap: () {},
            imageUrl: "",
            song: "Musica",
            artist: "Artista",
            state: SongState.added,
          ),
        ),
      );

      expect(find.text(appTextEn.onList), findsOneWidget);
    });

    testWidgets(" selected, should show selected icon", (widgetTester) async {
      await widgetTester.pumpWidget(TestWrapper(
        child: AddVersionTile(
            key: const Key("Musica"),
            onTap: () {},
            imageUrl: "",
            song: "Musica",
            artist: "Artista",
            state: SongState.selected),
      ));

      expect(
          find.byWidgetPredicate(
            (Widget widget) {
              return widget is SvgPicture &&
                  widget.pictureProvider is ExactAssetPicture &&
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.selectedVersionIcon;
            },
            description: 'widget with selected cifra icon',
          ),
          findsOneWidget);
    });
  });

  testWidgets("when imageUrl is null or empty, should show correct avatar placeholder", (tester) async {
    await tester.pumpWidget(TestWrapper(
      child: AddVersionTile(
        imageUrl: null,
        artist: "Artista",
        song: "Musica",
        onTap: () {},
        state: SongState.selected,
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key("avatarPlaceHolder")), findsOneWidget);
  });
}

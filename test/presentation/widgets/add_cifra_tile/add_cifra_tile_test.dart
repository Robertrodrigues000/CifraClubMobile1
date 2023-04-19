import 'package:cifraclub/presentation/constants/app_svgs.dart';
import 'package:cifraclub/presentation/widgets/add_cifra_tile/add_cifra_tile.dart';
import 'package:cifraclub/presentation/widgets/add_cifra_tile/song_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When tapping a tile, should call onTap", (tester) async {
    var isTapped = false;

    await tester.pumpWidget(
      TestWrapper(
        child: AddCifraTile(
          onTap: () => isTapped = true,
          imageUrl: "",
          song: "Musica",
          artist: "Artista",
          state: SongState.toAdd,
        ),
      ),
    );

    await tester.tap(find.byType(AddCifraTile));
    expect(isTapped, true);
  });

  group("When state is", () {
    testWidgets(" toAdd, should show toAdd icon", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: AddCifraTile(
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
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.addCifraIcon;
            },
            description: 'widget with add cifra icon',
          ),
          findsOneWidget);
    });

    testWidgets("added, should show on the list text", (tester) async {
      await tester.pumpWidget(
        TestWrapper(
          child: AddCifraTile(
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
        child: AddCifraTile(
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
                  (widget.pictureProvider as ExactAssetPicture).assetName == AppSvgs.selectedCifraIcon;
            },
            description: 'widget with selected cifra icon',
          ),
          findsOneWidget);
    });
  });

  testWidgets("when imageUrl is null or empty, should show correct avatar placeholder", (tester) async {
    await tester.pumpWidget(TestWrapper(
      child: AddCifraTile(
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

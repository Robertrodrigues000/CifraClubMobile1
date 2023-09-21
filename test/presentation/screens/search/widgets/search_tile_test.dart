import 'package:cifraclub/presentation/screens/search/widgets/search_tile.dart';
import 'package:cifraclub/presentation/screens/songbook/lists/widgets/list_image_group.dart';
import 'package:cifraclub/presentation/widgets/remote_image/remote_image.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("When listPreview is not null should show ListImageGroup", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(SearchTile(
      onTap: () {},
      title: "result",
      listPreview: const [],
    ));
    expect(find.byType(ListImageGroup), findsOneWidget);
  });

  testWidgets("When imageUrl is not null and listPreview is null should show one image", (widgetTester) async {
    await widgetTester.pumpWidgetWithWrapper(SearchTile(
      onTap: () {},
      title: "result",
      imageUrl: "",
    ));
    expect(find.byType(RemoteImage), findsOneWidget);
  });
}

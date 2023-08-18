import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_bloc.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/listen_bottom_sheet_state.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/widgets/library_video_item.dart';
import 'package:cifraclub/presentation/bottom_sheets/listen_bottom_sheet/widgets/youtube_video_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _ListenBottomSheetBlocMock extends Mock implements ListenBottomSheetBloc {}

void main() {
  late _ListenBottomSheetBlocMock bloc;

  setUpAll(() {
    bloc = _ListenBottomSheetBlocMock();
    when(bloc.close).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When tap on tab bar should change to corretly tab", (widgetTester) async {
    bloc.mockStream(const ListenBottomSheetState());

    await widgetTester.pumpWidgetWithWrapper(
      Builder(
        builder: (context) {
          return Scaffold(
            body: InkWell(
              onTap: () {
                ListenBottomSheet().show(context: context, bloc: bloc);
              },
            ),
          );
        },
      ),
    );

    expect(find.byType(InkWell), findsOneWidget);
    await widgetTester.tap(find.byType(InkWell));
    await widgetTester.pumpAndSettle();

    expect(find.byType(YouTubeVideoItem), findsWidgets);

    await widgetTester.tap(find.text(appTextEn.library));
    await widgetTester.pumpAndSettle();
    expect(find.byType(LibraryVideoItem), findsWidgets);
  });
}

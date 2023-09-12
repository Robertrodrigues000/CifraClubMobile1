import 'package:cifraclub/domain/shared/request_error.dart';
import 'package:cifraclub/presentation/screens/search/search_bloc.dart';
import 'package:cifraclub/presentation/screens/search/search_screen.dart';
import 'package:cifraclub/presentation/screens/search/search_state.dart';
import 'package:cifraclub/presentation/screens/songbook/add_versions_to_list/widgets/add_version_tile/add_version_tile.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../shared_mocks/domain/version/models/version_mock.dart';
import '../../../test_helpers/app_localizations.dart';
import '../../../test_helpers/bloc_stream.dart';
import '../../../test_helpers/test_wrapper.dart';

class _SearchBlocMock extends Mock implements SearchBloc {}

void main() {
  late SearchBloc bloc;

  setUpAll(() {
    bloc = _SearchBlocMock();
    when(bloc.init).thenAnswer((_) => SynchronousFuture(null));
  });

  testWidgets("When state error is not null then error description widget should be displayed", (widgetTester) async {
    bloc.mockStream(SearchState(error: ServerError(), shouldShowRecent: false));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<SearchBloc>.value(
          value: bloc,
          child: const SearchScreen(),
        ),
      ),
    );

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text(appTextEn.serverErrorTitle), findsOneWidget);
  });

  testWidgets("When result is empty then search not found error description widget should be displayed",
      (widgetTester) async {
    bloc.mockStream(const SearchState(result: [], shouldShowRecent: false));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<SearchBloc>.value(
          value: bloc,
          child: const SearchScreen(),
        ),
      ),
    );
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, "query");

    when(() => bloc.search("query")).thenReturn(null);
    await widgetTester.pumpAndSettle();

    expect(find.byType(ErrorDescriptionWidget), findsOneWidget);
    expect(find.text(appTextEn.searchResultNotFoundDescription), findsOneWidget);
  });

  testWidgets("When recent is not empty then show list of recent versions", (widgetTester) async {
    bloc.mockStream(SearchState(recent: [getFakeVersion(), getFakeVersion(), getFakeVersion()]));

    await widgetTester.pumpWidget(
      TestWrapper(
        child: BlocProvider<SearchBloc>.value(
          value: bloc,
          child: const SearchScreen(),
        ),
      ),
    );

    expect(find.byType(AddVersionTile), findsNWidgets(3));
  });
}

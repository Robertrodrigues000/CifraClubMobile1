import 'dart:async';

import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/version/models/section.dart';
import 'package:cifraclub/domain/version/use_cases/parse_sections.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/content_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _ParseSectionsMock extends Mock implements ParseSections {}

void main() {
  group('When action is OnVersionLoaded', () {
    test('should emit OnContentParsed action with the parsed values', () async {
      final parseSections = _ParseSectionsMock();
      final sections = [Section("Section 1"), Section("Section 2")];
      when(() => parseSections(any())).thenReturn(sections);

      final versionData = getFakeVersionData();
      final completer = Completer<VersionAction>();
      final contentMiddleware = ContentMiddleware(parseSections);

      contentMiddleware.onAction(
          OnVersionLoaded(versionData),
          const VersionState(versionHeaderState: VersionHeaderState(selectedInstrument: Instrument.bass)),
          completer.complete);

      final versionAction = await completer.future;
      expect(
          versionAction,
          isA<OnContentParsed>()
              .having((action) => action.sections, "sections", sections)
              .having((action) => action.selectedFilter.instrument, "SelectedFilter", versionData.instrument)
              .having((action) => action.selectedFilter.versionUrl, "Version url", versionData.versionUrl)
              .having((action) => action.versionData, "Version data", versionData)
              .having(
                  (action) => action.versionFilters.length, "Version filters", versionData.instrumentVersions?.length));
    });

    test('if there isnt any version with the selected instrument, should emit VersionEmptyError', () async {
      final parseSections = _ParseSectionsMock();
      final sections = [Section("Section 1"), Section("Section 2")];
      when(() => parseSections(any())).thenReturn(sections);

      final versionData = getFakeVersionData(instrumentVersions: []);
      final completer = Completer<VersionAction>();
      final contentMiddleware = ContentMiddleware(parseSections);

      contentMiddleware.onAction(
          OnVersionLoaded(versionData),
          const VersionState(versionHeaderState: VersionHeaderState(selectedInstrument: Instrument.bass)),
          completer.complete);

      final versionAction = await completer.future;
      expect(versionAction, isA<OnVersionError>().having((action) => action.error, "error", isA<VersionEmptyError>()));
    });
  });
}

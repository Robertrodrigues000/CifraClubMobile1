import 'dart:async';

import 'package:cifraclub/domain/section/use_cases/process_sections.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/domain/section/models/section.dart';
import 'package:cifraclub/domain/section/use_cases/parse_sections.dart';
import 'package:cifraclub/domain/version/models/instrument_version.dart';
import 'package:cifraclub/domain/version/use_cases/get_all_instrument_versions.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/content_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_error.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../shared_mocks/domain/version/models/instrument_version_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _SectionMock extends Mock implements Section {}

class _ParseSectionsMock extends Mock implements ParseSections {}

class _ProcessSectionsMock extends Mock implements ProcessSections {}

class _GetAllInstrumentVersionsMock extends Mock implements GetAllInstrumentVersions {}

void main() {
  group('When action is OnVersionLoaded', () {
    test('should emit OnContentParsed action with the parsed values', () async {
      final parseSections = _ParseSectionsMock();
      final processSections = _ProcessSectionsMock();
      final getAllInstrumentVersions = _GetAllInstrumentVersionsMock();

      final sections = [
        _SectionMock(),
        _SectionMock(),
      ];
      when(() => parseSections(any())).thenReturn(sections);
      when(() => processSections.call(sections, any())).thenReturn(null);
      when(() => getAllInstrumentVersions(any()))
          .thenReturn([(instrument: Instrument.guitar, versions: List<InstrumentVersion>.empty())]);

      final versionData = getFakeVersionData(
        instrument: Instrument.guitar,
        instrumentVersions: [
          (versions: [getFakeInstrumentVersion()], instrument: Instrument.guitar)
        ],
      );
      final completer = Completer<VersionAction>();
      final contentMiddleware = ContentMiddleware(parseSections, processSections, getAllInstrumentVersions);

      contentMiddleware.onAction(
        OnVersionLoaded(versionData),
        const VersionState(versionHeaderState: VersionHeaderState(selectedInstrument: Instrument.bass)),
        completer.complete,
      );

      final versionAction = await completer.future;
      verify(() => processSections.call(sections, any())).called(1);
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

    test('should emit VersionEmptyError when there is no version with the selected instrument', () async {
      final parseSections = _ParseSectionsMock();
      final processSections = _ProcessSectionsMock();
      final getAllInstrumentVersions = _GetAllInstrumentVersionsMock();

      final sections = [
        _SectionMock(),
        _SectionMock(),
      ];
      when(() => parseSections(any())).thenReturn(sections);
      when(() => processSections.call(sections, any())).thenReturn(null);
      when(() => getAllInstrumentVersions(any()))
          .thenReturn([(instrument: Instrument.bass, versions: List<InstrumentVersion>.empty())]);

      final versionData = getFakeVersionData(instrumentVersions: []);
      final completer = Completer<VersionAction>();
      final contentMiddleware = ContentMiddleware(parseSections, processSections, getAllInstrumentVersions);

      contentMiddleware.onAction(
        OnVersionLoaded(versionData),
        const VersionState(versionHeaderState: VersionHeaderState(selectedInstrument: Instrument.bass)),
        completer.complete,
      );

      final versionAction = await completer.future;
      verifyNever(() => processSections.call(any(), any()));
      expect(versionAction, isA<OnVersionError>().having((action) => action.error, "error", isA<VersionEmptyError>()));
    });
  });
}

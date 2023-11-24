import 'dart:async';

import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/section/use_cases/characters_per_line.dart';
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
import 'package:rxdart/rxdart.dart';

import '../../../../shared_mocks/domain/version/models/instrument_version_mock.dart';
import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _SectionMock extends Mock implements Section {}

class _ParseSectionsMock extends Mock implements ParseSections {}

class _GetAllInstrumentVersionsMock extends Mock implements GetAllInstrumentVersions {}

class _ProcessSectionsMock extends Mock implements ProcessSections {}

class _CharactersPerLine extends Mock implements CharactersPerLine {}

void main() {
  group('When action is OnVersionLoaded', () {
    test('should emit OnContentParsed action with the parsed values', () async {
      final parseSections = _ParseSectionsMock();
      final getAllInstrumentVersions = _GetAllInstrumentVersionsMock();

      final sections = [
        _SectionMock(),
        _SectionMock(),
      ];
      when(() => parseSections(any())).thenReturn(sections);
      when(() => getAllInstrumentVersions(any()))
          .thenReturn([(instrument: Instrument.guitar, versions: List<InstrumentVersion>.empty())]);

      final versionData = getFakeVersionData(
        instrument: Instrument.guitar,
        instrumentVersions: [
          (versions: [getFakeInstrumentVersion()], instrument: Instrument.guitar)
        ],
      );
      final completer = Completer<VersionAction>();
      final contentMiddleware =
          ContentMiddleware(parseSections, getAllInstrumentVersions, _ProcessSectionsMock(), _CharactersPerLine());

      contentMiddleware.onAction(
        OnVersionLoaded(versionData),
        const VersionState(versionHeaderState: VersionHeaderState(selectedInstrument: Instrument.bass)),
        completer.complete,
      );

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

    test('should emit VersionEmptyError when there is no version with the selected instrument', () async {
      final parseSections = _ParseSectionsMock();
      final getAllInstrumentVersions = _GetAllInstrumentVersionsMock();

      final sections = [
        _SectionMock(),
        _SectionMock(),
      ];
      when(() => parseSections(any())).thenReturn(sections);
      when(() => getAllInstrumentVersions(any()))
          .thenReturn([(instrument: Instrument.bass, versions: List<InstrumentVersion>.empty())]);

      final versionData = getFakeVersionData(instrumentVersions: []);
      final completer = Completer<VersionAction>();
      final contentMiddleware =
          ContentMiddleware(parseSections, getAllInstrumentVersions, _ProcessSectionsMock(), _CharactersPerLine());

      contentMiddleware.onAction(
        OnVersionLoaded(versionData),
        const VersionState(versionHeaderState: VersionHeaderState(selectedInstrument: Instrument.bass)),
        completer.complete,
      );

      final versionAction = await completer.future;
      expect(versionAction, isA<OnVersionError>().having((action) => action.error, "error", isA<VersionEmptyError>()));
    });
  });

  group("When action is OnContentProcess", () {
    final processSections = _ProcessSectionsMock();
    final charactersPerLine = _CharactersPerLine();
    final sections = [TextSection("section")];
    when(() => processSections.call(any(), any())).thenAnswer((_) => sections);
    when(() => charactersPerLine.call(
        screenPadding: any(named: "screenPadding"),
        screenWidth: any(named: "screenWidth"),
        fontSize: any(named: "fontSize"))).thenReturn(40);

    final contentMiddleware =
        ContentMiddleware(_ParseSectionsMock(), _GetAllInstrumentVersionsMock(), processSections, charactersPerLine);

    test("and is cifra instrument should process sections", () {
      final actionStream = PublishSubject<VersionAction>();

      expectLater(
        actionStream.stream,
        emitsInOrder([isA<OnContentProcessed>().having((action) => action.sections, "sections", sections)]),
      );

      contentMiddleware.onAction(
        OnContentProcess(screenMargin: 20, screenWidth: 500),
        VersionState(
            fontSizeState: const FontSizeState(fontSize: 16),
            sections: sections,
            version: getFakeVersionData(instrument: Instrument.guitar)),
        actionStream.add,
      );

      verify(() => charactersPerLine(fontSize: 16, screenPadding: 20, screenWidth: 500)).called(1);
      verify(() => processSections(sections, 40)).called(1);
      actionStream.close();
    });

    test("and isn't cifra instrument should ignore", () {
      contentMiddleware.onAction(
        OnContentProcess(screenMargin: 20, screenWidth: 500),
        VersionState(
            fontSizeState: const FontSizeState(fontSize: 16),
            sections: sections,
            version: getFakeVersionData(
              instrument: Instrument.drums,
            )),
        (_) {},
      );

      verifyNever(() => charactersPerLine(
          screenPadding: any(named: "screenPadding"),
          screenWidth: any(named: "screenWidth"),
          fontSize: any(named: "fontSize")));
      verifyNever(() => processSections(any(), any()));
    });
  });
}

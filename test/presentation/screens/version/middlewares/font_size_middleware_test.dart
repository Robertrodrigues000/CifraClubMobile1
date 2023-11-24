import 'package:cifraclub/domain/preferences/use_cases/get_font_size_preference.dart';
import 'package:cifraclub/domain/preferences/use_cases/set_font_size_preference.dart';
import 'package:cifraclub/domain/section/models/text_section.dart';
import 'package:cifraclub/domain/version/models/instrument.dart';
import 'package:cifraclub/presentation/screens/version/middlewares/font_size_middleware.dart';
import 'package:cifraclub/presentation/screens/version/models/version_filter.dart';
import 'package:cifraclub/presentation/screens/version/version_action.dart';
import 'package:cifraclub/presentation/screens/version/version_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../shared_mocks/domain/version/models/version_data_mock.dart';

class _GetFontSizePreferenceMock extends Mock implements GetFontSizePreference {}

class _SetFontSizePreferenceMock extends Mock implements SetFontSizePreference {}

void main() {
  const filter = VersionFilter(
    instrument: Instrument.bass,
    versionName: "Aquela",
    versionUrl: "aaa",
    isVerified: true,
  );

  final getFontSizePreference = _GetFontSizePreferenceMock();
  final setFontSizePreference = _SetFontSizePreferenceMock();
  final sections = [TextSection("section")];

  test('When the action is OnContentParsed, the middleware should emit an OnContentProcessed', () async {
    when(getFontSizePreference.call).thenAnswer((_) => 14);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    const versionState = VersionState();
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 14)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnContentParsed(
          sections: sections,
          versionData: getFakeVersionData(instrument: Instrument.guitar),
          versionFilters: [filter],
          selectedFilter: filter),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnContentParsed, and the fontsize is in the minimum, the middleware should emit an OnContentProcessed',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 8);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    const versionState = VersionState();
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 8)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", false)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnContentParsed(
          sections: sections,
          versionData: getFakeVersionData(instrument: Instrument.guitar),
          versionFilters: [filter],
          selectedFilter: filter),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnContentParsed, and the fontsize is in the maximum, the middleware should emit an OnContentProcessed',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 24);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    const versionState = VersionState();
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 24)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", false),
      ]),
    );

    middleware.onAction(
      OnContentParsed(
          sections: sections,
          versionData: getFakeVersionData(instrument: Instrument.guitar),
          versionFilters: [filter],
          selectedFilter: filter),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnContentParsed, and the instrument is not a cifra instrument, the middleware should emit an OnContentProcessed but not call processSections',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 14);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    const versionState = VersionState();
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 14)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnContentParsed(
          sections: sections,
          versionData: getFakeVersionData(instrument: Instrument.bass),
          versionFilters: [filter],
          selectedFilter: filter),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeDecrease, the middleware should emit an OnContentProcessed with decreased font size',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 14);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 12)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnFontSizeDecrease(),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeDecrease, and the instrument is not a cifra instrument, the middleware should emit an OnContentProcessed with decreased font size but not call processSections',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 14);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.bass));
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 12)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnFontSizeDecrease(),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeDecrease and the fontsize is reaching the minimum, the middleware should emit an OnContentProcessed with decreased font size and decrease font size disabled',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 10);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 8)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", false)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnFontSizeDecrease(),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeDecrease and the fontsize is already in the minimum, the middleware should not emit an any action',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 8);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    var actionEmitted = false;

    middleware.onAction(
      OnFontSizeDecrease(),
      versionState,
      (_) {
        actionEmitted = true;
      },
    );

    expect(actionEmitted, false);
  });

  test(
      'When the action is OnFontSizeIncrease, the middleware should emit an OnContentProcessed with decreased font size',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 14);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 16)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnFontSizeIncrease(),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeIncrease and the instrument is not a cifra instrument, the middleware should emit an OnContentProcessed with increased font size but not call processSections',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 14);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.bass));
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 16)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnFontSizeIncrease(),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeIncrease and the fontsize is reaching the maximum, the middleware should emit an OnContentProcessed with decreased font size and decrease font size disabled',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 22);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 24)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", false),
      ]),
    );

    middleware.onAction(
      OnFontSizeIncrease(),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeIncrease and the fontsize is already in the maximum, the middleware should not emit an any action',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 24);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    var actionEmitted = false;

    middleware.onAction(
      OnFontSizeIncrease(),
      versionState,
      (_) {
        actionEmitted = true;
      },
    );

    expect(actionEmitted, false);
  });

  test('When the action is OnFontSizeRestore, the middleware should emit an OnContentProcessed with default font size',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 18);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    final actionStream = PublishSubject<VersionAction>();

    expectLater(
      actionStream.stream,
      emitsInOrder([
        isA<OnReadyToProcessContent>()
            .having((action) => action.sections, "sections", sections)
            .having((action) => action.fontSize, "fontSize", 14)
            .having((action) => action.isFontDecreaseEnabled, "isFontDecreaseEnabled", true)
            .having((action) => action.isFontIncreaseEnabled, "isFontIncreaseEnabled", true),
      ]),
    );

    middleware.onAction(
      OnFontSizeRestore(),
      versionState,
      actionStream.add,
    );

    await actionStream.close();
  });

  test(
      'When the action is OnFontSizeRestore, but the fontSize is already the default, the middleware should not emit any action',
      () async {
    when(getFontSizePreference.call).thenAnswer((_) => 14);
    when(() => setFontSizePreference.call(any())).thenAnswer((_) => SynchronousFuture(true));

    final middleware = FontSizeMiddleware(getFontSizePreference, setFontSizePreference);
    final versionState = VersionState(sections: sections, version: getFakeVersionData(instrument: Instrument.guitar));
    var actionEmitted = false;

    middleware.onAction(
      OnFontSizeRestore(),
      versionState,
      (_) {
        actionEmitted = true;
      },
    );

    expect(actionEmitted, false);
  });
}

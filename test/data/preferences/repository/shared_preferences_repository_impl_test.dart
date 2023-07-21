import 'package:cifraclub/data/preferences/repository/shared_preferences_repository_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _SharedPreferencesMock extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences preferences;

  setUpAll(() {
    preferences = _SharedPreferencesMock();
    when(() => preferences.setBool(captureAny(), captureAny())).thenAnswer((_) => SynchronousFuture(true));
    when(() => preferences.setString(captureAny(), captureAny())).thenAnswer((_) => SynchronousFuture(true));
  });

  test("When 'setBool' is called should save a new bool value", () {
    final repository = SharedPreferencesRepositoryImpl(preferences);

    repository.setBool(SharedPreferencesKeys.pro, true);

    final getParams = verify(() => preferences.setBool(captureAny(), captureAny())).captured;

    expect(getParams[0], "PRO_KEY");
    expect(getParams[1], true);
  });

  test("When 'getBool' is called should return bool value", () {
    final repository = SharedPreferencesRepositoryImpl(preferences);
    when(() => preferences.getBool(any())).thenReturn(true);

    final value = repository.getBool(SharedPreferencesKeys.pro);

    verify(() => preferences.getBool(any())).called(1);
    expect(value, isTrue);
  });

  test("When 'setString' is called should save a new string value", () {
    final repository = SharedPreferencesRepositoryImpl(preferences);

    repository.setString(SharedPreferencesKeys.orderType, "RECENTS_KEY");

    final getParams = verify(() => preferences.setString(captureAny(), captureAny())).captured;

    expect(getParams[0], "LAST_FILTER");
    expect(getParams[1], "RECENTS_KEY");
  });

  test("When 'getString' is called should return bool value", () {
    final repository = SharedPreferencesRepositoryImpl(preferences);
    when(() => preferences.getString(any())).thenReturn("RECENTS_KEY");

    final value = repository.getString(SharedPreferencesKeys.orderType);

    verify(() => preferences.getString(any())).called(1);
    expect(value, "RECENTS_KEY");
  });
}

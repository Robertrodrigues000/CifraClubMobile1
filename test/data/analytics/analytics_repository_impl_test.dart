import 'package:cifraclub/data/analytics/analytics_repository_impl.dart';
import 'package:cifraclub/domain/analytics/models/analytics_event.dart';
import 'package:cifraclub/domain/analytics/models/user_property.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _FirebaseAnalyticsMock extends Mock implements FirebaseAnalytics {}

void main() {
  test("on logEvent called, verify if correct parameters are passed", () async {
    final firebaseAnalytics = _FirebaseAnalyticsMock();
    final repository = AnalyticsRepositoryImpl(firebaseAnalytics);
    final event = AnalyticsEvent.pageView("testePage");

    when(() => firebaseAnalytics.logEvent(name: event.name, parameters: event.parameters))
        .thenAnswer((_) => Future.value(null));

    await repository.logEvent(event);

    verify(() => firebaseAnalytics.logEvent(name: event.name, parameters: event.parameters)).called(1);
  });

  test("on setUserProperty called, verify if correct parameters are passed", () async {
    final firebaseAnalytics = _FirebaseAnalyticsMock();
    final repository = AnalyticsRepositoryImpl(firebaseAnalytics);
    final property = UserProperty.login(false);

    when(() => firebaseAnalytics.setUserProperty(name: property.name, value: property.value))
        .thenAnswer((_) => Future.value(null));

    await repository.setUserProperty(property);

    verify(() => firebaseAnalytics.setUserProperty(name: property.name, value: property.value)).called(1);
  });
}

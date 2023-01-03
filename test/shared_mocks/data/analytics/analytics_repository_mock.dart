import 'package:cifraclub/domain/analytics/models/analytics_event.dart';
import 'package:cifraclub/domain/analytics/models/user_property.dart';
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart';
import 'package:mocktail/mocktail.dart';

class AnalyticsRepositoryMock extends Mock implements AnalyticsRepository {
  static AnalyticsRepositoryMock getDummy() {
    registerFallbackValue(AnalyticsEvent.pageView("dummy"));
    registerFallbackValue(UserProperty.login(true));
    final analyticsRepository = AnalyticsRepositoryMock();
    when(() => analyticsRepository.logEvent(any())).thenAnswer((invocation) => Future.value(null));
    when(() => analyticsRepository.setUserProperty(any())).thenAnswer((invocation) => Future.value(null));
    return analyticsRepository;
  }
}

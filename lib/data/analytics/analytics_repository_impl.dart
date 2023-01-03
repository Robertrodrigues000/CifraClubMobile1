import 'package:cifraclub/domain/analytics/models/analytics_event.dart';
import 'package:cifraclub/domain/analytics/models/user_property.dart';
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  final FirebaseAnalytics firebaseAnalytics;

  const AnalyticsRepositoryImpl(this.firebaseAnalytics);

  @override
  Future<void> logEvent(AnalyticsEvent event) {
    return firebaseAnalytics.logEvent(name: event.name, parameters: event.parameters);
  }

  @override
  Future<void> setUserProperty(UserProperty userProperty) {
    return firebaseAnalytics.setUserProperty(name: userProperty.name, value: userProperty.value);
  }
}

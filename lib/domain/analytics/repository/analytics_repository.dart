import 'package:cifraclub/di/di_setup.dart';
import 'package:cifraclub/domain/analytics/models/analytics_event.dart';
import 'package:cifraclub/domain/analytics/models/user_property.dart';

AnalyticsRepository? get analytics =>
    getIt.isRegistered<AnalyticsRepository>() ? getIt() : null; // coverage:ignore-line

abstract class AnalyticsRepository {
  Future<void> logEvent(AnalyticsEvent event);
  Future<void> setUserProperty(UserProperty userProperty);
}

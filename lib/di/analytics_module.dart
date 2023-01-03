// coverage:ignore-file
import 'package:cifraclub/data/analytics/analytics_repository_impl.dart';
import 'package:cifraclub/domain/analytics/repository/analytics_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AnalyticsModule {
  AnalyticsRepository getAnalyticsRepository(FirebaseAnalytics analytics) {
    return AnalyticsRepositoryImpl(analytics);
  }
}

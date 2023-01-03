// coverage:ignore-file
import 'package:cifraclub/domain/analytics/constants/event_name.dart';
import 'package:cifraclub/domain/analytics/constants/event_parameter.dart';

///     The name of the event should contain 1 to 40 alphanumeric characters or
///     underscores. The name must start with an alphabetic character. Some event names are
///     reserved. See https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event
///     for the list of reserved event names.
///     The "firebase_","google_", and "ga_" prefixes are reserved and should not be used. Note that event names are
///     case-sensitive and that logging two events whose names differ only in case will result in
///     two distinct events.
///
///     Parameter names can be up to 40 characters long and must start with an
///     alphabetic character and contain only alphanumeric characters and underscores. Only String,
///     Int, and Double parameter types are supported. String parameter values can be up to 100
///     characters long. The "firebase_", "google_", and "ga_" prefixes are reserved and should not
///     be used for parameter names.
class AnalyticsEvent {
  AnalyticsEvent._(
    this.name, [
    this.parameters,
  ]);

  final String name;
  final Map<String, dynamic>? parameters; // O tipo do value somente pode ser String, Int ou Double.

  AnalyticsEvent.pageView(String pageName) : this._(EventName.pageView, {EventParameters.content: pageName});
}

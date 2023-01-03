// coverage:ignore-file
import 'package:cifraclub/domain/analytics/constants/user_property_name.dart';
import 'package:cifraclub/domain/analytics/constants/user_property_value.dart';

class UserProperty {
  final String name;
  final String value;

  UserProperty._(this.name, this.value);

  UserProperty.login(bool isLoggedIn) : this._(UserPropertyName.loginStatusProperty, isLoggedIn ? UserPropertyValues.loggedIn : UserPropertyValues.loggedOut);
}

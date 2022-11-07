import 'package:cifraclub/presentation/navigator/app_navigator.dart';
import 'package:flutter/widgets.dart';

// coverage:ignore-file
class InheritedDependenciesWidget extends InheritedWidget {
  final AppNavigator appNavigator;

  const InheritedDependenciesWidget({
    Key? key,
    required Widget child,
    required this.appNavigator,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static InheritedDependenciesWidget of(BuildContext context) {
    final InheritedDependenciesWidget? result = context.dependOnInheritedWidgetOfExactType<InheritedDependenciesWidget>();
    assert(result != null, 'No InheritedWidgetDependencies found in context');
    return result!;
  }
}

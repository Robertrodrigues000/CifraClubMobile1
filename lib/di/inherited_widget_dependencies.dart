import 'package:flutter/widgets.dart';

// coverage:ignore-file
class InheritedDependenciesWidget extends InheritedWidget {
  const InheritedDependenciesWidget({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static InheritedDependenciesWidget of(BuildContext context) {
    final InheritedDependenciesWidget? result =
        context.dependOnInheritedWidgetOfExactType<InheritedDependenciesWidget>();
    assert(result != null, 'No InheritedWidgetDependencies found in context');
    return result!;
  }
}

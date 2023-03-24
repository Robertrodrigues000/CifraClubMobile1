import 'package:cifraclub/presentation/widgets/color_approximator.dart';
import 'package:flutter/widgets.dart';

// coverage:ignore-file
class InheritedDependenciesWidget extends InheritedWidget {
  final ColorApproximator colorApproximator;

  const InheritedDependenciesWidget({
    Key? key,
    required Widget child,
    required this.colorApproximator,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static InheritedDependenciesWidget of(BuildContext context) {
    final InheritedDependenciesWidget? result =
        context.dependOnInheritedWidgetOfExactType<InheritedDependenciesWidget>();
    assert(result != null, 'No InheritedWidgetDependencies found in context');
    return result!;
  }
}

import 'package:flutter/widgets.dart';
import 'package:cifraclub/presentation/navigator/screen_entry.dart';

class PageBuilder extends Page {
  final ScreenEntry screenEntry;

  const PageBuilder({
    required LocalKey? key,
    required this.screenEntry,
  }) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return _Route(this, screenEntry);
  }
}

class _Route extends PageRoute {
  final ScreenEntry screenEntry;

  _Route(RouteSettings settings, this.screenEntry) : super(settings: settings);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return screenEntry.build(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return screenEntry.buildTransition(context, this, animation, secondaryAnimation, child);
  }
}

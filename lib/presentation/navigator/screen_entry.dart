import 'package:flutter/material.dart';

/// When a new screen is created, the entry must be registered in two parses:
///
/// 1 - ScreenPathParser.getScreenFromPathSegment()
/// 2 - DeepLinkParser.getPathSegments(), if the new screen can be open from an URL link
abstract class ScreenEntry {
  final Map<String, String> params;
  late ValueKey key = ValueKey(screenName);

  ScreenEntry(
    this.params,
  );

  /// Used to log screen view analytic events
  String? get screenViewName;

  /// Used by navigator to generate screen segment path
  String get screenName;

  Widget build(BuildContext context);

  /// Override this function to replace the default animation transition
  Widget buildTransition(BuildContext context, PageRoute route, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    final PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    return theme.buildTransitions(route, context, animation, secondaryAnimation, child);
  }

  /// Navigator will call this function when screen is removed from the stack
  void dispose() {}
}

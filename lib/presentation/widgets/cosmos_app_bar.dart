// coverage:ignore-file
import 'package:flutter/material.dart';

class CosmosAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const CosmosAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.toolbarHeight,
    this.bottom,
    this.actions,
  }) : super(key: key);

  @override
  State<CosmosAppBar> createState() => _CosmosAppBarState();

  @override
  Size get preferredSize => Size.fromHeight((toolbarHeight ?? kToolbarHeight) + (bottom?.preferredSize.height ?? 0));
}

class _CosmosAppBarState extends State<CosmosAppBar> {
  ScrollNotificationObserverState? _scrollNotificationObserver;
  bool _scrolledUnder = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
    }
    _scrollNotificationObserver = ScrollNotificationObserver.of(context);
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.addListener(_handleScrollNotification);
    }
  }

  @override
  void dispose() {
    if (_scrollNotificationObserver != null) {
      _scrollNotificationObserver!.removeListener(_handleScrollNotification);
      _scrollNotificationObserver = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FlexibleSpaceBarSettings? settings = context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    final bool isScrolledUnder = settings?.isScrolledUnder ?? _scrolledUnder;

    return AppBar(
      backgroundColor:
          isScrolledUnder ? AppBarTheme.of(context).surfaceTintColor : AppBarTheme.of(context).backgroundColor,
      leading: widget.leading,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      title: widget.title,
      actions: widget.actions,
      bottom: widget.bottom,
      elevation: 0.0,
      scrolledUnderElevation: 0.0,
      toolbarHeight: widget.toolbarHeight,
    );
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification && notification.depth == 0) {
      final bool oldScrolledUnder = _scrolledUnder;
      final ScrollMetrics metrics = notification.metrics;
      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          _scrolledUnder = metrics.extentAfter > 0;
          break;
        case AxisDirection.down:
          _scrolledUnder = metrics.extentBefore > 0;
          break;
        case AxisDirection.right:
        case AxisDirection.left:
          // Scrolled under is only supported in the vertical axis.
          _scrolledUnder = false;
          break;
      }

      if (_scrolledUnder != oldScrolledUnder) {
        setState(() {
          // React to a change in MaterialState.scrolledUnder
        });
      }
    }
  }
}

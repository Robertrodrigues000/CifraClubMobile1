import 'package:flutter/material.dart';

class ControllerScrollUnderBuilder extends StatefulWidget {
  final ScrollController scrollController;
  final Function(BuildContext context, bool isScrolledUnder) builder;

  const ControllerScrollUnderBuilder({super.key, required this.scrollController, required this.builder});

  @override
  State<ControllerScrollUnderBuilder> createState() => _ControllerScrollUnderBuilderState();
}

class _ControllerScrollUnderBuilderState extends State<ControllerScrollUnderBuilder> {
  var isScrolledUnder = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  // coverage:ignore-start
  void _onScroll() {
    final currentOffset = widget.scrollController.offset;
    final currentScrollUnder = currentOffset > 0 ? true : false;
    if (currentScrollUnder != isScrolledUnder) {
      setState(() {
        isScrolledUnder = currentScrollUnder;
      });
    }
  }
  // coverage:ignore-end

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, isScrolledUnder);
  }
}

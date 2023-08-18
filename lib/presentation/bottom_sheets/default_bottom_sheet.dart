import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

// coverage:ignore-file
class DefaultBottomSheet extends StatefulWidget {
  final Widget child;
  final ScrollController? scrollController;
  final double heightMaxFactor;
  final bool enableHeader;

  const DefaultBottomSheet({
    super.key,
    required this.child,
    this.scrollController,
    required this.heightMaxFactor,
    required this.enableHeader,
  });

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    ScrollController? scrollController,
    bool isScrollable = true,
    double heightMaxFactor = 1,
    bool enableHeader = true,
  }) =>
      showModalBottomSheet<T>(
        isScrollControlled: isScrollable,
        context: context,
        clipBehavior: Clip.hardEdge,
        useSafeArea: true,
        useRootNavigator: true,
        constraints: BoxConstraints(maxWidth: context.appDimensionScheme.widthBottomSheet),
        builder: (context) {
          return DefaultBottomSheet(
            scrollController: scrollController,
            heightMaxFactor: heightMaxFactor,
            enableHeader: enableHeader,
            child: child,
          );
        },
      );

  static void close(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  State<DefaultBottomSheet> createState() => _DefaultBottomSheetState();
}

class _DefaultBottomSheetState extends State<DefaultBottomSheet> {
  var isScrolledUnder = false;

  @override
  void initState() {
    widget.scrollController?.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final currentOffset = widget.scrollController!.offset;
    final currentScrollUnder = currentOffset > 0 ? true : false;
    if (currentScrollUnder != isScrolledUnder) {
      setState(() {
        isScrolledUnder = currentScrollUnder;
      });
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    widget.scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.neutralPrimary,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.heightMaxFactor * MediaQuery.of(context).size.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.enableHeader) DefaultBottomSheetHeader(isScrolledUnder: isScrolledUnder),
            Flexible(child: widget.child),
          ],
        ),
      ),
    );
  }
}

class DefaultBottomSheetHeader extends StatelessWidget {
  const DefaultBottomSheetHeader({
    super.key,
    required this.isScrolledUnder,
  });

  final bool isScrolledUnder;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Container(
      height: 36,
      color: isScrolledUnder ? colorScheme.neutralSecondary : colorScheme.neutralPrimary,
      child: Center(
        child: Container(
          width: 32,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            color: colorScheme.neutralSextenary,
          ),
        ),
      ),
    );
  }
}

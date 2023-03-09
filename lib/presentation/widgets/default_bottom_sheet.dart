import 'package:cifraclub/extensions/build_context.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/material.dart';

// coverage:ignore-file
class DefaultBottomSheet extends StatefulWidget {
  final Widget child;
  final ScrollController? scrollController;
  final double heightMaxFactor;

  const DefaultBottomSheet({super.key, required this.child, this.scrollController, required this.heightMaxFactor});

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    ScrollController? scrollController,
    bool isScrollable = true,
    double heightMaxFactor = 1,
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
  var haveScroll = false;

  @override
  void initState() {
    widget.scrollController?.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    final currentOffset = widget.scrollController!.offset;
    setState(() {
      haveScroll = currentOffset > 0 ? true : false;
    });
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    widget.scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = CosmosColorScheme.of(context);

    return Container(
      color: colorScheme.neutralPrimary,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: widget.heightMaxFactor * MediaQuery.of(context).size.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 36,
              color: haveScroll ? colorScheme.neutralSecondary : colorScheme.neutralPrimary,
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
            ),
            Flexible(child: widget.child),
          ],
        ),
      ),
    );
  }
}

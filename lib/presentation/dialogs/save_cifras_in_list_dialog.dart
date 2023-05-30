import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class SaveCifrasInListDialog extends StatelessWidget {
  final int totalCifras;
  final int count;

  const SaveCifrasInListDialog({super.key, required this.totalCifras, required this.count});

  // coverage:ignore-start
  static Future<T?> show<T>({required BuildContext context, required int totalCifras, required int count}) {
    return showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return SaveCifrasInListDialog(
            count: count,
            totalCifras: totalCifras,
          );
        });
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: context.colors.neutralSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              context.text.savingToList,
              style: context.typography.title5,
            ),
          ),
          Divider(height: 1, color: context.colors.neutralTertiary),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
            child: Text(context.text.loadingSongs, style: context.typography.body10),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                minHeight: 4,
                value: count / totalCifras,
                color: context.colors.primary,
                backgroundColor: context.colors.neutralTertiary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${((count / totalCifras) * 100).round()}%",
                    style: context.typography.body6.copyWith(color: context.colors.textPrimary)),
                Text("$count/$totalCifras",
                    style: context.typography.body6.copyWith(color: context.colors.textPrimary)),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

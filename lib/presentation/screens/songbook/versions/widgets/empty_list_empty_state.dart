import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:flutter/material.dart';

class EmptyListEmptyState extends StatelessWidget {
  const EmptyListEmptyState({super.key, required this.onClick});
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final dimensions = context.appDimensionScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dimensions.screenMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            context.text.emptyListTitle,
            style: context.typography.title5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            context.text.emptyListDescription,
            style: context.typography.body10,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: dimensions.errorWidgetButtonSpace),
          CifraClubButton(
            type: ButtonType.outline,
            onPressed: onClick,
            child: Text(context.text.searchSongs),
          ),
        ],
      ),
    );
  }
}

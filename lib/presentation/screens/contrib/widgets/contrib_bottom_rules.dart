import 'package:cifraclub/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ContribBottomRules extends StatelessWidget {
  const ContribBottomRules({
    super.key,
    required this.openUrl,
  });

  final VoidCallback openUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.neutralTertiary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: openUrl,
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: context.typography.title5,
              children: [
                TextSpan(text: context.text.seeOur, style: context.typography.body11),
                TextSpan(
                  text: context.text.publicationRules,
                  style: context.typography.body11.copyWith(color: context.colors.primary),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

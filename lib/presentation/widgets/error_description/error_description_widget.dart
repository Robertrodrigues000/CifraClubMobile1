import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/button_type.dart';
import 'package:cifraclub/presentation/widgets/cifraclub_button/cifraclub_button.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:flutter/widgets.dart';

class ErrorDescriptionWidget extends StatelessWidget {
  const ErrorDescriptionWidget({super.key, required this.typeError, this.onClick});
  final ErrorDescriptionWidgetType typeError;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dimensions = context.appDimensionScheme;
    final imageHeight = (screenWidth - (dimensions.externalMarginWithoutConnection * 2)) * 0.35;
    final imageName = context.isDarkMode ? typeError.getImageDark() : typeError.getImageLight();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dimensions.externalMarginWithoutConnection),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageName != null) ...[
            Image.asset(
              imageName,
              height: imageHeight,
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(height: 16),
          ],
          Text(
            typeError.getTitle(context),
            style: context.typography.title5,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            typeError.getDescription(context),
            style: context.typography.body10,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: dimensions.errorWidgetButtonSpace),
          if (typeError.getButtonText(context) != null)
            CifraClubButton(
              type: ButtonType.outline,
              width: typeError == ErrorDescriptionWidgetType.emptyList ? null : dimensions.errorWidgetButtonWidth,
              onPressed: onClick,
              child: Text(typeError.getButtonText(context)!),
            ),
        ],
      ),
    );
  }
}

import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/widgets/buttons/button_type.dart';
import 'package:cifraclub/presentation/widgets/buttons/cifra_button.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:flutter/widgets.dart';

class ErrorDescriptionWidget extends StatelessWidget {
  const ErrorDescriptionWidget({super.key, required this.typeError, required this.onClick});
  final ErrorDescriptionWidgetType typeError;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = (screenWidth - (context.appDimensionScheme.externalMarginWithoutConnection * 2)) * 0.4;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.externalMarginWithoutConnection),
          child: Image.asset(
            context.isDarkMode ? AppWebp.withoutConnectionDark : AppWebp.withoutConnectionLight,
            height: imageHeight,
            fit: BoxFit.fitHeight,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.appDimensionScheme.screenMargin),
          child: Column(
            children: [
              Text(
                typeError.getTitle(context),
                style: context.typography.title4.copyWith(color: context.colors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                typeError.getDescription(context),
                style: context.typography.body10,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CifraButton(
                type: ButtonType.outline,
                padding: EdgeInsets.zero,
                onPressed: onClick,
                child: Text(typeError.getButtonText(context)),
              )
            ],
          ),
        ),
      ],
    );
  }
}

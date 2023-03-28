import 'package:cifraclub/extensions/build_context.dart';
import 'package:cifraclub/presentation/constants/app_webp.dart';
import 'package:cifraclub/presentation/widgets/error_description/error_description_widget_type.dart';
import 'package:flutter/widgets.dart';

class ErrorDescriptionWidget extends StatelessWidget {
  const ErrorDescriptionWidget(this._typeError, {super.key});
  final ErrorDescriptionWidgetType _typeError;

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
                _typeError.getTitle(context),
                style: context.typography.title4.copyWith(color: context.colors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _typeError.getDescription(context),
                style: context.typography.body10,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

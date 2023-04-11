import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme.dart';
import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme_phone.dart';
import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme_small_phone.dart';
import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme_tablet.dart';
import 'package:cifraclub/presentation/style/typography/app_typography_scheme.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:cosmos/cosmos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}

extension AppDimensionSchemeExt on BuildContext {
  AppDimensionScheme get appDimensionScheme {
    switch (getDeviceType(this)) {
      case DeviceType.phone:
        return appDimensionSchemePhone;
      case DeviceType.tablet:
        return appDimensionSchemeTablet;
      case DeviceType.smallPhone:
        return appDimensionSchemeSmallPhone;
    }
  }
}

extension TypographySchemeExt on BuildContext {
  AppTypographyScheme get typography => AppTypographyScheme.of(this);
}

extension ColorSchemeExt on BuildContext {
  CosmosColorScheme get colors => CosmosColorScheme.of(this);
}

extension AppDarkModeExt on BuildContext {
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

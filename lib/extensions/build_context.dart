import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme.dart';
import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme_phone.dart';
import 'package:cifraclub/presentation/style/dimensions/app_dimension_scheme_tablet.dart';
import 'package:cifraclub/presentation/style/typography/app_typography_scheme.dart';
import 'package:cifraclub/presentation/widgets/device_type_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}

extension AppDimensionSchemeExt on BuildContext {
  AppDimensionScheme get appDimensionScheme =>
      getDeviceType(this) == DeviceType.phone ? appDimensionSchemePhone : appDimensionSchemeTablet;
}

extension TypographySchemeExt on BuildContext {
  AppTypographyScheme get typography => AppTypographyScheme.of(this);
}

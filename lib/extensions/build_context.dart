import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsExt on BuildContext {
  AppLocalizations get text => AppLocalizations.of(this)!;
}

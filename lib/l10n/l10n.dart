import 'package:flutter/widgets.dart';

import 'gen/app_localizations.dart';

export 'gen/app_localizations.dart';

extension AppLocalizationsContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

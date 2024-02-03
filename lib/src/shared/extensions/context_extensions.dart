import 'package:ficha_3det_victory/src/localization/generated/l10n.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  AppLocalizations get l => AppLocalizations.of(this);
}

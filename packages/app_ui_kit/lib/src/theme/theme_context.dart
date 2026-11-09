import 'package:flutter/material.dart';

import '../tokens/app_palette.dart';

/// Short access to the theme from a widget.
extension ThemeContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>() ?? AppPalette.light;

  TextTheme get text => Theme.of(this).textTheme;
}

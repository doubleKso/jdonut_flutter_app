import 'package:flutter/widgets.dart';

/// Corner radii.
abstract final class AppRadii {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 999;

  static const BorderRadius field = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius card = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius tile = BorderRadius.all(Radius.circular(md));
  static const BorderRadius button = BorderRadius.all(Radius.circular(pill));
}

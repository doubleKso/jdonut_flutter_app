/// Spacing scale (logical pixels). Layout code uses these, never raw numbers.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;

  /// Side gutter of every screen.
  static const double gutter = 24;

  /// Height of the primary pill button and of form fields.
  static const double buttonHeight = 52;
  static const double fieldHeight = 60;

  /// The back button and the progress ring in the registration header.
  static const double headerControl = 36;
}

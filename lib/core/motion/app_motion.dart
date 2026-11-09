import 'package:flutter/widgets.dart';

/// Every duration in the app. Animations take these, never raw numbers.
abstract final class AppDurations {
  /// What every duration collapses to under Reduce Motion. One millisecond,
  /// not zero: a zero-length AnimatedSize finishes inside its own layout pass
  /// and asserts, while 1 ms is still instant to the eye.
  static const reduced = Duration(milliseconds: 1);
  static const press = Duration(milliseconds: 110);
  static const short = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 350);
  static const long = Duration(milliseconds: 600);
  static const entrance = Duration(milliseconds: 650);
  static const pageTransition = Duration(milliseconds: 420);
  static const staggerStep = Duration(milliseconds: 90);
  static const morph = Duration(milliseconds: 280);
  static const shake = Duration(milliseconds: 450);
  static const shimmer = Duration(milliseconds: 1300);
  static const ringStep = Duration(milliseconds: 700);
  static const pointsSweep = Duration(milliseconds: 1600);
  static const ladderStep = Duration(milliseconds: 260);
  static const badgePop = Duration(milliseconds: 650);
  static const attentionPulse = Duration(milliseconds: 1100);
  static const carouselInterval = Duration(seconds: 4);
  static const carouselSlide = Duration(milliseconds: 550);
  static const drift = Duration(milliseconds: 1100);
  static const tabSwitch = Duration(milliseconds: 320);
}

/// Every curve in the app.
abstract final class AppCurves {
  static const Curve standard = Curves.easeOutCubic;
  static const Curve entrance = Curves.easeOutQuart;
  static const Curve emphasized = Curves.easeOutBack;
  static const Curve exit = Curves.easeInCubic;
  static const Curve pop = Curves.elasticOut;
  static const Curve sweep = Curves.easeInOutCubic;
  static const Curve pulse = Curves.easeInOut;
}

/// Distances and scales used by the motion.
abstract final class AppMotionValues {
  static const double pressedScale = 0.95;
  static const double entranceOffset = 28;
  static const double shakeDistance = 12;
  static const int shakeCycles = 3;
  static const double attentionScale = 1.07;
  static const double driftOffset = 80;
  static const double pageSlideFraction = 0.12;
}

/// Reduce Motion support: when the platform asks for fewer animations,
/// durations collapse to [AppDurations.reduced] and looping effects stop.
extension MotionContext on BuildContext {
  bool get reduceMotion => MediaQuery.maybeDisableAnimationsOf(this) ?? false;

  Duration motion(Duration duration) => reduceMotion ? AppDurations.reduced : duration;
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/motion/app_motion.dart';

/// Registration steps: the next step slides in from the side while the
/// previous one slides away (shared axis, horizontal).
Page<void> sharedAxisPage(GoRouterState state, Widget child) => CustomTransitionPage<void>(
  key: state.pageKey,
  child: child,
  transitionDuration: AppDurations.pageTransition,
  reverseTransitionDuration: AppDurations.pageTransition,
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    if (context.reduceMotion) return child;
    const shift = AppMotionValues.pageSlideFraction;
    final incoming = CurvedAnimation(parent: animation, curve: AppCurves.standard);
    final outgoing = CurvedAnimation(parent: secondaryAnimation, curve: AppCurves.standard);
    return SlideTransition(
      position: Tween(begin: const Offset(shift, 0), end: Offset.zero).animate(incoming),
      child: FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: const Interval(0.3, 1)),
        child: SlideTransition(
          position: Tween(begin: Offset.zero, end: const Offset(-shift, 0)).animate(outgoing),
          child: FadeTransition(
            opacity: Tween<double>(begin: 1, end: 0).animate(
              CurvedAnimation(parent: secondaryAnimation, curve: const Interval(0, 0.3)),
            ),
            child: child,
          ),
        ),
      ),
    );
  },
);

/// Top-level screens (onboarding, Welcome): fade through with a slight zoom.
Page<void> fadeThroughPage(GoRouterState state, Widget child) => CustomTransitionPage<void>(
  key: state.pageKey,
  child: child,
  transitionDuration: AppDurations.pageTransition,
  transitionsBuilder: (context, animation, _, child) {
    if (context.reduceMotion) return child;
    final curved = CurvedAnimation(parent: animation, curve: AppCurves.standard);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(scale: Tween<double>(begin: 0.96, end: 1).animate(curved), child: child),
    );
  },
);

/// Product detail: fades and rises in, giving the Hero image room to fly.
Page<void> riseInPage(GoRouterState state, Widget child) => CustomTransitionPage<void>(
  key: state.pageKey,
  child: child,
  transitionDuration: AppDurations.pageTransition,
  reverseTransitionDuration: AppDurations.pageTransition,
  transitionsBuilder: (context, animation, _, child) {
    if (context.reduceMotion) return child;
    final curved = CurvedAnimation(parent: animation, curve: AppCurves.standard);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(curved),
        child: child,
      ),
    );
  },
);

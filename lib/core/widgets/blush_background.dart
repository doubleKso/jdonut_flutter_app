import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

/// The soft pink gradient behind onboarding, registration and Welcome.
class BlushBackground extends StatelessWidget {
  const BlushBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [palette.blushTop, palette.blushBottom, palette.blushTop],
          stops: const [0, 0.6, 1],
        ),
      ),
      child: child,
    );
  }
}

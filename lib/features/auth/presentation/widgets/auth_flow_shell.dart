import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/widgets/blush_background.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../l10n/l10n.dart';
import 'step_progress_ring.dart';
import 'terms_footer.dart';

/// The frame around every registration / log-in step: back button, progress
/// ring and the terms footer. It stays put while the step inside it slides,
/// which is what lets the ring animate from one step to the next.
class AuthFlowShell extends StatelessWidget {
  const AuthFlowShell({
    required this.step,
    required this.totalSteps,
    required this.child,
    super.key,
  });

  final int step;
  final int totalSteps;
  final Widget child;

  @override
  Widget build(BuildContext context) => PopScope(
    // System back on the first step returns to onboarding instead of
    // closing the app; on later steps the inner navigator pops first.
    canPop: false,
    onPopInvokedWithResult: (didPop, _) {
      if (!didPop) context.go(RoutePaths.onboarding);
    },
    child: _scaffold(),
  );

  Widget _scaffold() => Scaffold(
    body: BlushBackground(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.gutter, AppSpacing.md, AppSpacing.gutter, 0),
              child: Row(
                children: [
                  const BackSquareButton(),
                  const Spacer(),
                  StepProgressRing(step: step, totalSteps: totalSteps),
                ],
              ),
            ),
            Expanded(child: child),
            const TermsFooter(),
          ],
        ),
      ),
    ),
  );
}

/// The white rounded back button. Pops to the previous step (which kept
/// what was typed), or returns to onboarding from the first step.
class BackSquareButton extends StatelessWidget {
  const BackSquareButton({super.key});

  @override
  Widget build(BuildContext context) => PressableScale(
    semanticLabel: context.l10n.back,
    onTap: () => context.canPop() ? context.pop() : context.go(RoutePaths.onboarding),
    child: Container(
      width: AppSpacing.headerControl,
      height: AppSpacing.headerControl,
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: AppRadii.field),
      child: Icon(Icons.arrow_back_rounded, size: AppSpacing.xl, color: context.palette.ink),
    ),
  );
}

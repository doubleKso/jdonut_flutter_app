import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../core/widgets/blush_background.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/staggered_entrance.dart';
import '../../../../l10n/l10n.dart';
import '../widgets/donut_circle_cluster.dart';
import '../widgets/social_sign_in_row.dart';
import '../widgets/terms_footer.dart';

/// Screen 1: the donut circles drift in, then the title and buttons follow.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const double _heroFraction = 0.48;

  @override
  Widget build(BuildContext context) {
    final heroHeight = MediaQuery.sizeOf(context).height * _heroFraction;
    return Scaffold(
      body: BlushBackground(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: heroHeight, child: const DonutCircleCluster())),
            const SliverFillRemaining(hasScrollBody: false, child: _OnboardingActions()),
          ],
        ),
      ),
    );
  }
}

class _OnboardingActions extends StatelessWidget {
  const _OnboardingActions();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = <Widget>[
      Text(l10n.onboardingTitle, style: context.text.displaySmall, textAlign: TextAlign.center),
      const SizedBox(height: AppSpacing.xxl),
      // `go`, not `push`: the flow must be the base location so that, once
      // the session appears, the guard redirects from the flow (to Welcome)
      // rather than from onboarding (to Home).
      PrimaryButton(label: l10n.letsGetStarted, onPressed: () => context.go(RoutePaths.registerPhone)),
      const SizedBox(height: AppSpacing.lg),
      const _LogInPrompt(),
      const SizedBox(height: AppSpacing.md),
      const SocialSignInRow(),
    ];
    return SafeArea(
      top: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter * 2),
            child: Column(
              children: [
                for (final (index, item) in items.indexed)
                  StaggeredEntrance(index: index, initialDelay: AppDurations.long, child: item),
              ],
            ),
          ),
          const Spacer(),
          StaggeredEntrance(index: items.length, initialDelay: AppDurations.long, child: const TermsFooter()),
        ],
      ),
    );
  }
}

class _LogInPrompt extends StatelessWidget {
  const _LogInPrompt();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('${l10n.alreadyHaveAccount} ', style: context.text.bodyMedium),
        GestureDetector(
          onTap: () => context.go(RoutePaths.loginPhone),
          child: Text(
            l10n.logIn,
            style: context.text.labelMedium?.copyWith(color: context.palette.berry),
          ),
        ),
      ],
    );
  }
}

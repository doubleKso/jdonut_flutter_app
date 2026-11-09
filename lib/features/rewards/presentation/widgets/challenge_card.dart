import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/formatting/mmk_format.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../core/widgets/pressable_scale.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/challenge.dart';
import 'challenge_art.dart';

/// "Eat 4 Coco donuts · 4/4 · EARN · 100 pts".
class ChallengeCard extends StatelessWidget {
  const ChallengeCard({required this.challenge, super.key});

  final Challenge challenge;

  static const double _artSize = 112;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: context.palette.surface, borderRadius: AppRadii.card),
      child: Row(
        children: [
          SizedBox.square(dimension: _artSize, child: ChallengeArtwork(challenge: challenge)),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(challenge.title, style: context.text.titleLarge),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.challengeProgress(challenge.progress, challenge.target), style: context.text.bodyLarge),
                const SizedBox(height: AppSpacing.md),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.sm,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    EarnButton(active: challenge.isComplete),
                    Text(l10n.pointsShort(formatCount(challenge.rewardPoints)), style: context.text.bodyLarge),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Cyan and gently pulsing when the challenge is complete, grey otherwise.
/// Press feedback on tap, no action.
class EarnButton extends StatefulWidget {
  const EarnButton({required this.active, super.key});

  final bool active;

  @override
  State<EarnButton> createState() => _EarnButtonState();
}

class _EarnButtonState extends State<EarnButton> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this, duration: AppDurations.attentionPulse);
  late final Animation<double> _curve = CurvedAnimation(parent: _pulse, curve: AppCurves.pulse);

  static const double _glowBlur = 14;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncPulse();
  }

  @override
  void didUpdateWidget(EarnButton old) {
    super.didUpdateWidget(old);
    if (old.active != widget.active) _syncPulse();
  }

  void _syncPulse() {
    if (widget.active && !context.reduceMotion) {
      if (!_pulse.isAnimating) _pulse.repeat(reverse: true);
    } else {
      _pulse
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return PressableScale(
      onTap: () {},
      semanticLabel: context.l10n.earn,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, child) => Transform.scale(
          scale: 1 + (AppMotionValues.attentionScale - 1) * _curve.value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl, vertical: AppSpacing.md),
            decoration: BoxDecoration(
              color: widget.active ? palette.sky : palette.pebble,
              borderRadius: AppRadii.button,
              boxShadow: widget.active
                  ? [BoxShadow(color: palette.sky.withValues(alpha: 0.6 * _curve.value), blurRadius: _glowBlur)]
                  : null,
            ),
            child: child,
          ),
        ),
        child: Text(context.l10n.earn, style: context.text.labelLarge?.copyWith(color: palette.onAccent)),
      ),
    );
  }
}

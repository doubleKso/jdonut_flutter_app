import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/l10n.dart';
import '../connectivity/connectivity_cubit.dart';
import '../motion/app_motion.dart';

/// A small pill that slides in while the device is offline.
class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final offline = context.select((ConnectivityCubit c) => c.state.isOffline);
    return AnimatedSize(
      duration: context.motion(AppDurations.medium),
      curve: AppCurves.standard,
      child: offline ? const _OfflinePill() : const SizedBox(width: double.infinity),
    );
  }
}

class _OfflinePill extends StatelessWidget {
  const _OfflinePill();

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(color: palette.ink, borderRadius: AppRadii.button),
        child: Row(
          children: [
            Icon(Icons.cloud_off_rounded, size: AppSpacing.lg, color: palette.onAccent),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                context.l10n.offlineBanner,
                style: context.text.bodySmall?.copyWith(color: palette.onAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

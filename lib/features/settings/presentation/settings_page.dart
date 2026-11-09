import 'dart:async';

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/pressable_scale.dart';
import '../../../l10n/l10n.dart';
import '../../auth/presentation/cubit/session_cubit.dart';

/// The Settings tab. Log out clears the session; the router's guard then
/// returns to onboarding.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final session = context.watch<SessionCubit>().state;
    return Scaffold(
      backgroundColor: context.palette.mist,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          children: [
            Text(l10n.settingsTitle, style: context.text.displaySmall),
            const SizedBox(height: AppSpacing.xxl),
            if (session != null)
              _SettingsTile(icon: Icons.phone_iphone_rounded, label: l10n.signedInAs(session.phone)),
            const SizedBox(height: AppSpacing.md),
            _SettingsTile(
              key: const Key('logout-row'),
              icon: Icons.logout_rounded,
              label: l10n.logOut,
              danger: true,
              onTap: () => unawaited(context.read<SessionCubit>().logOut()),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.label, this.onTap, this.danger = false, super.key});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final color = danger ? palette.danger : palette.ink;
    final tile = Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: palette.surface, borderRadius: AppRadii.card),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(label, style: context.text.titleMedium?.copyWith(color: color))),
          if (onTap != null) Icon(Icons.chevron_right_rounded, color: palette.fog),
        ],
      ),
    );
    return onTap == null ? tile : PressableScale(onTap: onTap, semanticLabel: label, child: tile);
  }
}

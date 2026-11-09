import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

/// The empty or error state of one section, with an optional retry.
class SectionMessage extends StatelessWidget {
  const SectionMessage.empty({this.height = _defaultHeight, super.key})
    : isError = false,
      onRetry = null;

  const SectionMessage.error({required this.onRetry, this.height = _defaultHeight, super.key})
    : isError = true;

  static const double _defaultHeight = 120;

  final bool isError;
  final VoidCallback? onRetry;
  final double height;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final l10n = context.l10n;
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(color: palette.surface, borderRadius: AppRadii.card),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isError ? Icons.error_outline_rounded : Icons.inbox_outlined,
            color: isError ? palette.danger : palette.fog,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            isError ? l10n.sectionError : l10n.sectionEmpty,
            style: context.text.bodyMedium?.copyWith(color: palette.slate),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
    );
  }
}

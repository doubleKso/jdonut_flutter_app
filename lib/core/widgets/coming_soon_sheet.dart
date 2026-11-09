import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

/// The placeholder for actions with no real integration (social sign-in,
/// legal documents, redeeming rewards).
Future<void> showComingSoonSheet(BuildContext context, String message) =>
    showModalBottomSheet<void>(
      context: context,
      // Over the whole screen, not just the nested flow or tab navigator.
      useRootNavigator: true,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            0,
            AppSpacing.gutter,
            AppSpacing.gutter,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sheetContext.l10n.comingSoonTitle, style: sheetContext.text.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(message, style: sheetContext.text.bodyLarge),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(sheetContext).pop(),
                  child: Text(sheetContext.l10n.gotIt),
                ),
              ),
            ],
          ),
        ),
      ),
    );

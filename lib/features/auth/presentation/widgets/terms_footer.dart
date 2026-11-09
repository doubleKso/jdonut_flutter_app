import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/coming_soon_sheet.dart';
import '../../../../l10n/l10n.dart';

/// "By continuing, you acknowledge … Terms of Use and Privacy Policy." The
/// two links open a placeholder sheet.
class TermsFooter extends StatelessWidget {
  const TermsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final base = context.text.bodySmall?.copyWith(color: context.palette.fog);
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.xxl, AppSpacing.sm, AppSpacing.xxl, AppSpacing.lg),
      child: Text.rich(
        TextSpan(
          style: base,
          children: [
            TextSpan(text: '${l10n.termsPrefix} '),
            _link(context, l10n.termsOfUse),
            TextSpan(text: ' ${l10n.termsJoin} '),
            _link(context, l10n.privacyPolicy),
            TextSpan(text: l10n.termsSuffix),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  InlineSpan _link(BuildContext context, String document) => WidgetSpan(
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    child: GestureDetector(
      onTap: () => showComingSoonSheet(context, context.l10n.legalDocumentUnavailable(document)),
      child: Text(
        document,
        style: context.text.bodySmall?.copyWith(color: context.palette.berry),
      ),
    ),
  );
}

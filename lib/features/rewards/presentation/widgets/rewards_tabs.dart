import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/motion/app_motion.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/entities/challenge.dart';

/// "Eat more earn more" | "Gift" — a cyan pill slides to the selected tab.
class RewardsTabs extends StatelessWidget {
  const RewardsTabs({required this.selected, required this.onSelected, super.key});

  final RewardsTab selected;
  final ValueChanged<RewardsTab> onSelected;

  static const double height = 48;
  static const double _horizontalPadding = AppSpacing.xl;
  static const double _minPadding = AppSpacing.sm;
  static const double _gap = AppSpacing.sm;
  static const double _border = 3;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => _tabs(context, constraints.maxWidth - AppSpacing.gutter * 2),
  );

  Widget _tabs(BuildContext context, double maxWidth) {
    final l10n = context.l10n;
    final style = context.text.titleMedium!;
    final labels = {RewardsTab.earn: l10n.tabEarn, RewardsTab.gift: l10n.tabGift};
    final widths = _fit({for (final e in labels.entries) e.key: _measure(context, e.value, style)}, maxWidth);
    final left = selected == RewardsTab.earn ? 0.0 : widths[RewardsTab.earn]! + _gap;
    return SizedBox(
      height: height,
      width: widths.values.reduce((a, b) => a + b) + _gap,
      child: Stack(
        children: [
          _pills(context, widths, (_) => context.palette.mist),
          AnimatedPositioned(
            duration: context.motion(AppDurations.tabSwitch),
            curve: AppCurves.standard,
            left: left,
            width: widths[selected],
            top: 0,
            bottom: 0,
            child: _pill(context, context.palette.sky),
          ),
          Row(
            children: [
              for (final (index, tab) in labels.keys.indexed) ...[
                if (index > 0) const SizedBox(width: _gap),
                _label(context, tab, labels[tab]!, widths[tab]!, style),
              ],
            ],
          ),
        ],
      ),
    );
  }

  /// Pill widths from the label widths. On a narrow screen (or with large
  /// text) the side padding shrinks first; if that is still too wide the
  /// pills share the room and the labels scale down to fit.
  static Map<RewardsTab, double> _fit(Map<RewardsTab, double> textWidths, double maxWidth) {
    final textTotal = textWidths.values.reduce((a, b) => a + b);
    final room = (maxWidth - _gap - textTotal) / (2 * textWidths.length);
    final padding = room.clamp(_minPadding, _horizontalPadding);
    final widths = textWidths.map((tab, w) => MapEntry(tab, w + padding * 2));
    final pillsTotal = widths.values.reduce((a, b) => a + b);
    if (pillsTotal + _gap <= maxWidth) return widths;
    final scale = (maxWidth - _gap) / pillsTotal;
    return widths.map((tab, w) => MapEntry(tab, w * scale));
  }

  double _measure(BuildContext context, String text, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: Directionality.of(context),
      textScaler: MediaQuery.textScalerOf(context),
      maxLines: 1,
    )..layout();
    final width = painter.width;
    painter.dispose();
    return width;
  }

  Widget _pills(BuildContext context, Map<RewardsTab, double> widths, Color Function(RewardsTab) color) => Row(
    children: [
      for (final (index, tab) in widths.keys.indexed) ...[
        if (index > 0) const SizedBox(width: _gap),
        SizedBox(width: widths[tab], child: _pill(context, color(tab))),
      ],
    ],
  );

  Widget _pill(BuildContext context, Color color) => DecoratedBox(
    decoration: BoxDecoration(
      color: color,
      borderRadius: AppRadii.button,
      border: Border.all(color: context.palette.surface, width: _border),
    ),
  );

  Widget _label(BuildContext context, RewardsTab tab, String text, double width, TextStyle style) {
    final isSelected = tab == selected;
    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onSelected(tab),
        child: SizedBox(
          width: width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _minPadding),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: context.motion(AppDurations.tabSwitch),
                style: style.copyWith(color: isSelected ? context.palette.onAccent : context.palette.ink),
                child: FittedBox(fit: BoxFit.scaleDown, child: Text(text, maxLines: 1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

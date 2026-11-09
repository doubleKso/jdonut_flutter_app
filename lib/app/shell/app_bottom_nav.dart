import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../core/motion/app_motion.dart';
import '../../l10n/l10n.dart';

/// One bottom-nav destination.
final class NavDestination {
  const NavDestination({required this.label, required this.icon});

  final String Function(AppLocalizations) label;
  final Widget Function(Color color) icon;
}

/// The cyan bottom bar. The active tab gets a pink pill with its label, and
/// the pill slides to the new tab while the tab widths animate with it.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({required this.destinations, required this.currentIndex, required this.onSelected, super.key});

  final List<NavDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onSelected;

  static const double barHeight = 72;
  static const double _pillHeight = 46;
  static const double _pillShare = 0.32;
  static const double _pillBorder = 2;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return Container(
      height: barHeight + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: BoxDecoration(
        color: palette.sky,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadii.xl)),
        boxShadow: [BoxShadow(color: palette.shadow, blurRadius: AppSpacing.lg)],
      ),
      child: LayoutBuilder(builder: (context, constraints) => _bar(context, constraints.maxWidth)),
    );
  }

  Widget _bar(BuildContext context, double width) {
    final duration = context.motion(AppDurations.medium);
    final pillWidth = width * _pillShare;
    final otherWidth = (width - pillWidth) / (destinations.length - 1);
    double slotWidth(int index) => index == currentIndex ? pillWidth : otherWidth;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        AnimatedPositioned(
          duration: duration,
          curve: AppCurves.standard,
          left: otherWidth * currentIndex + AppSpacing.xs,
          width: pillWidth - AppSpacing.sm,
          height: _pillHeight,
          child: _pill(context),
        ),
        Row(
          children: [
            for (var i = 0; i < destinations.length; i++)
              AnimatedContainer(
                duration: duration,
                curve: AppCurves.standard,
                width: slotWidth(i),
                child: _NavItem(
                  destination: destinations[i],
                  selected: i == currentIndex,
                  onTap: () => onSelected(i),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _pill(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: context.palette.berry,
      borderRadius: AppRadii.button,
      border: Border.all(color: context.palette.onAccent, width: _pillBorder),
    ),
  );
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.destination, required this.selected, required this.onTap});

  final NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = destination.label(context.l10n);
    final color = context.palette.onAccent;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: AppBottomNav.barHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              destination.icon(color),
              // Flexible: while the slot narrows mid-slide (or with large
              // text) the label fades out at the edge instead of overflowing.
              Flexible(
                child: AnimatedSize(
                  duration: context.motion(AppDurations.medium),
                  curve: AppCurves.standard,
                  child: selected
                      ? Padding(
                          padding: const EdgeInsets.only(left: AppSpacing.xs),
                          child: Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: context.text.labelMedium?.copyWith(color: color),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The Reward tab's crown, drawn so it matches the design without an icon font.
class CrownIcon extends StatelessWidget {
  const CrownIcon({required this.color, super.key});

  final Color color;

  static const double size = 24;

  @override
  Widget build(BuildContext context) => CustomPaint(size: const Size.square(size), painter: _CrownPainter(color));
}

class _CrownPainter extends CustomPainter {
  const _CrownPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final crown = Path()
      ..moveTo(w * 0.15, h * 0.78)
      ..lineTo(w * 0.1, h * 0.35)
      ..lineTo(w * 0.33, h * 0.55)
      ..lineTo(w * 0.5, h * 0.25)
      ..lineTo(w * 0.67, h * 0.55)
      ..lineTo(w * 0.9, h * 0.35)
      ..lineTo(w * 0.85, h * 0.78)
      ..close();
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.08
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(crown, stroke);
    for (final x in const [0.1, 0.5, 0.9]) {
      canvas.drawCircle(Offset(w * x, h * (x == 0.5 ? 0.2 : 0.3)), w * 0.06, Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(_CrownPainter old) => old.color != color;
}

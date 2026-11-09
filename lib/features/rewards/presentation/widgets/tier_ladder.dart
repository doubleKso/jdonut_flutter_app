import 'dart:math' as math;

import 'package:app_ui_kit/app_ui_kit.dart';
import 'package:flutter/material.dart';

import '../../../../core/formatting/mmk_format.dart';
import '../../../../core/motion/app_motion.dart';
import '../../../../l10n/l10n.dart';
import '../../../member/domain/entities/member.dart';

/// Silver → Gold → Platinum. The tiers appear in order, the current one is
/// highlighted, then the line towards the next tier fills.
class TierLadder extends StatefulWidget {
  const TierLadder({required this.member, super.key});

  final Member member;

  static const List<MemberTier> tiers = [MemberTier.silver, MemberTier.gold, MemberTier.platinum];

  @override
  State<TierLadder> createState() => _TierLadderState();
}

class _TierLadderState extends State<TierLadder> with SingleTickerProviderStateMixin {
  static const double _shieldSize = 40;
  static const double _baseRowHeight = 104;
  static const double _rowAppearFraction = 0.25;
  static const double _lineStart = 0.6;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDurations.ladderStep * TierLadder.tiers.length + AppDurations.ringStep,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.reduceMotion) {
      _controller.value = 1;
    } else if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// How much of the line below tier [index] is filled.
  double _segmentFill(int index) {
    final current = TierLadder.tiers.indexOf(widget.member.tier);
    if (index < current) return 1;
    return index == current ? widget.member.tierProgress : 0;
  }

  /// Rows are at least this tall and grow when large text wraps the caption;
  /// each row draws the line down to the next tier itself.
  @override
  Widget build(BuildContext context) {
    final minRowHeight = math.max(_baseRowHeight, MediaQuery.textScalerOf(context).scale(_baseRowHeight * 0.85));
    final last = TierLadder.tiers.length - 1;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Column(
        children: [
          for (final (index, tier) in TierLadder.tiers.indexed)
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: minRowHeight),
              child: CustomPaint(painter: index < last ? _segment(context, index) : null, child: _row(index, tier)),
            ),
        ],
      ),
    );
  }

  _LadderSegmentPainter _segment(BuildContext context, int index) => _LadderSegmentPainter(
    x: _shieldSize / 2,
    top: _shieldSize * 1.2,
    fill: _segmentFill(index) * const Interval(_lineStart, 1, curve: AppCurves.standard).transform(_controller.value),
    track: context.palette.track,
    filled: context.palette.slate,
  );

  Widget _row(int index, MemberTier tier) {
    final start = index * _rowAppearFraction;
    final t = Interval(start, start + _rowAppearFraction * 2, curve: AppCurves.entrance).transform(_controller.value);
    final isCurrent = tier == widget.member.tier;
    return Opacity(
      opacity: t,
      child: Transform.translate(
        offset: Offset(-AppMotionValues.entranceOffset * (1 - t), 0),
        child: _TierRow(tier: tier, member: widget.member, highlighted: isCurrent, shieldSize: _shieldSize),
      ),
    );
  }
}

class _TierRow extends StatelessWidget {
  const _TierRow({required this.tier, required this.member, required this.highlighted, required this.shieldSize});

  final MemberTier tier;
  final Member member;
  final bool highlighted;
  final double shieldSize;

  String _caption(AppLocalizations l10n) {
    if (tier == member.tier) return l10n.tierHereNow;
    if (tier.index < member.tier.index) return l10n.tierReached;
    if (tier == member.nextTier) {
      return l10n.tierPointsRemaining(formatCount(member.pointsToNextTier), l10n.tierName(tier.name));
    }
    return l10n.tierSoon;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedScale(
          scale: highlighted ? 1.1 : 1,
          duration: context.motion(AppDurations.medium),
          child: CustomPaint(size: Size(shieldSize, shieldSize * 1.1), painter: TierShieldPainter.of(context, tier)),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.tierName(tier.name), style: context.text.titleMedium),
              Text(
                _caption(l10n),
                style: context.text.bodyMedium?.copyWith(
                  color: highlighted ? context.palette.ink : context.palette.slate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// One piece of the line joining the shields: from below this row's shield
/// to the bottom of the row, filled up to the member's progress.
class _LadderSegmentPainter extends CustomPainter {
  const _LadderSegmentPainter({
    required this.x,
    required this.top,
    required this.fill,
    required this.track,
    required this.filled,
  });

  final double x;
  final double top;
  final double fill;
  final Color track;
  final Color filled;

  static const double _width = 3;

  @override
  void paint(Canvas canvas, Size size) {
    final bottom = size.height - AppSpacing.xs;
    final paint = Paint()
      ..strokeWidth = _width
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(x, top), Offset(x, bottom), paint..color = track);
    final end = top + (bottom - top) * fill.clamp(0, 1);
    if (end > top) canvas.drawLine(Offset(x, top), Offset(x, end), paint..color = filled);
  }

  @override
  bool shouldRepaint(_LadderSegmentPainter old) =>
      old.fill != fill || old.x != x || old.top != top || old.track != track || old.filled != filled;
}

/// A tier shield: tinted gradient, the tier's initial and 1–3 stars.
class TierShieldPainter extends CustomPainter {
  const TierShieldPainter({required this.color, required this.letter, required this.stars, required this.ink});

  factory TierShieldPainter.of(BuildContext context, MemberTier tier) {
    final palette = context.palette;
    final color = switch (tier) {
      MemberTier.gold => palette.gold,
      MemberTier.platinum => palette.platinum,
      _ => palette.silver,
    };
    return TierShieldPainter(
      color: color,
      letter: tier.name.substring(0, 1).toUpperCase(),
      stars: TierLadder.tiers.indexOf(tier) + 1,
      ink: palette.ink,
    );
  }

  final Color color;
  final String letter;
  final int stars;
  final Color ink;

  static const double _inkAlpha = 0.45;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final shield = Path()
      ..moveTo(w * 0.5, 0)
      ..quadraticBezierTo(w * 0.8, h * 0.1, w, h * 0.12)
      ..lineTo(w, h * 0.5)
      ..quadraticBezierTo(w, h * 0.85, w * 0.5, h)
      ..quadraticBezierTo(0, h * 0.85, 0, h * 0.5)
      ..lineTo(0, h * 0.12)
      ..quadraticBezierTo(w * 0.2, h * 0.1, w * 0.5, 0)
      ..close();
    final shade = Color.lerp(color, ink, 0.18)!;
    canvas.drawPath(
      shield,
      Paint()..shader = LinearGradient(colors: [color, shade], begin: Alignment.topLeft, end: Alignment.bottomRight)
          .createShader(Offset.zero & size),
    );
    _paintLetter(canvas, size);
    _paintStars(canvas, size);
  }

  void _paintLetter(Canvas canvas, Size size) {
    final painter = TextPainter(
      text: TextSpan(
        text: letter,
        style: AppTypography.title.copyWith(
          color: ink.withValues(alpha: _inkAlpha),
          fontFamily: AppTypography.packagedFontFamily,
          fontSize: size.width * 0.42,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, Offset((size.width - painter.width) / 2, size.height * 0.36));
    painter.dispose();
  }

  void _paintStars(Canvas canvas, Size size) {
    final paint = Paint()..color = ink.withValues(alpha: _inkAlpha);
    final r = size.width * 0.07;
    final gap = r * 2.4;
    final startX = size.width / 2 - gap * (stars - 1) / 2;
    for (var i = 0; i < stars; i++) {
      canvas.drawPath(_star(Offset(startX + gap * i, size.height * 0.26), r), paint);
    }
  }

  static Path _star(Offset c, double r) {
    const points = 5;
    final path = Path();
    for (var i = 0; i < points * 2; i++) {
      final radius = i.isEven ? r : r * 0.45;
      final angle = -math.pi / 2 + i * math.pi / points;
      final p = c + Offset(math.cos(angle), math.sin(angle)) * radius;
      i == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    return path..close();
  }

  @override
  bool shouldRepaint(TierShieldPainter old) => old.color != color || old.letter != letter;
}

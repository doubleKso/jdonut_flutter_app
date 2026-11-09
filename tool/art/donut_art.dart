import 'dart:math' as math;
import 'dart:ui';

import 'art_kit.dart';

enum Topping { sprinkles, drizzle, flakes, stripes, none }

/// How one donut looks.
final class DonutLook {
  const DonutLook(this.glaze, this.glazeShade, this.topping, {this.toppingColor});

  final Color glaze;
  final Color glazeShade;
  final Topping topping;

  /// Drizzle / stripe colour; sprinkles use the multicolour set.
  final Color? toppingColor;
}

/// Paints a glazed donut seen from above, centred on [center].
void paintDonut(Canvas canvas, Offset center, double radius, DonutLook look, {int seed = 1}) {
  final hole = radius * 0.32;
  paintShadow(canvas, center + Offset(0, radius * 0.1), radius * 2.05, radius * 1.85);
  // The shadow must not show through the hole: clear it back to transparent.
  canvas.drawCircle(center, hole, Paint()..blendMode = BlendMode.clear);
  _paintDough(canvas, center, radius, hole);
  final glaze = Path.combine(
    PathOperation.difference,
    wobblyCircle(center, radius * 0.9, seed: seed, amount: 0.045),
    wobblyCircle(center, hole * 1.22, seed: seed + 3, amount: 0.06),
  );
  canvas.drawPath(
    glaze,
    Paint()
      ..shader = Gradient.radial(
        center - Offset(radius * 0.35, radius * 0.4),
        radius * 1.6,
        [look.glaze, look.glazeShade],
      ),
  );
  canvas
    ..save()
    ..clipPath(glaze);
  _paintTopping(canvas, center, radius, hole, look, seed);
  _paintGloss(canvas, center, radius);
  canvas.restore();
}

void _paintDough(Canvas canvas, Offset center, double radius, double hole) {
  final dough = Path()
    ..fillType = PathFillType.evenOdd
    ..addOval(circle(center, radius))
    ..addOval(circle(center, hole));
  canvas.drawPath(
    dough,
    Paint()
      ..shader = Gradient.radial(
        center - Offset(radius * 0.3, radius * 0.3),
        radius * 1.4,
        [ArtInk.doughLight, ArtInk.doughDark],
      ),
  );
}

void _paintTopping(Canvas canvas, Offset c, double r, double hole, DonutLook look, int seed) {
  final random = math.Random(seed);
  switch (look.topping) {
    case Topping.sprinkles:
      _paintSprinkles(canvas, random, c, r, hole);
    case Topping.drizzle:
      _paintLines(canvas, c, r, look.toppingColor ?? ArtInk.berryDrizzle, zigzag: true);
    case Topping.stripes:
      _paintLines(canvas, c, r, look.toppingColor ?? ArtInk.chocolate, zigzag: false);
    case Topping.flakes:
      _paintFlakes(canvas, random, c, r, hole);
    case Topping.none:
      break;
  }
}

void _paintSprinkles(Canvas canvas, math.Random random, Offset c, double r, double hole) {
  const count = 70;
  for (var i = 0; i < count; i++) {
    paintSpeck(
      canvas,
      pointInRing(random, c, hole * 1.3, r * 0.86),
      Size(r * 0.085, r * 0.026),
      random.nextDouble() * math.pi,
      ArtInk.sprinkles[i % ArtInk.sprinkles.length],
    );
  }
}

void _paintFlakes(Canvas canvas, math.Random random, Offset c, double r, double hole) {
  const count = 140;
  for (var i = 0; i < count; i++) {
    paintSpeck(
      canvas,
      pointInRing(random, c, hole * 1.25, r * 0.9),
      Size(r * (0.04 + random.nextDouble() * 0.05), r * 0.018),
      random.nextDouble() * math.pi,
      i.isEven ? ArtInk.white : ArtInk.cream,
    );
  }
}

void _paintLines(Canvas canvas, Offset c, double r, Color color, {required bool zigzag}) {
  final paint = Paint()
    ..color = color
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = r * (zigzag ? 0.045 : 0.09);
  const lines = 6;
  for (var i = 0; i < lines; i++) {
    final y = c.dy - r + (i + 0.5) * (2 * r / lines);
    final path = Path()..moveTo(c.dx - r, y - r * 0.25);
    const segments = 8;
    for (var s = 1; s <= segments; s++) {
      final x = c.dx - r + s * (2 * r / segments);
      final dy = zigzag ? (s.isEven ? -1 : 1) * r * 0.09 : r * 0.05 * math.sin(s.toDouble());
      path.lineTo(x, y - r * 0.25 + s * r * 0.06 + dy);
    }
    canvas.drawPath(path, paint);
  }
}

void _paintGloss(Canvas canvas, Offset c, double r) {
  canvas.drawOval(
    Rect.fromCenter(center: c - Offset(r * 0.42, r * 0.5), width: r * 0.55, height: r * 0.22),
    Paint()
      ..color = ArtInk.highlight
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, r * 0.04),
  );
}

/// The donut looks used across the catalogue.
abstract final class DonutLooks {
  static const strawberrySprinkles = DonutLook(ArtInk.strawberry, ArtInk.strawberryShade, Topping.sprinkles);
  static const chocolateDrizzle = DonutLook(ArtInk.chocolate, ArtInk.chocolateShade, Topping.drizzle);
  static const grapeSprinkles = DonutLook(ArtInk.grape, ArtInk.grapeShade, Topping.sprinkles);
  static const chocolateCoconut = DonutLook(ArtInk.chocolate, ArtInk.chocolateShade, Topping.flakes);
  static const coconutFlakes = DonutLook(ArtInk.vanilla, ArtInk.vanillaShade, Topping.flakes);
  static const strawberryStripes = DonutLook(ArtInk.strawberry, ArtInk.strawberryShade, Topping.stripes);
  static const matchaDrizzle = DonutLook(ArtInk.matcha, ArtInk.matchaShade, Topping.drizzle, toppingColor: ArtInk.white);
  static const caramelPlain = DonutLook(ArtInk.caramel, ArtInk.caramelShade, Topping.none);
  static const vanillaSprinkles = DonutLook(ArtInk.vanilla, ArtInk.vanillaShade, Topping.sprinkles);
}

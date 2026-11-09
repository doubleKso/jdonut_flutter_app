import 'dart:math' as math;
import 'dart:ui';

import 'art_kit.dart';
import 'donut_art.dart';

/// Paints an open gift box of donuts, seen from above, filling [size].
void paintDonutBox(Canvas canvas, Size size, List<DonutLook> looks, {bool ribbon = false}) {
  final outer = Rect.fromLTWH(size.width * 0.06, size.height * 0.08, size.width * 0.88, size.height * 0.84);
  paintShadow(canvas, outer.center + Offset(0, size.height * 0.04), outer.width, outer.height);
  canvas.drawRRect(
    RRect.fromRectAndRadius(outer, Radius.circular(size.width * 0.04)),
    Paint()..color = ArtInk.cardboard,
  );
  final tray = outer.deflate(size.width * 0.035);
  canvas.drawRRect(
    RRect.fromRectAndRadius(tray, Radius.circular(size.width * 0.03)),
    Paint()..color = ArtInk.cardboardEdge,
  );
  _paintGrid(canvas, tray, looks);
  if (ribbon) _paintRibbon(canvas, outer, size);
}

void _paintGrid(Canvas canvas, Rect tray, List<DonutLook> looks) {
  const columns = 3;
  const rows = 2;
  final cell = Size(tray.width / columns, tray.height / rows);
  final radius = math.min(cell.width, cell.height) * 0.43;
  for (var i = 0; i < columns * rows; i++) {
    final center = tray.topLeft +
        Offset((i % columns + 0.5) * cell.width, (i ~/ columns + 0.5) * cell.height);
    paintDonut(canvas, center, radius, looks[i % looks.length], seed: i + 2);
  }
}

void _paintRibbon(Canvas canvas, Rect outer, Size size) {
  final paint = Paint()..color = ArtInk.ribbon;
  final band = size.width * 0.05;
  canvas
    ..drawRect(Rect.fromLTWH(outer.left, outer.center.dy - band / 2, outer.width, band), paint)
    ..drawCircle(outer.center, band * 1.1, paint);
}

/// Paints a plate of chocolate-chip cookies filling [size].
void paintCookiePlate(Canvas canvas, Size size, {int seed = 4}) {
  final center = size.center(Offset.zero);
  final plate = size.shortestSide * 0.46;
  paintShadow(canvas, center + Offset(0, plate * 0.08), plate * 2, plate * 1.8);
  canvas
    ..drawCircle(center, plate, Paint()..color = ArtInk.plateRim)
    ..drawCircle(center, plate * 0.86, Paint()..color = ArtInk.plate);
  final random = math.Random(seed);
  const cookies = 5;
  for (var i = 0; i < cookies; i++) {
    final angle = i / cookies * math.pi * 2;
    final at = center + Offset(math.cos(angle), math.sin(angle)) * plate * 0.42;
    _paintCookie(canvas, at, plate * 0.3, random);
  }
  _paintCookie(canvas, center, plate * 0.3, random);
}

void _paintCookie(Canvas canvas, Offset center, double radius, math.Random random) {
  canvas.drawPath(
    wobblyCircle(center, radius, seed: random.nextInt(50), amount: 0.05),
    Paint()
      ..shader = Gradient.radial(center - Offset(radius * 0.3, radius * 0.3), radius * 1.4,
          [ArtInk.cookie, ArtInk.cookieShade]),
  );
  const chips = 7;
  for (var i = 0; i < chips; i++) {
    canvas.drawCircle(
      pointInRing(random, center, 0, radius * 0.75),
      radius * 0.1,
      Paint()..color = ArtInk.chocolateShade,
    );
  }
}

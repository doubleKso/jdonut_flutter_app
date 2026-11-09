import 'dart:math' as math;
import 'dart:ui';

import 'art_kit.dart';
import 'donut_art.dart';

/// Paints a bakery display counter filling [size] — shop cards and banners.
void paintBakeryDisplay(Canvas canvas, Size size, {int seed = 1}) {
  final rect = Offset.zero & size;
  canvas.drawRect(
    rect,
    Paint()..shader = Gradient.linear(rect.topCenter, rect.bottomCenter, [ArtInk.wallTop, ArtInk.wallBottom]),
  );
  _paintLamps(canvas, size);
  const shelves = 3;
  for (var row = 0; row < shelves; row++) {
    final shelfY = size.height * (0.38 + row * 0.22);
    canvas.drawRect(
      Rect.fromLTWH(0, shelfY, size.width, size.height * 0.025),
      Paint()..color = ArtInk.shelf,
    );
    _paintPastryRow(canvas, size, shelfY, math.Random(seed * 10 + row));
  }
  canvas.drawRect(
    Rect.fromLTWH(0, size.height * 0.9, size.width, size.height * 0.1),
    Paint()..color = ArtInk.wood,
  );
}

void _paintLamps(Canvas canvas, Size size) {
  const lamps = 4;
  for (var i = 0; i < lamps; i++) {
    final at = Offset(size.width * (i + 0.5) / lamps, size.height * 0.08);
    canvas.drawCircle(
      at,
      size.height * 0.09,
      Paint()
        ..color = ArtInk.lamp
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, size.height * 0.05),
    );
  }
}

void _paintPastryRow(Canvas canvas, Size size, double shelfY, math.Random random) {
  final unit = size.height * 0.075;
  var x = unit;
  while (x < size.width - unit) {
    final center = Offset(x, shelfY - unit * 0.9);
    random.nextBool() ? _paintBread(canvas, center, unit) : _paintMiniDonut(canvas, center, unit, random);
    x += unit * (2.1 + random.nextDouble() * 0.4);
  }
}

void _paintBread(Canvas canvas, Offset center, double unit) {
  final loaf = Rect.fromCenter(center: center, width: unit * 1.9, height: unit * 1.1);
  canvas.drawOval(
    loaf,
    Paint()..shader = Gradient.linear(loaf.topCenter, loaf.bottomCenter, [ArtInk.bread, ArtInk.breadShade]),
  );
}

void _paintMiniDonut(Canvas canvas, Offset center, double unit, math.Random random) {
  const looks = [DonutLooks.strawberrySprinkles, DonutLooks.chocolateDrizzle, DonutLooks.caramelPlain];
  paintDonut(canvas, center, unit * 0.85, looks[random.nextInt(looks.length)], seed: random.nextInt(99));
}

/// Paints the member's illustrated portrait filling [size].
void paintAvatar(Canvas canvas, Size size) {
  final c = size.center(Offset.zero);
  final r = size.shortestSide / 2;
  canvas.drawCircle(c, r, Paint()..color = ArtInk.avatarBack);
  canvas
    ..save()
    ..clipPath(Path()..addOval(circle(c, r)));
  final hairBack = Rect.fromCenter(center: c + Offset(0, r * 0.12), width: r * 1.15, height: r * 1.45);
  canvas.drawRRect(RRect.fromRectAndRadius(hairBack, Radius.circular(r * 0.5)), Paint()..color = ArtInk.hair);
  canvas.drawOval(
    Rect.fromCenter(center: c + Offset(0, r * 1.05), width: r * 1.7, height: r * 1.0),
    Paint()..color = ArtInk.sweater,
  );
  final face = Rect.fromCenter(center: c, width: r * 0.82, height: r * 0.98);
  canvas.drawOval(face, Paint()..color = ArtInk.skin);
  _paintBangs(canvas, c, r, face);
  _paintFace(canvas, c, r);
  canvas.restore();
}

/// Hair falling over the top of the face, clipped to the face outline.
void _paintBangs(Canvas canvas, Offset c, double r, Rect face) {
  canvas
    ..save()
    ..clipPath(Path()..addOval(face))
    ..drawOval(
      Rect.fromCenter(center: c + Offset(r * 0.12, -r * 0.5), width: r * 1.2, height: r * 0.62),
      Paint()..color = ArtInk.hair,
    )
    ..restore();
}

void _paintFace(Canvas canvas, Offset c, double r) {
  final lineWork = Paint()
    ..color = ArtInk.frame
    ..style = PaintingStyle.stroke
    ..strokeWidth = r * 0.03;
  for (final side in const [-1.0, 1.0]) {
    final eye = c + Offset(side * r * 0.17, r * 0.04);
    canvas
      ..drawCircle(eye, r * 0.1, Paint()..color = ArtInk.lens)
      ..drawCircle(eye, r * 0.1, lineWork)
      ..drawCircle(eye, r * 0.028, Paint()..color = ArtInk.features);
  }
  canvas.drawArc(
    Rect.fromCenter(center: c + Offset(0, r * 0.24), width: r * 0.26, height: r * 0.14),
    0.2,
    math.pi - 0.4,
    false,
    lineWork,
  );
}

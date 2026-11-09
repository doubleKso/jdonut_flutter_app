import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'art_kit.dart';

/// Paints a tall iced coffee glass filling [size]. A [foamTop] glass gets a
/// thick whipped dalgona cap; otherwise it is a plain iced latte.
void paintCoffeeGlass(Canvas canvas, Size size, {required bool foamTop, int seed = 1}) {
  final w = size.width;
  final h = size.height;
  final glass = Path()
    ..moveTo(w * 0.27, h * 0.14)
    ..lineTo(w * 0.73, h * 0.14)
    ..lineTo(w * 0.66, h * 0.9)
    ..quadraticBezierTo(w * 0.5, h * 0.95, w * 0.34, h * 0.9)
    ..close();
  paintShadow(canvas, Offset(w * 0.5, h * 0.93), w * 0.42, h * 0.05);
  canvas
    ..save()
    ..clipPath(glass);
  _paintLayers(canvas, size);
  _paintIce(canvas, size, seed);
  canvas.restore();
  if (foamTop) _paintFoam(canvas, size, seed);
  _paintGlassEdge(canvas, glass, size);
}

void _paintLayers(Canvas canvas, Size size) {
  final rect = Offset.zero & size;
  canvas.drawRect(
    rect,
    Paint()
      ..shader = Gradient.linear(
        Offset(0, size.height * 0.2),
        Offset(0, size.height * 0.9),
        [ArtInk.milk, ArtInk.latte, ArtInk.coffee],
        [0.0, 0.45, 0.85],
      ),
  );
}

void _paintIce(Canvas canvas, Size size, int seed) {
  final random = math.Random(seed);
  final stroke = Paint()
    ..color = ArtInk.glass
    ..style = PaintingStyle.stroke
    ..strokeWidth = size.width * 0.012;
  const cubes = 5;
  for (var i = 0; i < cubes; i++) {
    final center = Offset(
      size.width * (0.36 + random.nextDouble() * 0.28),
      size.height * (0.22 + i * 0.12),
    );
    final cube = Rect.fromCenter(center: center, width: size.width * 0.16, height: size.width * 0.14);
    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(random.nextDouble() - 0.5)
      ..translate(-center.dx, -center.dy)
      ..drawRRect(RRect.fromRectAndRadius(cube, Radius.circular(size.width * 0.03)), stroke)
      ..restore();
  }
}

void _paintFoam(Canvas canvas, Size size, int seed) {
  final cap = Rect.fromCenter(
    center: Offset(size.width * 0.5, size.height * 0.14),
    width: size.width * 0.5,
    height: size.height * 0.12,
  );
  canvas.drawPath(
    wobblyCircle(cap.center, cap.width / 2, seed: seed, amount: 0.06).transform(_squash(cap)),
    Paint()
      ..shader = Gradient.linear(cap.topCenter, cap.bottomCenter, [ArtInk.cream, ArtInk.foam]),
  );
}

/// Squashes a circle path vertically around [cap] into an ellipse.
Float64List _squash(Rect cap) {
  final scaleY = cap.height / cap.width;
  final matrix = Float64List(16)
    ..[0] = 1
    ..[5] = scaleY
    ..[10] = 1
    ..[15] = 1
    ..[13] = cap.center.dy * (1 - scaleY);
  return matrix;
}

void _paintGlassEdge(Canvas canvas, Path glass, Size size) {
  canvas.drawPath(
    glass,
    Paint()
      ..color = ArtInk.glass
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.014,
  );
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.31, size.height * 0.2, size.width * 0.035, size.height * 0.55),
      Radius.circular(size.width * 0.02),
    ),
    Paint()..color = ArtInk.highlight,
  );
}

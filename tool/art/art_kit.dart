// Shared helpers for the asset illustrations. Tool-only code: it generates
// the PNGs in assets/images and is never shipped in the app.
import 'dart:math' as math;
import 'dart:ui';

/// Illustration colours. Kept here (not in the app theme) because they only
/// exist inside the generated pictures.
abstract final class ArtInk {
  static const shadow = Color(0x33000000);
  static const highlight = Color(0x59FFFFFF);
  static const doughLight = Color(0xFFF2BC72);
  static const doughDark = Color(0xFFB8702E);
  static const strawberry = Color(0xFFF48FB1);
  static const strawberryShade = Color(0xFFE05A8C);
  static const chocolate = Color(0xFF6B4231);
  static const chocolateShade = Color(0xFF3E2419);
  static const grape = Color(0xFFA48BEF);
  static const grapeShade = Color(0xFF7457D6);
  static const vanilla = Color(0xFFFFF7EC);
  static const vanillaShade = Color(0xFFEADBC6);
  static const matcha = Color(0xFFB5DB9A);
  static const matchaShade = Color(0xFF7FB35B);
  static const caramel = Color(0xFFE9A85F);
  static const caramelShade = Color(0xFFC07A2F);
  static const berryDrizzle = Color(0xFFF06292);
  static const white = Color(0xFFFFFFFF);
  static const cream = Color(0xFFF8EEDB);
  static const sprinkles = [
    Color(0xFFFFFFFF),
    Color(0xFF4FC3F7),
    Color(0xFFFFD54F),
    Color(0xFF81C784),
    Color(0xFFBA68C8),
    Color(0xFFFF8A65),
  ];
  static const coffee = Color(0xFF5B3A24);
  static const latte = Color(0xFFC89A6A);
  static const milk = Color(0xFFF4E8DA);
  static const foam = Color(0xFFE2B07A);
  static const glass = Color(0x66FFFFFF);
  static const cardboard = Color(0xFFF3D3AC);
  static const cardboardEdge = Color(0xFFD9AE7E);
  static const ribbon = Color(0xFFE53950);
  static const cookie = Color(0xFFD9A066);
  static const cookieShade = Color(0xFFB57A3E);
  static const plate = Color(0xFFFFFFFF);
  static const plateRim = Color(0xFFE7ECEF);
  static const wallTop = Color(0xFFF7DDAF);
  static const wallBottom = Color(0xFFE6B477);
  static const wood = Color(0xFF8D5A34);
  static const shelf = Color(0xFFC98F5A);
  static const lamp = Color(0xFFFFE9A8);
  static const bread = Color(0xFFD99A52);
  static const breadShade = Color(0xFFA9692C);
  static const skin = Color(0xFFF1C6A2);
  static const hair = Color(0xFF3B2A25);
  static const sweater = Color(0xFFF7A8CB);
  static const avatarBack = Color(0xFFFDE4D2);
  static const lens = Color(0x55FFFFFF);
  static const frame = Color(0xFF3B2A25);
  static const features = Color(0xFF4A3530);
}

/// A circle as a [Rect] for `addOval`.
Rect circle(Offset center, double radius) => Rect.fromCircle(center: center, radius: radius);

/// A soft drop shadow under an object.
void paintShadow(Canvas canvas, Offset center, double width, double height) {
  canvas.drawOval(
    Rect.fromCenter(center: center, width: width, height: height),
    Paint()
      ..color = ArtInk.shadow
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, width * 0.05),
  );
}

/// A closed blob whose radius wobbles around [radius] — glaze, foam, cream.
Path wobblyCircle(Offset center, double radius, {required int seed, double amount = 0.04}) {
  const steps = 96;
  final phase = seed * 1.7;
  final path = Path();
  for (var i = 0; i <= steps; i++) {
    final angle = i / steps * math.pi * 2;
    final wobble = 1 + amount * math.sin(angle * 7 + phase) + amount * 0.5 * math.sin(angle * 13 + phase);
    final point = center + Offset(math.cos(angle), math.sin(angle)) * radius * wobble;
    i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
  }
  return path..close();
}

/// Draws a small rotated rounded rectangle — a sprinkle, a flake.
void paintSpeck(Canvas canvas, Offset at, Size size, double angle, Color color) {
  canvas
    ..save()
    ..translate(at.dx, at.dy)
    ..rotate(angle);
  canvas.drawRRect(
    RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset.zero, width: size.width, height: size.height),
      Radius.circular(size.height / 2),
    ),
    Paint()..color = color,
  );
  canvas.restore();
}

/// A random point inside the ring between [inner] and [outer].
Offset pointInRing(math.Random random, Offset center, double inner, double outer) {
  final angle = random.nextDouble() * math.pi * 2;
  final distance = inner + random.nextDouble() * (outer - inner);
  return center + Offset(math.cos(angle), math.sin(angle)) * distance;
}

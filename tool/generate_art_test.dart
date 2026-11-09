// Generates the bundled illustration PNGs in assets/images.
//
// Run with:  flutter test tool/generate_art_test.dart
//
// Lives in tool/ (not test/) so the normal test run never rewrites assets.
import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding, test;

import 'art/box_art.dart';
import 'art/donut_art.dart';
import 'art/drink_art.dart';
import 'art/scene_art.dart';

typedef ArtPainter = void Function(Canvas canvas, Size size);

final class Art {
  const Art(this.name, this.size, this.paint);

  final String name;
  final Size size;
  final ArtPainter paint;
}

const _outputDirectory = 'assets/images';
const _product = Size(480, 480);
const _drink = Size(360, 480);
const _box = Size(560, 400);
const _scene = Size(600, 400);
const _avatar = Size(320, 320);

ArtPainter _donut(DonutLook look, int seed) =>
    (canvas, size) => paintDonut(canvas, size.center(Offset.zero), size.shortestSide * 0.42, look, seed: seed);

final List<Art> _catalogue = [
  Art('donut_coconut', _product, _donut(DonutLooks.chocolateCoconut, 7)),
  Art('donut_strawberry_chocolate', _product, _donut(DonutLooks.strawberryStripes, 3)),
  Art('donut_strawberry_sprinkles', _product, _donut(DonutLooks.strawberrySprinkles, 5)),
  Art('donut_grape_sprinkles', _product, _donut(DonutLooks.grapeSprinkles, 11)),
  Art('donut_matcha', _product, _donut(DonutLooks.matchaDrizzle, 13)),
  Art('donut_caramel', _product, _donut(DonutLooks.caramelPlain, 17)),
  Art('donut_vanilla_sprinkles', _product, _donut(DonutLooks.vanillaSprinkles, 19)),
  Art('donut_chocolate_drizzle', _product, _donut(DonutLooks.chocolateDrizzle, 23)),
  Art('coffee_dalgona', _drink, (c, s) => paintCoffeeGlass(c, s, foamTop: true, seed: 2)),
  Art('coffee_americano', _drink, (c, s) => paintCoffeeGlass(c, s, foamTop: false, seed: 5)),
  Art('box_mistletoe', _box, (c, s) => paintDonutBox(c, s, const [
        DonutLooks.strawberrySprinkles,
        DonutLooks.coconutFlakes,
        DonutLooks.chocolateDrizzle,
        DonutLooks.vanillaSprinkles,
        DonutLooks.strawberryStripes,
        DonutLooks.grapeSprinkles,
      ])),
  Art('box_christmas', _box, (c, s) => paintDonutBox(c, s, const [
        DonutLooks.matchaDrizzle,
        DonutLooks.strawberrySprinkles,
        DonutLooks.caramelPlain,
        DonutLooks.vanillaSprinkles,
        DonutLooks.chocolateCoconut,
        DonutLooks.strawberryStripes,
      ], ribbon: true)),
  const Art('cookies_set', _product, paintCookiePlate),
  Art('shop_myaynigone', _scene, (c, s) => paintBakeryDisplay(c, s, seed: 1)),
  Art('shop_sanchaung', _scene, (c, s) => paintBakeryDisplay(c, s, seed: 2)),
  Art('shop_bahan', _scene, (c, s) => paintBakeryDisplay(c, s, seed: 3)),
  Art('shop_downtown', _scene, (c, s) => paintBakeryDisplay(c, s, seed: 4)),
  Art('banner_new_shop', _scene, (c, s) => paintBakeryDisplay(c, s, seed: 5)),
  const Art('avatar_hania', _avatar, paintAvatar),
];

Future<void> _render(Art art) async {
  final recorder = PictureRecorder();
  art.paint(Canvas(recorder, Offset.zero & art.size), art.size);
  final image = await recorder.endRecording().toImage(art.size.width.toInt(), art.size.height.toInt());
  final png = await image.toByteData(format: ImageByteFormat.png);
  File('$_outputDirectory/${art.name}.png').writeAsBytesSync(png!.buffer.asUint8List());
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('renders every illustration to assets/images', () async {
    Directory(_outputDirectory).createSync(recursive: true);
    for (final art in _catalogue) {
      await _render(art);
    }
  });
}

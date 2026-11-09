// J'Donuts mock API.
//
//   cd mock_server
//   dart pub get
//   dart run bin/server.dart [--port 8080] [--latency 300] [--promo]
//
// Serves the same catalogue the app seeds from (../assets/seed/catalog.json)
// so the two can never drift apart. --promo changes it — a discount on the
// Coconut Donut and an extra banner — to show a background refresh landing.
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

const _apiVersion = 'v1';
const _catalogPath = '../assets/seed/catalog.json';
const _imagesPath = '../assets/images';
const _resources = ['products', 'banners', 'sections', 'shops'];

Future<void> main(List<String> args) async {
  final options = _Options.parse(args);
  final catalog = _loadCatalog(promo: options.promo);
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(_latency(options.latency))
      .addHandler(_router(catalog).call);
  final server = await io.serve(handler, InternetAddress.anyIPv4, options.port);
  stdout.writeln('J\'Donuts mock API on http://localhost:${server.port}/$_apiVersion '
      '(promo: ${options.promo}, latency: ${options.latency.inMilliseconds} ms)');
}

Router _router(Map<String, dynamic> catalog) {
  final router = Router()..get('/$_apiVersion/health', (Request _) => _ok({'status': 'ok'}));
  for (final resource in _resources) {
    router.get('/$_apiVersion/$resource', (Request _) => _ok(catalog[resource]));
  }
  router
    ..get('/$_apiVersion/images/<file>', _image)
    ..all('/<ignored|.*>', (Request request) => _error(HttpStatus.notFound, 'not_found', 'No route for ${request.url}'));
  return router;
}

Response _image(Request request, String file) {
  final image = File('$_imagesPath/${Uri.decodeComponent(file)}');
  if (file.contains('..') || !image.existsSync()) {
    return _error(HttpStatus.notFound, 'image_not_found', 'No image named $file');
  }
  return Response.ok(image.readAsBytesSync(), headers: {
    HttpHeaders.contentTypeHeader: 'image/png',
    HttpHeaders.cacheControlHeader: 'public, max-age=86400',
  });
}

Response _ok(Object? data) => _json(HttpStatus.ok, {'data': data, 'error': null, 'meta': _meta()});

Response _error(int status, String code, String message) => _json(status, {
  'data': null,
  'error': {'code': code, 'message': message},
  'meta': _meta(),
});

Map<String, String> _meta() => {
  'version': _apiVersion,
  'generatedAt': DateTime.now().toUtc().toIso8601String(),
};

Response _json(int status, Map<String, Object?> body) =>
    Response(status, body: jsonEncode(body), headers: {HttpHeaders.contentTypeHeader: 'application/json'});

Middleware _latency(Duration delay) => (inner) => (request) async {
  await Future<void>.delayed(delay);
  return inner(request);
};

Map<String, dynamic> _loadCatalog({required bool promo}) {
  final catalog = jsonDecode(File(_catalogPath).readAsStringSync()) as Map<String, dynamic>;
  if (promo) _applyPromo(catalog);
  return catalog;
}

/// Server-side changes the app should pick up on its next refresh.
void _applyPromo(Map<String, dynamic> catalog) {
  final products = (catalog['products'] as List).cast<Map<String, dynamic>>();
  products.firstWhere((p) => p['id'] == 'p_coconut')['discountPercent'] = 30;
  final banners = (catalog['banners'] as List).cast<Map<String, dynamic>>();
  banners.insert(0, {
    'id': 'b_weekend',
    'title': 'Weekend special: 30% off Coconut Donuts',
    'badge': 'Promo',
    'themeKey': 'tangerine',
    'imageUrl': '/v1/images/donut_coconut.png',
    'imageAsset': 'assets/images/donut_coconut.png',
    'sortOrder': -1,
  });
}

final class _Options {
  const _Options({required this.port, required this.latency, required this.promo});

  factory _Options.parse(List<String> args) {
    String? valueOf(String flag) {
      final index = args.indexOf(flag);
      return index >= 0 && index + 1 < args.length ? args[index + 1] : null;
    }

    return _Options(
      port: int.tryParse(valueOf('--port') ?? '') ?? 8080,
      latency: Duration(milliseconds: int.tryParse(valueOf('--latency') ?? '') ?? 300),
      promo: args.contains('--promo'),
    );
  }

  final int port;
  final Duration latency;
  final bool promo;
}

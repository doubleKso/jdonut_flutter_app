/// Turns the server-relative image paths in seed and API payloads
/// ("/v1/images/x.png") into absolute URLs on the configured API host.
final class ImageUrlResolver {
  const ImageUrlResolver(this.baseUrl);

  final String baseUrl;

  String resolve(String path) {
    if (path.isEmpty || path.startsWith('http')) return path;
    final base = baseUrl.endsWith('/') ? baseUrl.substring(0, baseUrl.length - 1) : baseUrl;
    return path.startsWith('/') ? '$base$path' : '$base/$path';
  }
}

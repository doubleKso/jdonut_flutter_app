import 'package:equatable/equatable.dart';

/// Where a picture comes from: a remote [url] (cached on disk once loaded)
/// and a bundled [asset] that shows when the device has never been online.
final class ImageRef extends Equatable {
  const ImageRef({this.url = '', this.asset = ''});

  final String url;
  final String asset;

  bool get hasUrl => url.isNotEmpty;
  bool get hasAsset => asset.isNotEmpty;

  @override
  List<Object?> get props => [url, asset];
}

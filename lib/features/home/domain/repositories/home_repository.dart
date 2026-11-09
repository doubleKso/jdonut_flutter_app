import 'package:app_core/app_core.dart';

import '../entities/home_entities.dart';

/// Home's public catalogue. Reads always come from the local database;
/// [refresh] pulls fresh data from the server into it.
abstract interface class HomeRepository {
  Stream<List<HomeBanner>> watchBanners();
  Stream<List<HomeSection>> watchSections();
  Stream<List<Shop>> watchShops();

  /// Fetches the latest catalogue and writes it locally. The UI picks the
  /// change up through the watch streams.
  Future<Result<void>> refresh();
}

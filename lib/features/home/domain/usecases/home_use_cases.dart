import 'package:app_core/app_core.dart';

import '../entities/home_entities.dart';
import '../repositories/home_repository.dart';

final class WatchBannersUseCase implements StreamUseCase<List<HomeBanner>, NoParams> {
  const WatchBannersUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Stream<List<HomeBanner>> call(NoParams params) => _repository.watchBanners();
}

final class WatchSectionsUseCase implements StreamUseCase<List<HomeSection>, NoParams> {
  const WatchSectionsUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Stream<List<HomeSection>> call(NoParams params) => _repository.watchSections();
}

final class WatchShopsUseCase implements StreamUseCase<List<Shop>, NoParams> {
  const WatchShopsUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Stream<List<Shop>> call(NoParams params) => _repository.watchShops();
}

final class RefreshCatalogUseCase implements UseCase<void, NoParams> {
  const RefreshCatalogUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Future<Result<void>> call(NoParams params) => _repository.refresh();
}

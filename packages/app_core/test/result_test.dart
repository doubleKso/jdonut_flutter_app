import 'package:app_core/app_core.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    test('a success exposes its value and no failure', () {
      const result = Result<int>.success(3);

      expect(result.isSuccess, isTrue);
      expect(result.dataOrNull, 3);
      expect(result.failureOrNull, isNull);
    });

    test('a failure exposes its failure and no value', () {
      const failure = NetworkFailure('offline');
      const result = Result<int>.failure(failure);

      expect(result.isFailure, isTrue);
      expect(result.dataOrNull, isNull);
      expect(result.failureOrNull, failure);
    });

    test('map transforms a success and passes a failure through', () {
      const ok = Result<int>.success(2);
      const err = Result<int>.failure(CacheFailure('disk'));

      expect(ok.map((v) => v * 10).dataOrNull, 20);
      expect(err.map((v) => v * 10).failureOrNull, const CacheFailure('disk'));
    });
  });
}

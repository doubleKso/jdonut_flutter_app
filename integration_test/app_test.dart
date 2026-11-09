import 'package:integration_test/integration_test.dart';

import '../test/support/flows.dart';
import '../test/support/test_app.dart';

/// Register → Welcome → Home → Product detail, on a real device or emulator:
///
///   flutter test integration_test
///
/// It runs the real app with in-memory storage, so every run starts from a
/// fresh install whatever the device already holds.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testApp('Register → Welcome → Home → Product detail', (tester, _) async {
    await registerAndOpenProduct(tester);
  }, size: null);
}

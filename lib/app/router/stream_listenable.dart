import 'dart:async';

import 'package:flutter/foundation.dart';

/// Notifies listeners on every event of [stream] — lets go_router re-run its
/// redirect when the session changes.
final class StreamListenable extends ChangeNotifier {
  StreamListenable(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}

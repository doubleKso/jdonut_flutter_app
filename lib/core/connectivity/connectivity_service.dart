import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Answers "can this device reach the internet right now?".
typedef ReachabilityProbe = Future<bool> Function();

abstract interface class ConnectivityService {
  Future<bool> isOnline();

  /// Emits whenever reachability may have changed. Single subscriber.
  Stream<bool> watchOnline();
}

/// connectivity_plus says whether a network interface is up; that is not the
/// same as being online (captive portal, Wi-Fi without internet). So every
/// change is confirmed with a real [ReachabilityProbe], and while offline the
/// probe repeats so recovery is noticed even without an interface change.
final class DeviceConnectivityService implements ConnectivityService {
  DeviceConnectivityService({
    required this._connectivity,
    required this._probe,
    this.recheckInterval = const Duration(seconds: 15),
  });

  final Connectivity _connectivity;
  final ReachabilityProbe _probe;
  final Duration recheckInterval;

  @override
  Future<bool> isOnline() async => _confirm(await _connectivity.checkConnectivity());

  Future<bool> _confirm(List<ConnectivityResult> results) async {
    if (results.every((result) => result == ConnectivityResult.none)) return false;
    return _probe();
  }

  @override
  Stream<bool> watchOnline() {
    late final StreamController<bool> controller;
    StreamSubscription<List<ConnectivityResult>>? changes;
    Timer? recheck;

    Future<void> publish(Future<bool> online) async {
      final value = await online;
      if (!controller.isClosed) controller.add(value);
    }

    controller = StreamController<bool>(
      onListen: () {
        unawaited(publish(isOnline()));
        changes = _connectivity.onConnectivityChanged.listen((r) => unawaited(publish(_confirm(r))));
        recheck = Timer.periodic(recheckInterval, (_) => unawaited(publish(isOnline())));
      },
      onCancel: () async {
        recheck?.cancel();
        await changes?.cancel();
      },
    );
    return controller.stream.distinct();
  }
}

/// A DNS lookup of [host]: fails fast in airplane mode and behind Wi-Fi
/// with no upstream connection.
ReachabilityProbe dnsProbe(String host, {Duration timeout = const Duration(seconds: 3)}) => () async {
  try {
    final addresses = await InternetAddress.lookup(host).timeout(timeout);
    return addresses.isNotEmpty && addresses.first.rawAddress.isNotEmpty;
  } on SocketException {
    return false;
  } on TimeoutException {
    return false;
  }
};

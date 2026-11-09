/// Every route in the app.
abstract final class RoutePaths {
  static const String onboarding = '/onboarding';

  static const String registerPhone = '/register/phone';
  static const String registerOtp = '/register/otp';
  static const String registerName = '/register/name';
  static const String registerDateOfBirth = '/register/dob';

  static const String loginPhone = '/login/phone';
  static const String loginOtp = '/login/otp';

  static const String welcome = '/welcome';

  static const String home = '/home';
  static const String rewards = '/rewards';
  static const String menu = '/menu';
  static const String wallet = '/wallet';
  static const String settings = '/settings';

  static const String productPattern = '/product/:id';
  static String product(String id) => '/product/$id';

  /// Query parameter that pre-fills the phone field (register ↔ log in links).
  static const String phoneQuery = 'phone';

  static const String registerPrefix = '/register';
  static const String loginPrefix = '/login';
}

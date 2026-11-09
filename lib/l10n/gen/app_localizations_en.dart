// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle => 'Round food for\nevery mood';

  @override
  String get letsGetStarted => 'LET\'S GET STARTED';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get logIn => 'Log In';

  @override
  String get termsPrefix =>
      'By continuing, you acknowledge that you have read and agree to our';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get termsJoin => 'and';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsSuffix => '.';

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String socialSignInUnavailable(String provider) {
    return '$provider sign-in isn\'t available in this demo yet.';
  }

  @override
  String legalDocumentUnavailable(String document) {
    return 'Our $document will be published here.';
  }

  @override
  String get gotIt => 'Got it';

  @override
  String get continueAction => 'CONTINUE';

  @override
  String get back => 'Back';

  @override
  String stepProgress(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get stepsComplete => 'All steps complete';

  @override
  String get phoneTitle => 'Enter your phone\nnumber';

  @override
  String get phoneHint => '09 123 456 789';

  @override
  String get phoneErrorRequired => 'Enter your phone number';

  @override
  String get phoneErrorInvalid =>
      'Enter a valid Myanmar mobile number, like 09 254 135 592';

  @override
  String get phoneNotRegistered => 'This number isn\'t registered yet.';

  @override
  String get registerInstead => 'Register now';

  @override
  String get phoneAlreadyRegistered => 'This number already has an account.';

  @override
  String get logInInstead => 'Log in instead';

  @override
  String get otpTitle => 'Verify your number';

  @override
  String otpSentTo(String phone) {
    return 'We\'ve sent 6 digit OTP to $phone';
  }

  @override
  String get otpDidntReceive => 'Didn\'t receive the code?';

  @override
  String get otpResendPrefix => 'resend in';

  @override
  String get otpResendSuffix => 'min';

  @override
  String get otpResend => 'Resend code';

  @override
  String otpIncorrect(int remaining) {
    String _temp0 = intl.Intl.pluralLogic(
      remaining,
      locale: localeName,
      other: 'That code is incorrect. $remaining tries left.',
      one: 'That code is incorrect. 1 try left.',
    );
    return '$_temp0';
  }

  @override
  String get otpLocked =>
      'Too many wrong codes. Request a new code to try again.';

  @override
  String get otpCodeSent => 'A new code is on its way.';

  @override
  String otpDigitLabel(int index) {
    return 'Digit $index of 6';
  }

  @override
  String get nameTitle => 'What\'s your\nname?';

  @override
  String get firstNameHint => 'First Name';

  @override
  String get lastNameHint => 'Last Name';

  @override
  String get nameErrorRequired => 'Enter your first name';

  @override
  String get nameErrorTooLong => 'Use 50 characters or fewer';

  @override
  String get nameErrorDigits => 'Names can\'t include numbers';

  @override
  String get nameErrorCharacters => 'Use letters and spaces only';

  @override
  String get dobTitle => 'What\'s your\ndate of birth?';

  @override
  String get monthHint => 'Month';

  @override
  String get dayHint => 'Day';

  @override
  String get yearHint => 'Year';

  @override
  String get dobErrorInvalidDate => 'That date doesn\'t exist';

  @override
  String get dobErrorFuture => 'Your birthday can\'t be in the future';

  @override
  String dobErrorTooYoung(int age) {
    return 'You need to be at least $age to join';
  }

  @override
  String get welcomeTitle => 'Welcome to the\nworld of J\'donuts';

  @override
  String get letsExplore => 'LET\'S EXPLORE';

  @override
  String tierName(String tier) {
    String _temp0 = intl.Intl.selectLogic(tier, {
      'bronze': 'Bronze',
      'silver': 'Silver',
      'gold': 'Gold',
      'platinum': 'Platinum',
      'other': 'Member',
    });
    return '$_temp0';
  }

  @override
  String memberTierLabel(String tier) {
    return '$tier member';
  }

  @override
  String pointsToNextTier(String points, String tier) {
    return '$points points left to become $tier Member';
  }

  @override
  String get topTierReached => 'You\'re at our top tier';

  @override
  String notifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count new notifications',
      one: '1 new notification',
      zero: 'No new notifications',
    );
    return '$_temp0';
  }

  @override
  String memberPhoto(String name) {
    return '$name\'s photo';
  }

  @override
  String seeAll(String section) {
    return 'See all $section';
  }

  @override
  String get sectionEmpty => 'Nothing here yet — check back soon.';

  @override
  String get sectionError => 'We couldn\'t load this.';

  @override
  String get retry => 'Try again';

  @override
  String shopsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'There are $count J\'Donut shops near you.😋',
      one: 'There is 1 J\'Donut shop near you.😋',
    );
    return '$_temp0';
  }

  @override
  String get exploreNow => 'EXPLORE NOW';

  @override
  String get orderOnline => 'Order Online';

  @override
  String get offlineBanner => 'You\'re offline — showing saved data';

  @override
  String get refreshFailed => 'Couldn\'t refresh — showing saved data.';

  @override
  String discountOff(int percent) {
    return '$percent% off';
  }

  @override
  String get newBadge => 'New';

  @override
  String get whatsThis => 'What\'s\nthis?';

  @override
  String get addToCart => 'ADD TO CART';

  @override
  String addedToCart(int quantity, String name) {
    return 'Added $quantity × $name to your cart';
  }

  @override
  String get cartFailed => 'Couldn\'t add that to your cart. Please try again.';

  @override
  String get increaseQuantity => 'Add one';

  @override
  String get decreaseQuantity => 'Remove one';

  @override
  String quantityLabel(int quantity) {
    return 'Quantity $quantity';
  }

  @override
  String get productNotFound => 'This product isn\'t available any more.';

  @override
  String get rewardsTitle => 'J\' Donuts Rewards';

  @override
  String get rewardsPill => 'Rewards';

  @override
  String get tierHereNow => 'You\'re here now';

  @override
  String tierPointsRemaining(String points, String tier) {
    return '$points pts Remaining\nto become $tier';
  }

  @override
  String get tierSoon => 'You\'ll be here soon';

  @override
  String get tierReached => 'Reached';

  @override
  String get totalPoints => 'Total points';

  @override
  String get tabEarn => 'Eat more earn more';

  @override
  String get tabGift => 'Gift';

  @override
  String get earn => 'EARN';

  @override
  String pointsShort(String points) {
    return '$points pts';
  }

  @override
  String challengeProgress(int progress, int target) {
    return '$progress/$target';
  }

  @override
  String get earnSoon => 'Redeeming rewards is coming soon.';

  @override
  String get challengesEmpty => 'No challenges here yet.';

  @override
  String get navHome => 'Home';

  @override
  String get navReward => 'Reward';

  @override
  String get navMenu => 'Menu';

  @override
  String get navWallet => 'Wallet';

  @override
  String get navSettings => 'Settings';

  @override
  String placeholderBody(String section) {
    return '$section is coming soon.';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String signedInAs(String phone) {
    return 'Signed in as $phone';
  }

  @override
  String get logOut => 'Log out';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get networkError => 'Check your connection and try again.';
}

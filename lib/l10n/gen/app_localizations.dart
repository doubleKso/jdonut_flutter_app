import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'J\'Donuts'**
  String get appTitle;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Round food for\nevery mood'**
  String get onboardingTitle;

  /// No description provided for @letsGetStarted.
  ///
  /// In en, this message translates to:
  /// **'LET\'S GET STARTED'**
  String get letsGetStarted;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @termsPrefix.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our'**
  String get termsPrefix;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @termsJoin.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get termsJoin;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsSuffix.
  ///
  /// In en, this message translates to:
  /// **'.'**
  String get termsSuffix;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonTitle;

  /// No description provided for @socialSignInUnavailable.
  ///
  /// In en, this message translates to:
  /// **'{provider} sign-in isn\'t available in this demo yet.'**
  String socialSignInUnavailable(String provider);

  /// No description provided for @legalDocumentUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Our {document} will be published here.'**
  String legalDocumentUnavailable(String document);

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continueAction;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @stepProgress.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepProgress(int current, int total);

  /// No description provided for @stepsComplete.
  ///
  /// In en, this message translates to:
  /// **'All steps complete'**
  String get stepsComplete;

  /// No description provided for @phoneTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone\nnumber'**
  String get phoneTitle;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'09 123 456 789'**
  String get phoneHint;

  /// No description provided for @phoneErrorRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get phoneErrorRequired;

  /// No description provided for @phoneErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Myanmar mobile number, like 09 254 135 592'**
  String get phoneErrorInvalid;

  /// No description provided for @phoneNotRegistered.
  ///
  /// In en, this message translates to:
  /// **'This number isn\'t registered yet.'**
  String get phoneNotRegistered;

  /// No description provided for @registerInstead.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerInstead;

  /// No description provided for @phoneAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This number already has an account.'**
  String get phoneAlreadyRegistered;

  /// No description provided for @logInInstead.
  ///
  /// In en, this message translates to:
  /// **'Log in instead'**
  String get logInInstead;

  /// No description provided for @otpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get otpTitle;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent 6 digit OTP to {phone}'**
  String otpSentTo(String phone);

  /// No description provided for @otpDidntReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get otpDidntReceive;

  /// No description provided for @otpResendPrefix.
  ///
  /// In en, this message translates to:
  /// **'resend in'**
  String get otpResendPrefix;

  /// No description provided for @otpResendSuffix.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get otpResendSuffix;

  /// No description provided for @otpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get otpResend;

  /// No description provided for @otpIncorrect.
  ///
  /// In en, this message translates to:
  /// **'{remaining, plural, =1{That code is incorrect. 1 try left.} other{That code is incorrect. {remaining} tries left.}}'**
  String otpIncorrect(int remaining);

  /// No description provided for @otpLocked.
  ///
  /// In en, this message translates to:
  /// **'Too many wrong codes. Request a new code to try again.'**
  String get otpLocked;

  /// No description provided for @otpCodeSent.
  ///
  /// In en, this message translates to:
  /// **'A new code is on its way.'**
  String get otpCodeSent;

  /// No description provided for @otpDigitLabel.
  ///
  /// In en, this message translates to:
  /// **'Digit {index} of 6'**
  String otpDigitLabel(int index);

  /// No description provided for @nameTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your\nname?'**
  String get nameTitle;

  /// No description provided for @firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameHint;

  /// No description provided for @lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameHint;

  /// No description provided for @nameErrorRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get nameErrorRequired;

  /// No description provided for @nameErrorTooLong.
  ///
  /// In en, this message translates to:
  /// **'Use 50 characters or fewer'**
  String get nameErrorTooLong;

  /// No description provided for @nameErrorDigits.
  ///
  /// In en, this message translates to:
  /// **'Names can\'t include numbers'**
  String get nameErrorDigits;

  /// No description provided for @nameErrorCharacters.
  ///
  /// In en, this message translates to:
  /// **'Use letters and spaces only'**
  String get nameErrorCharacters;

  /// No description provided for @dobTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your\ndate of birth?'**
  String get dobTitle;

  /// No description provided for @monthHint.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthHint;

  /// No description provided for @dayHint.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get dayHint;

  /// No description provided for @yearHint.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get yearHint;

  /// No description provided for @dobErrorInvalidDate.
  ///
  /// In en, this message translates to:
  /// **'That date doesn\'t exist'**
  String get dobErrorInvalidDate;

  /// No description provided for @dobErrorFuture.
  ///
  /// In en, this message translates to:
  /// **'Your birthday can\'t be in the future'**
  String get dobErrorFuture;

  /// No description provided for @dobErrorTooYoung.
  ///
  /// In en, this message translates to:
  /// **'You need to be at least {age} to join'**
  String dobErrorTooYoung(int age);

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the\nworld of J\'donuts'**
  String get welcomeTitle;

  /// No description provided for @letsExplore.
  ///
  /// In en, this message translates to:
  /// **'LET\'S EXPLORE'**
  String get letsExplore;

  /// No description provided for @tierName.
  ///
  /// In en, this message translates to:
  /// **'{tier, select, bronze{Bronze} silver{Silver} gold{Gold} platinum{Platinum} other{Member}}'**
  String tierName(String tier);

  /// No description provided for @memberTierLabel.
  ///
  /// In en, this message translates to:
  /// **'{tier} member'**
  String memberTierLabel(String tier);

  /// No description provided for @pointsToNextTier.
  ///
  /// In en, this message translates to:
  /// **'{points} points left to become {tier} Member'**
  String pointsToNextTier(String points, String tier);

  /// No description provided for @topTierReached.
  ///
  /// In en, this message translates to:
  /// **'You\'re at our top tier'**
  String get topTierReached;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No new notifications} =1{1 new notification} other{{count} new notifications}}'**
  String notifications(int count);

  /// No description provided for @memberPhoto.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s photo'**
  String memberPhoto(String name);

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all {section}'**
  String seeAll(String section);

  /// No description provided for @sectionEmpty.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet — check back soon.'**
  String get sectionEmpty;

  /// No description provided for @sectionError.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t load this.'**
  String get sectionError;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @shopsTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{There is 1 J\'Donut shop near you.😋} other{There are {count} J\'Donut shops near you.😋}}'**
  String shopsTitle(int count);

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'EXPLORE NOW'**
  String get exploreNow;

  /// No description provided for @orderOnline.
  ///
  /// In en, this message translates to:
  /// **'Order Online'**
  String get orderOnline;

  /// No description provided for @offlineBanner.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline — showing saved data'**
  String get offlineBanner;

  /// No description provided for @refreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t refresh — showing saved data.'**
  String get refreshFailed;

  /// No description provided for @discountOff.
  ///
  /// In en, this message translates to:
  /// **'{percent}% off'**
  String discountOff(int percent);

  /// No description provided for @newBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newBadge;

  /// No description provided for @whatsThis.
  ///
  /// In en, this message translates to:
  /// **'What\'s\nthis?'**
  String get whatsThis;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'ADD TO CART'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'Added {quantity} × {name} to your cart'**
  String addedToCart(int quantity, String name);

  /// No description provided for @cartFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t add that to your cart. Please try again.'**
  String get cartFailed;

  /// No description provided for @increaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Add one'**
  String get increaseQuantity;

  /// No description provided for @decreaseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Remove one'**
  String get decreaseQuantity;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity {quantity}'**
  String quantityLabel(int quantity);

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'This product isn\'t available any more.'**
  String get productNotFound;

  /// No description provided for @rewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'J\' Donuts Rewards'**
  String get rewardsTitle;

  /// No description provided for @rewardsPill.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsPill;

  /// No description provided for @tierHereNow.
  ///
  /// In en, this message translates to:
  /// **'You\'re here now'**
  String get tierHereNow;

  /// No description provided for @tierPointsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{points} pts Remaining\nto become {tier}'**
  String tierPointsRemaining(String points, String tier);

  /// No description provided for @tierSoon.
  ///
  /// In en, this message translates to:
  /// **'You\'ll be here soon'**
  String get tierSoon;

  /// No description provided for @tierReached.
  ///
  /// In en, this message translates to:
  /// **'Reached'**
  String get tierReached;

  /// No description provided for @totalPoints.
  ///
  /// In en, this message translates to:
  /// **'Total points'**
  String get totalPoints;

  /// No description provided for @tabEarn.
  ///
  /// In en, this message translates to:
  /// **'Eat more earn more'**
  String get tabEarn;

  /// No description provided for @tabGift.
  ///
  /// In en, this message translates to:
  /// **'Gift'**
  String get tabGift;

  /// No description provided for @earn.
  ///
  /// In en, this message translates to:
  /// **'EARN'**
  String get earn;

  /// No description provided for @pointsShort.
  ///
  /// In en, this message translates to:
  /// **'{points} pts'**
  String pointsShort(String points);

  /// No description provided for @challengeProgress.
  ///
  /// In en, this message translates to:
  /// **'{progress}/{target}'**
  String challengeProgress(int progress, int target);

  /// No description provided for @earnSoon.
  ///
  /// In en, this message translates to:
  /// **'Redeeming rewards is coming soon.'**
  String get earnSoon;

  /// No description provided for @challengesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No challenges here yet.'**
  String get challengesEmpty;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navReward.
  ///
  /// In en, this message translates to:
  /// **'Reward'**
  String get navReward;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @navWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get navWallet;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @placeholderBody.
  ///
  /// In en, this message translates to:
  /// **'{section} is coming soon.'**
  String placeholderBody(String section);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @signedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {phone}'**
  String signedInAs(String phone);

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logOut;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get networkError;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

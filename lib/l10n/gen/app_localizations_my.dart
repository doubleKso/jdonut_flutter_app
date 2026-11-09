// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'J\'Donuts';

  @override
  String get onboardingTitle => 'စိတ်ခံစားမှုတိုင်းအတွက်\nအဝိုင်းလေးများ';

  @override
  String get letsGetStarted => 'စတင်လိုက်ရအောင်';

  @override
  String get alreadyHaveAccount => 'အကောင့်ရှိပြီးသားလား?';

  @override
  String get logIn => 'ဝင်ရောက်ရန်';

  @override
  String get termsPrefix => 'ဆက်လက်ဆောင်ရွက်ခြင်းဖြင့် ကျွန်ုပ်တို့၏';

  @override
  String get termsOfUse => 'အသုံးပြုမှုစည်းမျဉ်းများ';

  @override
  String get termsJoin => 'နှင့်';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးအချက်အလက်မူဝါဒ';

  @override
  String get termsSuffix => ' ကို ဖတ်ရှုပြီး သဘောတူကြောင်း အသိအမှတ်ပြုပါသည်။';

  @override
  String get comingSoonTitle => 'မကြာမီ လာမည်';

  @override
  String socialSignInUnavailable(String provider) {
    return '$provider ဖြင့် ဝင်ရောက်ခြင်းကို ဤဗားရှင်းတွင် မရနိုင်သေးပါ။';
  }

  @override
  String legalDocumentUnavailable(String document) {
    return '$document ကို ဤနေရာတွင် ထုတ်ပြန်ပါမည်။';
  }

  @override
  String get gotIt => 'သိပါပြီ';

  @override
  String get continueAction => 'ဆက်လုပ်ရန်';

  @override
  String get back => 'နောက်သို့';

  @override
  String stepProgress(int current, int total) {
    return 'အဆင့် $total ခုအနက် $current';
  }

  @override
  String get stepsComplete => 'အဆင့်အားလုံး ပြီးဆုံးပါပြီ';

  @override
  String get phoneTitle => 'သင့်ဖုန်းနံပါတ်ကို\nထည့်ပါ';

  @override
  String get phoneHint => '09 123 456 789';

  @override
  String get phoneErrorRequired => 'ဖုန်းနံပါတ် ထည့်ပါ';

  @override
  String get phoneErrorInvalid =>
      'မြန်မာမိုဘိုင်းနံပါတ် မှန်ကန်စွာ ထည့်ပါ (ဥပမာ 09 254 135 592)';

  @override
  String get phoneNotRegistered => 'ဤနံပါတ်ဖြင့် စာရင်းမသွင်းရသေးပါ။';

  @override
  String get registerInstead => 'စာရင်းသွင်းရန်';

  @override
  String get phoneAlreadyRegistered =>
      'ဤနံပါတ်ဖြင့် အကောင့်ရှိပြီးသား ဖြစ်ပါသည်။';

  @override
  String get logInInstead => 'ဝင်ရောက်ရန်';

  @override
  String get otpTitle => 'သင့်နံပါတ်ကို အတည်ပြုပါ';

  @override
  String otpSentTo(String phone) {
    return '$phone သို့ ဂဏန်း ၆ လုံးပါ OTP ပို့ထားပါသည်';
  }

  @override
  String get otpDidntReceive => 'ကုဒ် မရရှိဘူးလား?';

  @override
  String get otpResendPrefix => 'ပြန်ပို့ရန်';

  @override
  String get otpResendSuffix => 'မိနစ်';

  @override
  String get otpResend => 'ကုဒ် ပြန်ပို့ရန်';

  @override
  String otpIncorrect(int remaining) {
    String _temp0 = intl.Intl.pluralLogic(
      remaining,
      locale: localeName,
      other: 'ကုဒ် မှားနေပါသည်။ နောက်ထပ် $remaining ကြိမ် ကြိုးစားနိုင်ပါသည်။',
    );
    return '$_temp0';
  }

  @override
  String get otpLocked =>
      'ကုဒ် အကြိမ်များစွာ မှားသွားပါပြီ။ ထပ်မံကြိုးစားရန် ကုဒ်အသစ် တောင်းခံပါ။';

  @override
  String get otpCodeSent => 'ကုဒ်အသစ် ပို့ပေးလိုက်ပါပြီ။';

  @override
  String otpDigitLabel(int index) {
    return '၆ လုံးအနက် $index လုံးမြောက်';
  }

  @override
  String get nameTitle => 'သင့်အမည်က\nဘာလဲ?';

  @override
  String get firstNameHint => 'အမည်';

  @override
  String get lastNameHint => 'နောက်အမည်';

  @override
  String get nameErrorRequired => 'အမည် ထည့်ပါ';

  @override
  String get nameErrorTooLong => 'စာလုံး ၅၀ ထက် မပိုရပါ';

  @override
  String get nameErrorDigits => 'အမည်တွင် ဂဏန်း မပါရပါ';

  @override
  String get nameErrorCharacters => 'စာလုံးနှင့် နေရာလွတ်သာ အသုံးပြုပါ';

  @override
  String get dobTitle => 'သင့်မွေးနေ့က\nဘယ်နေ့လဲ?';

  @override
  String get monthHint => 'လ';

  @override
  String get dayHint => 'ရက်';

  @override
  String get yearHint => 'ခုနှစ်';

  @override
  String get dobErrorInvalidDate => 'ထိုရက်စွဲ မရှိပါ';

  @override
  String get dobErrorFuture => 'မွေးနေ့သည် အနာဂတ်ရက် မဖြစ်နိုင်ပါ';

  @override
  String dobErrorTooYoung(int age) {
    return 'အသက် $age နှစ်နှင့်အထက် ဖြစ်ရပါမည်';
  }

  @override
  String get welcomeTitle => 'J\'donuts ကမ္ဘာမှ\nကြိုဆိုပါတယ်';

  @override
  String get letsExplore => 'စူးစမ်းကြည့်ရအောင်';

  @override
  String tierName(String tier) {
    String _temp0 = intl.Intl.selectLogic(tier, {
      'bronze': 'ကြေးနီ',
      'silver': 'ငွေ',
      'gold': 'ရွှေ',
      'platinum': 'ပလက်တီနမ်',
      'other': 'အဖွဲ့ဝင်',
    });
    return '$_temp0';
  }

  @override
  String memberTierLabel(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String pointsToNextTier(String points, String tier) {
    return '$tier အဖွဲ့ဝင်ဖြစ်ရန် $points မှတ် လိုပါသေးသည်';
  }

  @override
  String get topTierReached => 'အမြင့်ဆုံးအဆင့် ရောက်ပါပြီ';

  @override
  String notifications(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'အသိပေးချက်အသစ် $count ခု',
      zero: 'အသိပေးချက်အသစ် မရှိပါ',
    );
    return '$_temp0';
  }

  @override
  String memberPhoto(String name) {
    return '$name ၏ ဓာတ်ပုံ';
  }

  @override
  String seeAll(String section) {
    return '$section အားလုံး ကြည့်ရန်';
  }

  @override
  String get sectionEmpty => 'ယခုအချိန်တွင် မရှိသေးပါ။';

  @override
  String get sectionError => 'ဖွင့်၍ မရပါ။';

  @override
  String get retry => 'ထပ်စမ်းရန်';

  @override
  String shopsTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'သင့်အနီးတွင် J\'Donut ဆိုင် $count ဆိုင် ရှိပါသည်။😋',
    );
    return '$_temp0';
  }

  @override
  String get exploreNow => 'ယခုကြည့်ရန်';

  @override
  String get orderOnline => 'အွန်လိုင်းမှာရန်';

  @override
  String get offlineBanner =>
      'အင်တာနက် မရှိပါ — သိမ်းထားသော အချက်အလက်ကို ပြသနေသည်';

  @override
  String get refreshFailed => 'အသစ်မရပါ — သိမ်းထားသော အချက်အလက်ကို ပြသနေသည်။';

  @override
  String discountOff(int percent) {
    return '$percent% လျှော့';
  }

  @override
  String get newBadge => 'အသစ်';

  @override
  String get whatsThis => 'ဒါက\nဘာလဲ?';

  @override
  String get addToCart => 'ခြင်းထဲထည့်ရန်';

  @override
  String addedToCart(int quantity, String name) {
    return '$name $quantity ခုကို ခြင်းထဲ ထည့်ပြီးပါပြီ';
  }

  @override
  String get cartFailed => 'ခြင်းထဲ ထည့်၍ မရပါ။ ထပ်မံကြိုးစားပါ။';

  @override
  String get increaseQuantity => 'တစ်ခု တိုးရန်';

  @override
  String get decreaseQuantity => 'တစ်ခု လျှော့ရန်';

  @override
  String quantityLabel(int quantity) {
    return 'အရေအတွက် $quantity';
  }

  @override
  String get productNotFound => 'ဤပစ္စည်း မရနိုင်တော့ပါ။';

  @override
  String get rewardsTitle => 'J\' Donuts ဆုလာဘ်များ';

  @override
  String get rewardsPill => 'ဆုလာဘ်';

  @override
  String get tierHereNow => 'ယခု ရောက်ရှိနေသည်';

  @override
  String tierPointsRemaining(String points, String tier) {
    return '$tier ဖြစ်ရန်\n$points မှတ် လိုသည်';
  }

  @override
  String get tierSoon => 'မကြာမီ ရောက်ပါမည်';

  @override
  String get tierReached => 'ရောက်ပြီး';

  @override
  String get totalPoints => 'စုစုပေါင်းရမှတ်';

  @override
  String get tabEarn => 'များများစား များများရ';

  @override
  String get tabGift => 'လက်ဆောင်';

  @override
  String get earn => 'ရယူရန်';

  @override
  String pointsShort(String points) {
    return '$points မှတ်';
  }

  @override
  String challengeProgress(int progress, int target) {
    return '$progress/$target';
  }

  @override
  String get earnSoon => 'ဆုလာဘ်လဲလှယ်ခြင်းကို မကြာမီ ရနိုင်ပါမည်။';

  @override
  String get challengesEmpty => 'စိန်ခေါ်မှု မရှိသေးပါ။';

  @override
  String get navHome => 'ပင်မ';

  @override
  String get navReward => 'ဆုလာဘ်';

  @override
  String get navMenu => 'မီနူး';

  @override
  String get navWallet => 'ပိုက်ဆံအိတ်';

  @override
  String get navSettings => 'ဆက်တင်';

  @override
  String placeholderBody(String section) {
    return '$section ကို မကြာမီ ရနိုင်ပါမည်။';
  }

  @override
  String get settingsTitle => 'ဆက်တင်များ';

  @override
  String signedInAs(String phone) {
    return '$phone ဖြင့် ဝင်ထားသည်';
  }

  @override
  String get logOut => 'ထွက်ရန်';

  @override
  String get genericError => 'တစ်ခုခု မှားယွင်းသွားပါသည်။ ထပ်မံကြိုးစားပါ။';

  @override
  String get networkError => 'အင်တာနက်ချိတ်ဆက်မှုကို စစ်ဆေးပြီး ထပ်ကြိုးစားပါ။';
}

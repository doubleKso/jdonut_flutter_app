import 'package:intl/intl.dart';

/// 3200 → "3,200 MMK". Western digits and commas in every locale, as the
/// price tags in the shops show them.
String formatMmk(int amount) => '${formatCount(amount)} MMK';

/// 680000 → "680,000".
String formatCount(int value) => NumberFormat.decimalPattern('en').format(value);

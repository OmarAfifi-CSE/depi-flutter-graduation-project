import 'package:intl/intl.dart';

class NumberLocalizer {
  // دالة مساعدة لتحويل locale code للـ locale الكامل
  static String _getFullLocale(String localeCode) {
    if (localeCode == 'ar') return 'ar_EG';
    if (localeCode == 'en') return 'en_US';
    return localeCode;
  }

  // تحويل رقم حسب اللوكيل (بيحول الأرقام حتى لو صغيرة)
  static String formatNumber(dynamic number, String localeCode) {
    if (number == null) return '';

    final num parsedNumber = _parseNumber(number);
    final String fullLocale = _getFullLocale(localeCode);
    return NumberFormat('#', fullLocale).format(parsedNumber);
  }

  // تحويل رقم مع فواصل للأرقام الكبيرة
  static String formatNumberWithSeparator(dynamic number, String localeCode) {
    if (number == null) return '';

    final num parsedNumber = _parseNumber(number);
    final String fullLocale = _getFullLocale(localeCode);
    return NumberFormat.decimalPattern(fullLocale).format(parsedNumber);
  }

  // تحويل لعملة
  static String formatCurrency(
    dynamic number,
    String localeCode, {
    String symbol = '',
    int decimalDigits = 2,
  }) {
    if (number == null) return '';

    final num parsedNumber = _parseNumber(number);
    final String fullLocale = _getFullLocale(localeCode);
    return NumberFormat.currency(
      locale: fullLocale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format(parsedNumber);
  }

  // تحويل لنسبة مئوية
  static String formatPercentage(dynamic number, String localeCode) {
    if (number == null) return '';

    final num parsedNumber = _parseNumber(number);
    final String fullLocale = _getFullLocale(localeCode);
    return NumberFormat.percentPattern(fullLocale).format(parsedNumber);
  }

  // تحويل لرقم مختصر (Compact)
  static String formatCompact(dynamic number, String localeCode) {
    if (number == null) return '';

    final num parsedNumber = _parseNumber(number);
    final String fullLocale = _getFullLocale(localeCode);
    return NumberFormat.compact(locale: fullLocale).format(parsedNumber);
  }

  // تحويل بفورمات مخصص
  static String formatCustom(
    dynamic number,
    String localeCode,
    String pattern,
  ) {
    if (number == null) return '';

    final num parsedNumber = _parseNumber(number);
    final String fullLocale = _getFullLocale(localeCode);
    return NumberFormat(pattern, fullLocale).format(parsedNumber);
  }

  // دالة مساعدة لتحويل أي نوع لـ num
  static num _parseNumber(dynamic value) {
    if (value is num) return value;
    if (value is String) {
      return num.tryParse(value.replaceAll(',', '')) ?? 0;
    }
    return 0;
  }
}

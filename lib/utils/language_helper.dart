import 'package:batrina/styling/app_fonts.dart';

class LanguageHelper {
  static String getNativeName(String code) {
    switch (code.toLowerCase()) {
      case 'en': return 'English';
      case 'ar': return 'العربية';
      case 'fr': return 'Français';
      case 'es': return 'Español';
      case 'de': return 'Deutsch';
      case 'it': return 'Italiano';
      case 'pt': return 'Português';
      case 'ru': return 'Русский';
      case 'tr': return 'Türkçe';
      case 'zh': return '中文';
      case 'ja': return '日本語';
      case 'ko': return '한국어';
      case 'hi': return 'हिन्दी';
      default: return code.toUpperCase();
    }
  }
  static String getEnglishName(String code) {
    switch (code.toLowerCase()) {
      case 'en': return 'English';
      case 'ar': return 'Arabic';
      case 'fr': return 'French';
      case 'es': return 'Spanish';
      case 'de': return 'German';
      case 'it': return 'Italian';
      case 'pt': return 'Portuguese';
      case 'ru': return 'Russian';
      case 'tr': return 'Turkish';
      case 'zh': return 'Chinese';
      case 'ja': return 'Japanese';
      case 'ko': return 'Korean';
      case 'hi': return 'Hindi';
      default: return code;
    }
  }

  static String getFlag(String code) {
    switch (code.toLowerCase()) {
      case 'en': return '🇺🇸'; // or 🇬🇧
      case 'ar': return '🇸🇦'; // or 🇪🇬
      case 'fr': return '🇫🇷';
      case 'es': return '🇪🇸';
      case 'de': return '🇩🇪';
      case 'it': return '🇮🇹';
      case 'pt': return '🇧🇷';
      case 'ru': return '🇷🇺';
      case 'tr': return '🇹🇷';
      case 'zh': return '🇨🇳';
      case 'ja': return '🇯🇵';
      case 'ko': return '🇰🇷';
      case 'hi': return '🇮🇳';
      default: return '🏳️';
    }
  }

  static String? getFontFamily(String code) {
    if (code == 'ar') return AppFonts.arabicFontFamily;
    return AppFonts.englishFontFamily;
  }

}
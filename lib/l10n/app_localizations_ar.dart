// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get test => 'جرب';

  @override
  String get hello => 'أهلاً';

  @override
  String get welcome => 'Welcome';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String userName(Object name) {
    return 'أهلاً $name!';
  }

  @override
  String get discountNewArrivalTitle => 'خصم 20% على المنتجات الجديدة';

  @override
  String get discountNewArrivalDescription => 'اكتشف خصومات مذهلة على أحدث مجموعاتنا. احصل على خصم 20% على جميع المنتجات الجديدة.';

  @override
  String get takeAdvantageShoppingTitle => 'استفد من عروض التسوق';

  @override
  String get takeAdvantageShoppingDescription => 'لا تفوت العروض الحصرية للتسوق. وفر أكثر على العناصر المفضلة لديك مع العروض الخاصة.';

  @override
  String get allTypesOffersTitle => 'جميع أنواع العروض في متناول يدك';

  @override
  String get allTypesOffersDescription => 'تصفح عبر فئات مختلفة واعثر على أفضل الصفقات التي تناسب احتياجاتك وتفضيلاتك.';

  @override
  String get welcomeTitle => 'أهلاً وسهلاً!';

  @override
  String get welcomeDescription => 'من فضلك سجل دخول أو أنشئ حساب جديد لمتابعة استخدام التطبيق';

  @override
  String get emailTitle => 'البريد الإلكتروني';

  @override
  String get passwordTitle => 'كلمة المرور';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get orTitle => 'أو';

  @override
  String get continueWithGoogleTitle => 'المتابعة مع جوجل';

  @override
  String get continueWithGoogleDescription => 'تسجيل دخول سريع وآمن باستخدام حساب جوجل الخاص بك';

  @override
  String get forgotPasswordTitle => 'نسيت كلمة المرور؟';

  @override
  String get dontHaveAccountTitle => 'ليس لديك حساب؟';

  @override
  String get signUpTitle => 'إنشاء حساب';

  @override
  String get emailRequiredTitle => 'البريد الإلكتروني مطلوب';

  @override
  String get emailRequiredDescription => 'من فضلك أدخل عنوان بريدك الإلكتروني للمتابعة';

  @override
  String get emailInvalidTitle => 'بريد إلكتروني غير صحيح';

  @override
  String get emailInvalidDescription => 'من فضلك أدخل عنوان بريد إلكتروني صالح';

  @override
  String get passwordRequiredTitle => 'كلمة المرور مطلوبة';

  @override
  String get passwordRequiredDescription => 'من فضلك أدخل كلمة المرور لتسجيل الدخول';

  @override
  String get passwordTooShortTitle => 'كلمة المرور قصيرة جداً';

  @override
  String get passwordTooShortDescription => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get loginFailedTitle => 'فشل تسجيل الدخول';

  @override
  String get loginFailedDescription => 'بريد إلكتروني أو كلمة مرور خاطئة. من فضلك حاول مرة أخرى';

  @override
  String get loginSuccessTitle => 'تم تسجيل الدخول بنجاح';

  @override
  String get loginSuccessDescription => 'أهلاً بعودتك! جاري التوجه إلى الشاشة الرئيسية';

  @override
  String get signUpDescription => 'أنشئ حساب جديد';

  @override
  String get userNameTitle => 'اسم المستخدم';

  @override
  String get confirmPasswordTitle => 'تأكيد كلمة المرور';

  @override
  String get agreeTermsTitle => 'بإنشاء حساب، فإنك توافق على الشروط والأحكام الخاصة بنا';
}

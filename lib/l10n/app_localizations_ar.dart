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
  String get signInTitle => 'تسجيل الدخول';

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
  String get alreadyAUserTitle => 'هل لديك حساب؟';

  @override
  String get signUpTitle => 'إنشاء حساب';

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
  String get emailEmptyTitle => 'Email Required';

  @override
  String get emailEmptyDescription => 'من فضلك أدخل بريدك الإلكتروني';

  @override
  String get emailInvalidDescription => 'من فضلك أدخل عنوان بريد إلكتروني صالح';

  @override
  String get nameEmptyDescription => 'الاسم مطلوب';

  @override
  String get nameTooShortDescription => 'الاسم قصير جداً';

  @override
  String get passwordEmptyDescription => 'من فضلك أدخل كلمة المرور';

  @override
  String get passwordTooShortDescription => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get passwordWeakDescription => 'كلمة المرور يجب أن تحتوي على حروف كبيرة وصغيرة ورقم';

  @override
  String get googleSignInCanceledDescription => 'تم إلغاء تسجيل الدخول';

  @override
  String get googleNetworkErrorDescription => 'مشكلة في الاتصال';

  @override
  String get googleSignInFailedDescription => 'فشل تسجيل الدخول';

  @override
  String get googleConfigErrorDescription => 'خطأ في إعدادات جوجل';

  @override
  String get googleUnexpectedErrorDescription => 'حدث خطأ غير متوقع';

  @override
  String get emailAlreadyInUseDescription => 'الايميل مسجل مسبقاً';

  @override
  String get invalidEmailDescription => 'عنوان ايميل غير صحيح';

  @override
  String get operationNotAllowedDescription => 'طريقة الدخول معطلة';

  @override
  String get weakPasswordDescription => 'كلمة المرور ضعيفة جداً';

  @override
  String get userDisabledDescription => 'الحساب معطل';

  @override
  String get userNotFoundDescription => 'المستخدم غير موجود';

  @override
  String get wrongPasswordDescription => 'كلمة مرور خاطئة';

  @override
  String get invalidCredentialDescription => 'بيانات دخول غير صحيحة';

  @override
  String get networkRequestFailedDescription => 'فشل الاتصال';

  @override
  String get invalidVerificationCodeDescription => 'رمز التحقق غير صحيح';

  @override
  String get invalidVerificationIdDescription => 'معرف التحقق غير صحيح';

  @override
  String get tooManyRequestsDescription => 'طلبات كثيرة، حاول لاحقاً';

  @override
  String get internalErrorDescription => 'حدث خطأ داخلي';

  @override
  String get accountExistsWithDifferentCredentialDescription => 'الحساب موجود بطريقة دخول مختلفة';

  @override
  String get credentialAlreadyInUseDescription => 'بيانات الدخول مستخدمة في مكان آخر';

  @override
  String get defaultAuthErrorDescription => 'حدث خطأ غير متوقع';

  @override
  String get passwordMustMatch => 'كلمات المرور غير متطابقة';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordLabel => 'أدخل البريد الإلكتروني المرتبط بحسابك وسنرسل لك رسالة تتضمن التعليمات لإعادة تعيين كلمة المرور';

  @override
  String get sendInstruction => 'إرسال التعليمات';

  @override
  String get forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get reset => 'إعادة التعيين';

  @override
  String get expiredActionCodeDescription => 'الرابط منتهي الصلاحية. من فضلك اطلب رابط جديد.';

  @override
  String get invalidActionCodeDescription => 'الرابط غير صالح. من فضلك اطلب رابط جديد.';

  @override
  String get emailVerifiedTitle => 'تم تأكيد البريد الإلكتروني!';

  @override
  String get emailVerifiedSubtitle => 'حسابك الآن نشط وجاهز للاستخدام. شكراً لانضمامك إلينا.';

  @override
  String get continueToSignInButton => 'متابعة لتسجيل الدخول';

  @override
  String get verificationFailedTitle => 'فشل التحقق';

  @override
  String get backToSignInButton => 'العودة لتسجيل الدخول';

  @override
  String get signin_success => 'تم تسجيل الدخول بنجاح';

  @override
  String get check_email_activation => 'من فضلك تفقد بريدك الإلكتروني لتفعيل الحساب.';

  @override
  String get forget_password_sent => 'تم الإرسال بنجاح';

  @override
  String get something_went_wrong => 'حدث خطأ ما.';

  @override
  String get close => 'إغلاق';

  @override
  String get login_success => 'تم تسجيل الدخول بنجاح';

  @override
  String get create_new_password => 'إنشاء كلمة مرور جديدة';

  @override
  String get password_changed_success => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get confirm => 'تأكيد';

  @override
  String get invalid_or_expired_link => 'الرابط غير صالح أو منتهي الصلاحية أو تم استخدامه مسبقًا. من فضلك اطلب رابطًا جديدًا.';

  @override
  String get unexpected_error => 'حدث خطأ غير متوقع. من فضلك حاول مرة أخرى.';

  @override
  String get error_happened => 'حدث خطأ';

  @override
  String get home => 'الرئيسية';

  @override
  String get cart => 'السلة';

  @override
  String get favorites => 'المفضلة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get search => 'بحث';

  @override
  String get clothes => 'ملابس';

  @override
  String get categories => 'فئات';

  @override
  String get top_dresses => 'أفضل الفساتين';

  @override
  String get personalDetails => 'التفاصيل الشخصية';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get myFavourites => 'مفضلاتي';

  @override
  String get shippingAddress => 'عنوان الشحن';

  @override
  String get myCard => 'بطاقاتي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get addtocard => 'إضافة إلى السلة';

  @override
  String get processtocheckout => 'المتابعة للدفع';

  @override
  String get mycart => 'سلة التسوق';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get shipping => 'الشحن';

  @override
  String get total => 'المجموع الكلي';

  @override
  String get items => 'عناصر';

  @override
  String get review => 'مراجعة';

  @override
  String get availableinstock => 'متوفر في المخزون';

  @override
  String get description => 'الوصف';
}

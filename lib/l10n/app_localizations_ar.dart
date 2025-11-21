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
  String get pleaseVerifyYourEmail => 'من فضلك قم بتأكيد بريدك الإلكتروني أولاً';

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
  String get home => 'الرئيسية';

  @override
  String get categories => 'الفئات';

  @override
  String get cart => 'السلة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get search => 'بحث';

  @override
  String get emptyCategories => 'لم يتم العثور على فئات.';

  @override
  String get couldNotLoadCategories => 'تعذر تحميل الفئات.';

  @override
  String get defaultError => 'حدث خطأ غير متوقع.';

  @override
  String get personalDetails => 'التفاصيل الشخصية';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get wishlist => 'قائمة الرغبات';

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
  String get lightMode => 'الوضع الفاتح';

  @override
  String get helpCenter => 'مركز المساعدة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get emptyCartTitle => 'عربة التسوق فارغة';

  @override
  String get emptyCartSubtitle => 'يبدو أنك لم تقم بإضافة أي شيء إلى عربة التسوق بعد. هيا نجد شيئًا ستحبه!';

  @override
  String get continueShopping => 'متابعة التسوق';

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

  @override
  String get reviewsHeader => 'مراجعات العملاء';

  @override
  String get reviewsLoadingError => 'حدث خطأ ما. يرجى المحاولة مرة أخرى.';

  @override
  String get noReviewsYet => 'لا توجد مراجعات بعد. كن أول من يشارك رأيه!';

  @override
  String get addReviewTitle => 'اكتب مراجعة';

  @override
  String get experienceHint => 'كيف كانت تجربتك مع هذا المنتج؟';

  @override
  String get postButton => 'نشر';

  @override
  String get errorHappened => 'حدث خطأ!';

  @override
  String get reviews => 'المراجعات';

  @override
  String get size => 'المقاس';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get removeFromCart => 'إزالة من السلة';

  @override
  String get notAvailable => 'غير متوفر';

  @override
  String get noAvailableSizes => 'لا توجد مقاسات متوفرة';

  @override
  String get noAvailableColors => 'لا توجد ألوان متوفرة';

  @override
  String get productAddedToCart => 'تمت إضافة المنتج إلى السلة';

  @override
  String get productRemovedFromCart => 'تمت إزالة المنتج من السلة';

  @override
  String get shippingAddresses => 'عناوين الشحن';

  @override
  String get mainAddress => 'العنوان الرئيسي';

  @override
  String get noMainAddress => 'لا يوجد عنوان رئيسي';

  @override
  String get dragAnAddress => 'اسحب عنوانًا للأعلى لتعيينه كرئيسي.';

  @override
  String get otherAddresses => 'العناوين الأخرى';

  @override
  String get setMain => 'تعيين كعنوان رئيسي';

  @override
  String get delete => 'حذف';

  @override
  String get addNewAddress => 'إضافة عنوان جديد';

  @override
  String get tapToAdd => 'اضغط للإضافة';

  @override
  String get swipeToManage => 'اسحب لإدارة العناوين';

  @override
  String get street => 'الشارع';

  @override
  String get city => 'المدينة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get country => 'الدولة';

  @override
  String get addAddress => 'إضافة العنوان';

  @override
  String get addressAddedSuccessfully => 'تمت إضافة العنوان بنجاح';

  @override
  String get streetEmptyDescription => 'حقل الشارع مطلوب.';

  @override
  String get streetTooShortDescription => 'الشارع قصير جدًا، يجب أن لا يقل عن 5 أحرف.';

  @override
  String get cityEmptyDescription => 'حقل المدينة مطلوب.';

  @override
  String get cityTooShortDescription => 'المدينة قصيرة جدًا، يجب أن لا تقل عن حرفين.';

  @override
  String get countryEmptyDescription => 'حقل الدولة مطلوب.';

  @override
  String get countryTooShortDescription => 'الدولة قصيرة جدًا، يجب أن لا تقل عن حرفين.';

  @override
  String get phoneEmptyDescription => 'حقل رقم الهاتف مطلوب.';

  @override
  String get phoneInvalidDescription => 'الرجاء إدخال رقم هاتف صالح.';

  @override
  String get phoneLengthDescription => 'يجب أن يتكون رقم الهاتف من 8 إلى 15 رقمًا.';

  @override
  String get uploadImage => 'تحميل صورة';

  @override
  String get name => 'الاسم';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get priceRange => 'نطاق الأسعار';

  @override
  String get sortBy => 'الترتيب حسب';

  @override
  String get ratting => 'التقييم';

  @override
  String get applyNow => 'بحث';

  @override
  String get noProductsFound => 'لا يوجد منتجات';

  @override
  String get filteredProducts => 'المنتجات المفلترة';

  @override
  String get checkout => 'الدفع';

  @override
  String get deliveryAddress => 'عنوان التوصيل';

  @override
  String get products => 'المنتجات';

  @override
  String get placeOrder => 'إتمام الطلب';

  @override
  String get selectDeliveryAddress => 'اختر عنوان التوصيل';

  @override
  String get noAddressFound => 'لم يتم العثور على عنوان';

  @override
  String get pleaseAddAddress => 'يرجى إضافة عنوان للمتابعة.';

  @override
  String get orderPlacedSuccessfully => 'تم إرسال الطلب بنجاح!';

  @override
  String get orderSuccessSubtitle => 'سيتم توصيل طلبك قريباً.\nشكراً لتسوقك معنا!';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get trackYourOrder => 'تتبع طلبك';

  @override
  String get orderFailedError => 'حدث خطأ ما، يرجى المحاولة مرة أخرى.';

  @override
  String get nothingFound => 'لم يتم العثور على شيء';

  @override
  String emptyCategoryDescription(Object categoryName) {
    return 'لم نتمكن من العثور على أي منتجات في فئة \'$categoryName\' في الوقت الحالي. حاول العودة لاحقًا أو استكشاف فئات أخرى.';
  }

  @override
  String get newChatRequest => 'طلب محادثة جديد';

  @override
  String get accept => 'قبول';

  @override
  String get online => 'متصل';

  @override
  String get offline => 'غير متصل';

  @override
  String get typing => 'يكتب...';

  @override
  String get noConnection => 'لا يوجد اتصال';

  @override
  String get sayHi => 'قل مرحباً!';

  @override
  String get typeMessage => 'اكتب رسالة...';

  @override
  String get searchByEmail => 'ابحث بالبريد الإلكتروني لبدء محادثة جديدة';

  @override
  String get chats => 'المحادثات';

  @override
  String get newUsers => 'مستخدمون جدد';

  @override
  String get error => 'خطأ';

  @override
  String get noNewUsersFound => 'لم يتم العثور على مستخدمين جدد';

  @override
  String get startNewChat => 'ابدأ محادثة جديدة';

  @override
  String get messages => 'الرسائل';

  @override
  String get chatsTab => 'المحادثات';

  @override
  String get requestsTab => 'الطلبات';

  @override
  String get justNow => 'الآن';

  @override
  String secondsAgo(Object seconds) {
    return 'منذ $secondsث';
  }

  @override
  String minutesAgo(Object minutes) {
    return 'منذ $minutesد';
  }

  @override
  String hoursAgo(Object hours) {
    return 'منذ $hoursس';
  }

  @override
  String get yesterday => 'أمس';

  @override
  String daysAgo(Object days) {
    return 'منذ $daysي';
  }

  @override
  String get noChatsYet => 'لا توجد محادثات بعد';

  @override
  String get noRequestsYet => 'لا توجد طلبات بعد';

  @override
  String get sendTo => 'أرسل إلى...';

  @override
  String get shareToOtherApps => 'شارك مع تطبيقات أخرى';

  @override
  String get moveToRequests => 'نقل إلى الطلبات';

  @override
  String get areYouSureToLogout => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String failedToLogout(Object errorMessage) {
    return 'فشل تسجيل الخروج: \'$errorMessage\'';
  }
}

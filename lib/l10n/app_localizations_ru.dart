// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get test => 'Тест';

  @override
  String get hello => 'Привет';

  @override
  String get welcome => 'Добро пожаловать';

  @override
  String userName(Object name) {
    return 'Имя';
  }

  @override
  String get discountNewArrivalTitle => 'Скидка 20% на новые поступления';

  @override
  String get discountNewArrivalDescription => 'Откройте для себя потрясающие скидки на нашу последнюю коллекцию. Получите скидку 20% на все новые товары.';

  @override
  String get takeAdvantageShoppingTitle => 'Воспользуйтесь выгодным предложением';

  @override
  String get takeAdvantageShoppingDescription => 'Не пропустите эксклюзивные предложения. Экономьте больше на любимых товарах благодаря специальным акциям.';

  @override
  String get allTypesOffersTitle => 'Все виды предложений у вас под рукой';

  @override
  String get allTypesOffersDescription => 'Просматривайте различные категории и находите лучшие предложения, соответствующие вашим потребностям и предпочтениям.';

  @override
  String get welcomeTitle => 'Добро пожаловать!';

  @override
  String get welcomeDescription => 'Пожалуйста, войдите или зарегистрируйтесь, чтобы продолжить';

  @override
  String get emailTitle => 'Email';

  @override
  String get passwordTitle => 'Пароль';

  @override
  String get loginTitle => 'Вход';

  @override
  String get signInTitle => 'Войти';

  @override
  String get orTitle => 'или';

  @override
  String get continueWithGoogleTitle => 'Продолжить с Google';

  @override
  String get continueWithGoogleDescription => 'Быстрый и безопасный вход через аккаунт Google';

  @override
  String get forgotPasswordTitle => 'Забыли пароль?';

  @override
  String get dontHaveAccountTitle => 'Нет аккаунта?';

  @override
  String get alreadyAUserTitle => 'Уже зарегистрированы?';

  @override
  String get signUpTitle => 'Регистрация';

  @override
  String get loginFailedTitle => 'Ошибка входа';

  @override
  String get loginFailedDescription => 'Неверный email или пароль. Пожалуйста, попробуйте снова';

  @override
  String get loginSuccessTitle => 'Вход выполнен';

  @override
  String get loginSuccessDescription => 'С возвращением! Перенаправление на главный экран';

  @override
  String get signUpDescription => 'Создать новый аккаунт';

  @override
  String get userNameTitle => 'Имя пользователя';

  @override
  String get confirmPasswordTitle => 'Подтвердите пароль';

  @override
  String get emailEmptyTitle => 'Email обязателен';

  @override
  String get emailEmptyDescription => 'Пожалуйста, введите ваш email';

  @override
  String get emailInvalidDescription => 'Пожалуйста, введите корректный адрес email';

  @override
  String get nameEmptyDescription => 'Имя обязательно';

  @override
  String get nameTooShortDescription => 'Имя слишком короткое';

  @override
  String get passwordEmptyDescription => 'Пожалуйста, введите пароль';

  @override
  String get passwordTooShortDescription => 'Пароль должен содержать не менее 6 символов';

  @override
  String get passwordWeakDescription => 'Пароль должен содержать заглавные и строчные буквы, а также цифру';

  @override
  String get pleaseVerifyYourEmail => 'Пожалуйста, сначала подтвердите ваш email';

  @override
  String get googleSignInCanceledDescription => 'Вход отменен';

  @override
  String get googleNetworkErrorDescription => 'Проблема с сетевым подключением';

  @override
  String get googleSignInFailedDescription => 'Ошибка входа';

  @override
  String get googleConfigErrorDescription => 'Ошибка конфигурации Google Sign-In';

  @override
  String get googleUnexpectedErrorDescription => 'Произошла непредвиденная ошибка';

  @override
  String get emailAlreadyInUseDescription => 'Email уже зарегистрирован';

  @override
  String get invalidEmailDescription => 'Неверный адрес email';

  @override
  String get operationNotAllowedDescription => 'Метод входа отключен';

  @override
  String get weakPasswordDescription => 'Пароль слишком слабый';

  @override
  String get userDisabledDescription => 'Аккаунт отключен';

  @override
  String get userNotFoundDescription => 'Пользователь не найден';

  @override
  String get wrongPasswordDescription => 'Неверный пароль';

  @override
  String get invalidCredentialDescription => 'Неверные учетные данные';

  @override
  String get networkRequestFailedDescription => 'Ошибка подключения';

  @override
  String get invalidVerificationCodeDescription => 'Неверный код подтверждения';

  @override
  String get invalidVerificationIdDescription => 'Неверный ID подтверждения';

  @override
  String get tooManyRequestsDescription => 'Слишком много запросов, попробуйте позже';

  @override
  String get internalErrorDescription => 'Произошла внутренняя ошибка';

  @override
  String get accountExistsWithDifferentCredentialDescription => 'Аккаунт уже существует с другими учетными данными';

  @override
  String get credentialAlreadyInUseDescription => 'Учетные данные используются в другом месте';

  @override
  String get defaultAuthErrorDescription => 'Произошла непредвиденная ошибка';

  @override
  String get passwordMustMatch => 'Пароли не совпадают';

  @override
  String get resetPassword => 'Сброс пароля';

  @override
  String get resetPasswordLabel => 'Введите email, связанный с вашим аккаунтом, и мы отправим письмо с инструкциями по сбросу пароля';

  @override
  String get sendInstruction => 'Отправить инструкцию';

  @override
  String get forgotPassword => 'Забыли пароль?';

  @override
  String get reset => 'Сбросить';

  @override
  String get expiredActionCodeDescription => 'Срок действия ссылки истек. Пожалуйста, запросите новую.';

  @override
  String get invalidActionCodeDescription => 'Ссылка недействительна. Пожалуйста, запросите новую.';

  @override
  String get emailVerifiedTitle => 'Email подтвержден!';

  @override
  String get emailVerifiedSubtitle => 'Ваш аккаунт активен и готов к использованию. Спасибо, что присоединились к нам.';

  @override
  String get continueToSignInButton => 'Перейти ко входу';

  @override
  String get verificationFailedTitle => 'Ошибка подтверждения';

  @override
  String get backToSignInButton => 'Вернуться ко входу';

  @override
  String get signin_success => 'Вход выполнен успешно';

  @override
  String get check_email_activation => 'Пожалуйста, проверьте почту для активации аккаунта.';

  @override
  String get forget_password_sent => 'Отправлено успешно';

  @override
  String get something_went_wrong => 'Что-то пошло не так.';

  @override
  String get close => 'Закрыть';

  @override
  String get login_success => 'Вход выполнен успешно';

  @override
  String get create_new_password => 'Создать новый пароль';

  @override
  String get password_changed_success => 'Пароль успешно изменен';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get invalid_or_expired_link => 'Ссылка недействительна, просрочена или уже использована. Пожалуйста, запросите новую.';

  @override
  String get unexpected_error => 'Произошла непредвиденная ошибка. Пожалуйста, попробуйте снова.';

  @override
  String get home => 'Главная';

  @override
  String get categories => 'Категории';

  @override
  String get cart => 'Корзина';

  @override
  String get notifications => 'Уведомления';

  @override
  String get profile => 'Профиль';

  @override
  String get search => 'Поиск';

  @override
  String get emptyCategories => 'Категории не найдены';

  @override
  String get couldNotLoadCategories => 'Не удалось загрузить категории';

  @override
  String get defaultError => 'Произошла непредвиденная ошибка.';

  @override
  String get adminDashboard => 'Панель администратора';

  @override
  String get activeEditingMode => 'Режим редактирования активен';

  @override
  String get viewAsCustomer => 'Просмотр как покупатель';

  @override
  String get personalDetails => 'Личные данные';

  @override
  String get myOrders => 'Мои заказы';

  @override
  String get wishlist => 'Список желаний';

  @override
  String get shippingAddress => 'Адрес доставки';

  @override
  String get myCard => 'Мои карты';

  @override
  String get settings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get darkMode => 'Темная тема';

  @override
  String get lightMode => 'Светлая тема';

  @override
  String get helpCenter => 'Центр помощи';

  @override
  String get english => 'Английский';

  @override
  String get emptyCartTitle => 'Ваша корзина пуста';

  @override
  String get emptyCartSubtitle => 'Похоже, вы еще ничего не добавили в корзину. Давайте найдем то, что вам понравится!';

  @override
  String get continueShopping => 'Продолжить покупки';

  @override
  String get addtocard => 'Добавить в корзину';

  @override
  String get processtocheckout => 'Оформить заказ';

  @override
  String get mycart => 'Моя корзина';

  @override
  String get subtotal => 'Подытог';

  @override
  String get shipping => 'Доставка';

  @override
  String get total => 'Итого';

  @override
  String get items => 'товаров';

  @override
  String get review => 'Отзыв';

  @override
  String get availableinstock => 'В наличии';

  @override
  String get description => 'Описание';

  @override
  String get reviewsHeader => 'Отзывы клиентов';

  @override
  String get reviewsLoadingError => 'Что-то пошло не так. Пожалуйста, попробуйте снова.';

  @override
  String get noReviewsYet => 'Отзывов пока нет. Будьте первым, кто поделится мнением!';

  @override
  String get addReviewTitle => 'Написать отзыв';

  @override
  String get experienceHint => 'Каковы ваши впечатления от этого продукта?';

  @override
  String get postButton => 'Опубликовать';

  @override
  String get errorHappened => 'Произошла ошибка!';

  @override
  String get reviews => 'Отзывы';

  @override
  String get size => 'Размер';

  @override
  String get addToCart => 'В корзину';

  @override
  String get removeFromCart => 'Убрать из корзины';

  @override
  String get notAvailable => 'Нет в наличии';

  @override
  String get noAvailableSizes => 'Нет доступных размеров';

  @override
  String get noAvailableColors => 'Нет доступных цветов';

  @override
  String get productAddedToCart => 'Товар добавлен в корзину';

  @override
  String get productRemovedFromCart => 'Товар удален из корзины';

  @override
  String get shippingAddresses => 'Адреса доставки';

  @override
  String get mainAddress => 'Основной адрес';

  @override
  String get noMainAddress => 'Нет основного адреса';

  @override
  String get dragAnAddress => 'Перетащите адрес вверх, чтобы сделать его основным.';

  @override
  String get otherAddresses => 'Другие адреса';

  @override
  String get setMain => 'Сделать основным';

  @override
  String get delete => 'Удалить';

  @override
  String get addNewAddress => 'Добавить новый адрес';

  @override
  String get tapToAdd => 'Нажмите, чтобы добавить';

  @override
  String get swipeToManage => 'Свайп для управления';

  @override
  String get street => 'Улица';

  @override
  String get city => 'Город';

  @override
  String get phoneNumber => 'Номер телефона';

  @override
  String get country => 'Страна';

  @override
  String get addAddress => 'Добавить адрес';

  @override
  String get addressAddedSuccessfully => 'Адрес успешно добавлен';

  @override
  String get streetEmptyDescription => 'Улица не может быть пустой.';

  @override
  String get streetTooShortDescription => 'Название улицы слишком короткое, минимум 5 символов.';

  @override
  String get cityEmptyDescription => 'Город не может быть пустым.';

  @override
  String get cityTooShortDescription => 'Название города слишком короткое, минимум 2 символа.';

  @override
  String get countryEmptyDescription => 'Страна не может быть пустой.';

  @override
  String get countryTooShortDescription => 'Название страны слишком короткое, минимум 2 символа.';

  @override
  String get phoneEmptyDescription => 'Номер телефона не может быть пустым.';

  @override
  String get phoneInvalidDescription => 'Пожалуйста, введите корректный номер телефона.';

  @override
  String get phoneLengthDescription => 'Номер телефона должен содержать от 8 до 15 цифр.';

  @override
  String get uploadImage => 'Загрузить изображение';

  @override
  String get name => 'Имя';

  @override
  String get email => 'Email';

  @override
  String get logOut => 'Выйти';

  @override
  String get priceRange => 'Диапазон цены';

  @override
  String get sortBy => 'Сортировать по';

  @override
  String get ratting => 'Рейтинг';

  @override
  String get applyNow => 'Применить';

  @override
  String get noProductsFound => 'Товары не найдены';

  @override
  String get filteredProducts => 'Отфильтрованные товары';

  @override
  String get checkout => 'Оформление';

  @override
  String get deliveryAddress => 'Адрес доставки';

  @override
  String get products => 'Товары';

  @override
  String get placeOrder => 'Разместить заказ';

  @override
  String get selectDeliveryAddress => 'Выбрать адрес доставки';

  @override
  String get noAddressFound => 'Адрес не найден';

  @override
  String get pleaseAddAddress => 'Пожалуйста, добавьте адрес для продолжения.';

  @override
  String get orderPlacedSuccessfully => 'Заказ оформлен!';

  @override
  String get orderSuccessSubtitle => 'Ваш заказ будет доставлен в ближайшее время.\nСпасибо за покупку!';

  @override
  String get backToHome => 'На главную';

  @override
  String get trackYourOrder => 'Отследить заказ';

  @override
  String get orderFailedError => 'Что-то пошло не так, пожалуйста, попробуйте снова.';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String emptyCategoryDescription(Object categoryName) {
    return 'Мы не нашли товаров в категории \'$categoryName\' на данный момент. Попробуйте зайти позже или посмотрите другие категории.';
  }

  @override
  String get addCategory => 'Добавить категорию';

  @override
  String get editCategory => 'Редактировать категорию';

  @override
  String get categoryName => 'Название категории';

  @override
  String get enterCategoryName => 'Введите название категории';

  @override
  String get isActive => 'Активна';

  @override
  String get savedSuccessfully => 'Успешно сохранено';

  @override
  String get fillAllFields => 'Пожалуйста, заполните все обязательные поля';

  @override
  String get reorderCategories => 'Изменить порядок категорий';

  @override
  String get saveChanges => 'Сохранить изменения';

  @override
  String get areYouSureToSaveCategoryOrder => 'Вы уверены, что хотите сохранить новый порядок категорий?';

  @override
  String get categoryOrderUpdatedSuccessfully => 'Порядок категорий успешно обновлен';

  @override
  String get deleteCategory => 'Удалить категорию';

  @override
  String get areYouSureToDeleteCategory => 'Вы уверены, что хотите удалить эту категорию? Это действие нельзя отменить.';

  @override
  String get categoryDeletedSuccessfully => 'Категория успешно удалена';

  @override
  String get categorySavedSuccessfully => 'Категория успешно сохранена';

  @override
  String get newChatRequest => 'Новый запрос чата';

  @override
  String get accept => 'Принять';

  @override
  String get online => 'В сети';

  @override
  String get offline => 'Не в сети';

  @override
  String get typing => 'печатает...';

  @override
  String get noConnection => 'Нет соединения';

  @override
  String get sayHi => 'Скажите привет!';

  @override
  String get typeMessage => 'Введите сообщение...';

  @override
  String get searchByEmail => 'Ищите по email, чтобы начать чат';

  @override
  String get chats => 'Чаты';

  @override
  String get newUsers => 'Новые пользователи';

  @override
  String get error => 'Ошибка';

  @override
  String get noNewUsersFound => 'Новые пользователи не найдены';

  @override
  String get startNewChat => 'Начать новый чат';

  @override
  String get messages => 'Сообщения';

  @override
  String get chatsTab => 'Чаты';

  @override
  String get requestsTab => 'Запросы';

  @override
  String get justNow => 'Только что';

  @override
  String secondsAgo(Object seconds) {
    return '$seconds сек. назад';
  }

  @override
  String minutesAgo(Object minutes) {
    return '$minutes мин. назад';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours ч. назад';
  }

  @override
  String get yesterday => 'Вчера';

  @override
  String daysAgo(Object days) {
    return '$days д. назад';
  }

  @override
  String get noChatsYet => 'Чатов пока нет';

  @override
  String get noRequestsYet => 'Запросов пока нет';

  @override
  String get youRestricted => 'Вы ограничили этого пользователя';

  @override
  String get youRestrictedBy => 'Вы ограничены этим пользователем';

  @override
  String get moveToChats => 'Разблокировать и вернуть в чаты';

  @override
  String get restrictedTab => 'Заблокированные';

  @override
  String get noRestrictedYet => 'Нет заблокированных пользователей';

  @override
  String get sendTo => 'Отправить...';

  @override
  String get shareToOtherApps => 'Поделиться в других приложениях';

  @override
  String get moveToRequests => 'Переместить в запросы';

  @override
  String get moveToRestricted => 'Переместить в ограниченные';

  @override
  String get areYouSureToLogout => 'Вы уверены, что хотите выйти?';

  @override
  String get cancel => 'Отмена';

  @override
  String failedToLogout(Object errorMessage) {
    return 'Не удалось выйти: \'$errorMessage\'';
  }

  @override
  String get pleaseEnterUrl => 'Пожалуйста, введите URL';

  @override
  String get invalidUrl => 'Неверный URL';

  @override
  String get pasteImagesUrl => 'Вставить URL изображений';

  @override
  String get save => 'Сохранить';

  @override
  String get select => 'Выбрать';

  @override
  String get addSize => 'Добавить размер';

  @override
  String get addNumber => 'Добавить номер';

  @override
  String get addStock => 'Добавить запас';

  @override
  String get selectSize => 'Выбрать размер';

  @override
  String get selectNumber => 'Выбрать номер';

  @override
  String get quantity => 'Количество';

  @override
  String get enterQuantity => 'Введите количество';

  @override
  String get choose => 'Выбрать...';

  @override
  String get add => 'Добавить';

  @override
  String get edit => 'Редактировать';

  @override
  String get addImageFrom => 'Добавить изображение из';

  @override
  String get gallery => 'Галереи';

  @override
  String get urlLink => 'URL ссылки';

  @override
  String get productThumbnail => 'Миниатюра товара';

  @override
  String get mainImage => 'Главное изображение (Обложка)';

  @override
  String get editProduct => 'Редактировать товар';

  @override
  String get productColors => 'Цвета товара';

  @override
  String get addNewColor => 'Добавить новый цвет';

  @override
  String get enterProductName => 'Название товара';

  @override
  String get productNameRequired => 'Название товара обязательно';

  @override
  String get productNameMinLength => 'Название товара должно содержать минимум 3 символа';

  @override
  String get enterSubTitle => 'Подзаголовок товара';

  @override
  String get subTitle => 'Подзаголовок';

  @override
  String get subtitleRequired => 'Подзаголовок обязателен';

  @override
  String get subtitleMinLength => 'Подзаголовок должен содержать минимум 2 символа';

  @override
  String get enterDescription => 'Описание товара';

  @override
  String get descriptionRequired => 'Описание обязательно';

  @override
  String get descriptionMinLength => 'Описание должно содержать минимум 10 символов';

  @override
  String get enterPrice => 'Введите цену';

  @override
  String get price => 'Цена';

  @override
  String get priceRequired => 'Цена обязательна';

  @override
  String get pleaseEnterValidPrice => 'Пожалуйста, введите корректную цену';

  @override
  String get priceGreaterThanZero => 'Цена должна быть больше 0';

  @override
  String get errorFetchingCategories => 'Ошибка при загрузке категорий';

  @override
  String get sizesAndStock => 'Размеры и Запас';

  @override
  String get noSizesAdded => 'Размеры еще не добавлены.';

  @override
  String get pleaseAddColorsFirst => 'Пожалуйста, сначала добавьте цвета для управления вариантами.';

  @override
  String get manageStockAndSizes => 'Управление запасами и размерами';

  @override
  String get preview => 'Предпросмотр';

  @override
  String get productAddedSuccessfully => 'Товар успешно добавлен';

  @override
  String get productEditedSuccessfully => 'Товар успешно отредактирован';

  @override
  String get addProduct => 'Добавить товар';

  @override
  String get stock => 'Запас';

  @override
  String get number => 'Номер';

  @override
  String get category => 'Категория';

  @override
  String get areYouSureToDeleteProduct => 'Вы уверены, что хотите удалить этот товар? Это действие нельзя отменить.';

  @override
  String get productDeletedSuccessfully => 'Товар успешно удален';

  @override
  String get deleteProduct => 'Удалить товар';

  @override
  String get yourWishlistIsEmpty => 'Ваш список желаний пуст';

  @override
  String get wishlistEmptyMessage => 'Похоже, вы еще ничего не добавили в список желаний. Давайте найдем то, что вам понравится!';

  @override
  String get noItemsMatchSearch => 'Нет товаров, соответствующих вашему поиску';

  @override
  String get itemAddedToCart => 'Товар добавлен в корзину!';

  @override
  String get itemRemovedFromCart => 'Товар удален из корзины';

  @override
  String get productNotFound => 'Товар не найден';

  @override
  String get productNotFoundMessage => 'Извините, этот товар больше недоступен. Давайте найдем что-нибудь другое, что вам понравится!';

  @override
  String get orderSummary => 'Сводка заказа';

  @override
  String get discount => 'Скидка';

  @override
  String get promoCode => 'Промокод';

  @override
  String get apply => 'Применить';
}

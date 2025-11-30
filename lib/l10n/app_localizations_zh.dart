// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get test => '测试';

  @override
  String get hello => '你好';

  @override
  String get welcome => '欢迎';

  @override
  String userName(Object name) {
    return '姓名';
  }

  @override
  String get discountNewArrivalTitle => '新品 20% 折扣';

  @override
  String get discountNewArrivalDescription => '探索我们最新系列的惊人折扣。所有新品均可享受 20% 的优惠。';

  @override
  String get takeAdvantageShoppingTitle => '把握购物优惠';

  @override
  String get takeAdvantageShoppingDescription => '不要错过独家购物优惠。通过特别优惠在您喜爱的商品上节省更多。';

  @override
  String get allTypesOffersTitle => '各类优惠触手可及';

  @override
  String get allTypesOffersDescription => '浏览各种分类，找到最符合您需求和偏好的超值优惠。';

  @override
  String get welcomeTitle => '欢迎！';

  @override
  String get welcomeDescription => '请登录或注册以继续使用我们的应用';

  @override
  String get emailTitle => '邮箱';

  @override
  String get passwordTitle => '密码';

  @override
  String get loginTitle => '登录';

  @override
  String get signInTitle => '登录';

  @override
  String get orTitle => '或';

  @override
  String get continueWithGoogleTitle => '通过 Google 继续';

  @override
  String get continueWithGoogleDescription => '使用您的 Google 账号快速安全登录';

  @override
  String get forgotPasswordTitle => '忘记密码？';

  @override
  String get dontHaveAccountTitle => '还没有账号？';

  @override
  String get alreadyAUserTitle => '已经是用户？';

  @override
  String get signUpTitle => '注册';

  @override
  String get loginFailedTitle => '登录失败';

  @override
  String get loginFailedDescription => '邮箱或密码无效。请重试';

  @override
  String get loginSuccessTitle => '登录成功';

  @override
  String get loginSuccessDescription => '欢迎回来！正在跳转至主屏幕';

  @override
  String get signUpDescription => '创建一个新账号';

  @override
  String get userNameTitle => '用户名';

  @override
  String get confirmPasswordTitle => '确认密码';

  @override
  String get emailEmptyTitle => '需要邮箱';

  @override
  String get emailEmptyDescription => '请输入您的邮箱';

  @override
  String get emailInvalidDescription => '请输入有效的邮箱地址';

  @override
  String get nameEmptyDescription => '姓名为必填项';

  @override
  String get nameTooShortDescription => '姓名太短';

  @override
  String get passwordEmptyDescription => '请输入您的密码';

  @override
  String get passwordTooShortDescription => '密码长度至少为 6 个字符';

  @override
  String get passwordWeakDescription => '密码必须包含大写字母、小写字母和数字';

  @override
  String get pleaseVerifyYourEmail => '请先验证您的邮箱';

  @override
  String get googleSignInCanceledDescription => '登录已取消';

  @override
  String get googleNetworkErrorDescription => '网络连接问题';

  @override
  String get googleSignInFailedDescription => '登录失败';

  @override
  String get googleConfigErrorDescription => 'Google 登录配置错误';

  @override
  String get googleUnexpectedErrorDescription => '发生意外错误';

  @override
  String get emailAlreadyInUseDescription => '邮箱已被注册';

  @override
  String get invalidEmailDescription => '无效的邮箱地址';

  @override
  String get operationNotAllowedDescription => '登录方式已禁用';

  @override
  String get weakPasswordDescription => '密码太弱';

  @override
  String get userDisabledDescription => '账号已禁用';

  @override
  String get userNotFoundDescription => '用户未找到';

  @override
  String get wrongPasswordDescription => '密码错误';

  @override
  String get invalidCredentialDescription => '无效的凭据';

  @override
  String get networkRequestFailedDescription => '连接失败';

  @override
  String get invalidVerificationCodeDescription => '无效的验证码';

  @override
  String get invalidVerificationIdDescription => '无效的验证 ID';

  @override
  String get tooManyRequestsDescription => '请求过多，请稍后再试';

  @override
  String get internalErrorDescription => '发生内部错误';

  @override
  String get accountExistsWithDifferentCredentialDescription => '账号已存在但使用了不同的登录方式';

  @override
  String get credentialAlreadyInUseDescription => '凭据已在别处使用';

  @override
  String get defaultAuthErrorDescription => '发生意外错误';

  @override
  String get passwordMustMatch => '密码不匹配';

  @override
  String get resetPassword => '重置密码';

  @override
  String get resetPasswordLabel => '输入与您的账号关联的邮箱，我们将发送一封包含重置密码说明的邮件';

  @override
  String get sendInstruction => '发送说明';

  @override
  String get forgotPassword => '忘记密码？';

  @override
  String get reset => '重置';

  @override
  String get expiredActionCodeDescription => '链接已过期。请重新请求。';

  @override
  String get invalidActionCodeDescription => '链接无效。请重新请求。';

  @override
  String get emailVerifiedTitle => '邮箱已验证！';

  @override
  String get emailVerifiedSubtitle => '您的账号现已激活并可以使用。感谢您的加入。';

  @override
  String get continueToSignInButton => '继续登录';

  @override
  String get verificationFailedTitle => '验证失败';

  @override
  String get backToSignInButton => '返回登录';

  @override
  String get signin_success => '登录成功';

  @override
  String get check_email_activation => '请检查您的邮箱以激活账号。';

  @override
  String get forget_password_sent => '发送成功';

  @override
  String get something_went_wrong => '出错了。';

  @override
  String get close => '关闭';

  @override
  String get login_success => '登录成功';

  @override
  String get create_new_password => '创建新密码';

  @override
  String get password_changed_success => '密码修改成功';

  @override
  String get confirm => '确认';

  @override
  String get invalid_or_expired_link => '链接无效、已过期或已被使用。请重新请求。';

  @override
  String get unexpected_error => '发生意外错误。请重试。';

  @override
  String get home => '首页';

  @override
  String get categories => '分类';

  @override
  String get cart => '购物车';

  @override
  String get notifications => '通知';

  @override
  String get profile => '我的';

  @override
  String get search => '搜索';

  @override
  String get emptyCategories => '未找到分类';

  @override
  String get couldNotLoadCategories => '无法加载分类';

  @override
  String get defaultError => '发生意外错误。';

  @override
  String get adminDashboard => '管理员仪表盘';

  @override
  String get activeEditingMode => '编辑模式已激活';

  @override
  String get viewAsCustomer => '以顾客视角查看';

  @override
  String get personalDetails => '个人详情';

  @override
  String get myOrders => '我的订单';

  @override
  String get wishlist => '心愿单';

  @override
  String get shippingAddress => '收货地址';

  @override
  String get myCard => '我的银行卡';

  @override
  String get settings => '设置';

  @override
  String get language => '语言';

  @override
  String get darkMode => '深色模式';

  @override
  String get lightMode => '浅色模式';

  @override
  String get helpCenter => '帮助中心';

  @override
  String get english => '英语';

  @override
  String get emptyCartTitle => '您的购物车是空的';

  @override
  String get emptyCartSubtitle => '看来您还没有添加任何商品到购物车。去挑点您喜欢的东西吧！';

  @override
  String get continueShopping => '继续购物';

  @override
  String get addtocard => '加入购物车';

  @override
  String get processtocheckout => '去结算';

  @override
  String get mycart => '我的购物车';

  @override
  String get subtotal => '小计';

  @override
  String get shipping => '运费';

  @override
  String get total => '总计';

  @override
  String get items => '件商品';

  @override
  String get review => '评价';

  @override
  String get availableinstock => '有库存';

  @override
  String get description => '描述';

  @override
  String get reviewsHeader => '顾客评价';

  @override
  String get reviewsLoadingError => '出错了。请重试。';

  @override
  String get noReviewsYet => '暂无评价。快来抢先发表您的看法吧！';

  @override
  String get addReviewTitle => '写评价';

  @override
  String get experienceHint => '您对该产品的体验如何？';

  @override
  String get postButton => '发布';

  @override
  String get errorHappened => '发生错误！';

  @override
  String get reviews => '评价';

  @override
  String get size => '尺码';

  @override
  String get addToCart => '加入购物车';

  @override
  String get removeFromCart => '移出购物车';

  @override
  String get notAvailable => '不可用';

  @override
  String get noAvailableSizes => '无可用尺码';

  @override
  String get noAvailableColors => '无可用颜色';

  @override
  String get productAddedToCart => '商品已加入购物车';

  @override
  String get productRemovedFromCart => '商品已从购物车移除';

  @override
  String get shippingAddresses => '收货地址';

  @override
  String get mainAddress => '默认地址';

  @override
  String get noMainAddress => '无默认地址';

  @override
  String get dragAnAddress => '向上拖动地址以将其设为默认。';

  @override
  String get otherAddresses => '其他地址';

  @override
  String get setMain => '设为默认';

  @override
  String get delete => '删除';

  @override
  String get addNewAddress => '添加新地址';

  @override
  String get tapToAdd => '点击添加';

  @override
  String get swipeToManage => '滑动管理';

  @override
  String get street => '街道';

  @override
  String get city => '城市';

  @override
  String get phoneNumber => '电话号码';

  @override
  String get country => '国家';

  @override
  String get addAddress => '添加地址';

  @override
  String get addressAddedSuccessfully => '地址添加成功';

  @override
  String get streetEmptyDescription => '街道不能为空。';

  @override
  String get streetTooShortDescription => '街道太短，至少需要 5 个字符。';

  @override
  String get cityEmptyDescription => '城市不能为空。';

  @override
  String get cityTooShortDescription => '城市太短，至少需要 2 个字符。';

  @override
  String get countryEmptyDescription => '国家不能为空。';

  @override
  String get countryTooShortDescription => '国家太短，至少需要 2 个字符。';

  @override
  String get phoneEmptyDescription => '电话号码不能为空。';

  @override
  String get phoneInvalidDescription => '请输入有效的电话号码。';

  @override
  String get phoneLengthDescription => '电话号码必须在 8 到 15 位数字之间。';

  @override
  String get uploadImage => '上传图片';

  @override
  String get name => '名称';

  @override
  String get email => '邮箱';

  @override
  String get logOut => '退出登录';

  @override
  String get priceRange => '价格范围';

  @override
  String get sortBy => '排序方式';

  @override
  String get ratting => '评分';

  @override
  String get applyNow => '立即应用';

  @override
  String get noProductsFound => '未找到商品';

  @override
  String get filteredProducts => '筛选后的商品';

  @override
  String get checkout => '结算';

  @override
  String get deliveryAddress => '配送地址';

  @override
  String get products => '商品';

  @override
  String get placeOrder => '提交订单';

  @override
  String get selectDeliveryAddress => '选择配送地址';

  @override
  String get noAddressFound => '未找到地址';

  @override
  String get pleaseAddAddress => '请添加地址以继续。';

  @override
  String get orderPlacedSuccessfully => '下单成功！';

  @override
  String get orderSuccessSubtitle => '您的订单将很快送达。\n感谢您的购买！';

  @override
  String get backToHome => '返回首页';

  @override
  String get trackYourOrder => '追踪订单';

  @override
  String get orderFailedError => '出错了，请重试。';

  @override
  String get nothingFound => '未找到内容';

  @override
  String emptyCategoryDescription(Object categoryName) {
    return '目前我们在“$categoryName”类别中找不到任何商品。请稍后再来看看或浏览其他分类。';
  }

  @override
  String get addCategory => '添加新分类';

  @override
  String get editCategory => '编辑分类';

  @override
  String get categoryName => '分类名称';

  @override
  String get enterCategoryName => '输入分类名称';

  @override
  String get isActive => '是否激活';

  @override
  String get savedSuccessfully => '保存成功';

  @override
  String get fillAllFields => '请填写所有必填字段';

  @override
  String get reorderCategories => '重新排序分类';

  @override
  String get saveChanges => '保存更改';

  @override
  String get areYouSureToSaveCategoryOrder => '您确定要保存新的分类顺序吗？';

  @override
  String get categoryOrderUpdatedSuccessfully => '分类顺序更新成功';

  @override
  String get deleteCategory => '删除分类';

  @override
  String get areYouSureToDeleteCategory => '您确定要删除此分类吗？此操作无法撤销。';

  @override
  String get categoryDeletedSuccessfully => '分类删除成功';

  @override
  String get categorySavedSuccessfully => '分类保存成功';

  @override
  String get newChatRequest => '新聊天请求';

  @override
  String get accept => '接受';

  @override
  String get online => '在线';

  @override
  String get offline => '离线';

  @override
  String get typing => '正在输入...';

  @override
  String get noConnection => '无网络连接';

  @override
  String get sayHi => '打个招呼！';

  @override
  String get typeMessage => '输入消息...';

  @override
  String get searchByEmail => '通过邮箱搜索以开始新聊天';

  @override
  String get chats => '聊天';

  @override
  String get newUsers => '新用户';

  @override
  String get error => '错误';

  @override
  String get noNewUsersFound => '未找到新用户';

  @override
  String get startNewChat => '开始新聊天';

  @override
  String get messages => '消息';

  @override
  String get chatsTab => '聊天';

  @override
  String get requestsTab => '请求';

  @override
  String get justNow => '刚刚';

  @override
  String secondsAgo(Object seconds) {
    return '$seconds秒前';
  }

  @override
  String minutesAgo(Object minutes) {
    return '$minutes分钟前';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours小时前';
  }

  @override
  String get yesterday => '昨天';

  @override
  String daysAgo(Object days) {
    return '$days天前';
  }

  @override
  String get noChatsYet => '暂无聊天';

  @override
  String get noRequestsYet => '暂无请求';

  @override
  String get youRestricted => '您限制了该用户';

  @override
  String get youRestrictedBy => '您被该用户限制了';

  @override
  String get moveToChats => '解除屏蔽并移至聊天';

  @override
  String get restrictedTab => '已屏蔽';

  @override
  String get noRestrictedYet => '无屏蔽用户';

  @override
  String get sendTo => '发送给...';

  @override
  String get shareToOtherApps => '分享到其他应用';

  @override
  String get moveToRequests => '移至请求';

  @override
  String get moveToRestricted => '移至受限';

  @override
  String get areYouSureToLogout => '您确定要退出登录吗？';

  @override
  String get cancel => '取消';

  @override
  String failedToLogout(Object errorMessage) {
    return '退出登录失败：\'$errorMessage\'';
  }

  @override
  String get pleaseEnterUrl => '请输入 URL';

  @override
  String get invalidUrl => '无效的 URL';

  @override
  String get pasteImagesUrl => '粘贴图片 URL';

  @override
  String get save => '保存';

  @override
  String get select => '选择';

  @override
  String get addSize => '添加尺码';

  @override
  String get addNumber => '添加号码';

  @override
  String get addStock => '添加库存';

  @override
  String get selectSize => '选择尺码';

  @override
  String get selectNumber => '选择号码';

  @override
  String get quantity => '数量';

  @override
  String get enterQuantity => '输入数量';

  @override
  String get choose => '选择...';

  @override
  String get add => '添加';

  @override
  String get edit => '编辑';

  @override
  String get addImageFrom => '添加图片来源';

  @override
  String get gallery => '相册';

  @override
  String get urlLink => 'URL 链接';

  @override
  String get productThumbnail => '商品缩略图';

  @override
  String get mainImage => '主图 (封面)';

  @override
  String get editProduct => '编辑商品';

  @override
  String get productColors => '商品颜色';

  @override
  String get addNewColor => '添加新颜色';

  @override
  String get enterProductName => '商品名称';

  @override
  String get productNameRequired => '商品名称为必填项';

  @override
  String get productNameMinLength => '商品名称至少需要 3 个字符';

  @override
  String get enterSubTitle => '商品副标题';

  @override
  String get subTitle => '副标题';

  @override
  String get subtitleRequired => '副标题为必填项';

  @override
  String get subtitleMinLength => '副标题至少需要 2 个字符';

  @override
  String get enterDescription => '商品描述';

  @override
  String get descriptionRequired => '描述为必填项';

  @override
  String get descriptionMinLength => '描述至少需要 10 个字符';

  @override
  String get enterPrice => '输入价格';

  @override
  String get price => '价格';

  @override
  String get priceRequired => '价格为必填项';

  @override
  String get pleaseEnterValidPrice => '请输入有效的价格';

  @override
  String get priceGreaterThanZero => '价格必须大于 0';

  @override
  String get errorFetchingCategories => '获取分类时出错';

  @override
  String get sizesAndStock => '尺码与库存';

  @override
  String get noSizesAdded => '暂未添加尺码。';

  @override
  String get pleaseAddColorsFirst => '请先添加颜色以管理变体。';

  @override
  String get manageStockAndSizes => '管理库存与尺码';

  @override
  String get preview => '预览';

  @override
  String get productAddedSuccessfully => '商品添加成功';

  @override
  String get productEditedSuccessfully => '商品编辑成功';

  @override
  String get addProduct => '添加商品';

  @override
  String get stock => '库存';

  @override
  String get number => '号码';

  @override
  String get category => '分类';

  @override
  String get areYouSureToDeleteProduct => '您确定要删除此商品吗？此操作无法撤销。';

  @override
  String get productDeletedSuccessfully => '商品删除成功';

  @override
  String get deleteProduct => '删除商品';

  @override
  String get yourWishlistIsEmpty => '您的心愿单是空的';

  @override
  String get wishlistEmptyMessage => '看来您还没有添加任何商品到心愿单。去挑点您喜欢的东西吧！';

  @override
  String get noItemsMatchSearch => '没有匹配您搜索的商品';

  @override
  String get itemAddedToCart => '商品已加入购物车！';

  @override
  String get itemRemovedFromCart => '商品已从购物车移除';

  @override
  String get productNotFound => '未找到商品';

  @override
  String get productNotFoundMessage => '抱歉，该商品已不再提供。去看看其他您可能喜欢的东西吧！';

  @override
  String get orderSummary => '订单摘要';

  @override
  String get discount => '折扣';

  @override
  String get promoCode => '优惠码';

  @override
  String get apply => '应用';
}

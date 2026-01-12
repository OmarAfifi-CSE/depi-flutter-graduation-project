// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get test => 'テスト';

  @override
  String get hello => 'こんにちは';

  @override
  String get welcome => 'ようこそ';

  @override
  String userName(Object name) {
    return '名前';
  }

  @override
  String get discountNewArrivalTitle => '新着商品 20% OFF';

  @override
  String get discountNewArrivalDescription => '最新コレクションが驚きの割引価格で。すべての新着商品が20% OFFになります。';

  @override
  String get takeAdvantageShoppingTitle => 'お得なショッピングを楽しもう';

  @override
  String get takeAdvantageShoppingDescription => '限定のショッピング情報をお見逃しなく。特別オファーでお気に入りのアイテムをさらにお得に。';

  @override
  String get allTypesOffersTitle => 'あらゆるオファーがあなたの手に';

  @override
  String get allTypesOffersDescription => '様々なカテゴリーを閲覧して、あなたのニーズや好みに合った最高の情報を探しましょう。';

  @override
  String get welcomeTitle => 'ようこそ！';

  @override
  String get welcomeDescription => '続けるにはログインまたは登録してください';

  @override
  String get emailTitle => 'メールアドレス';

  @override
  String get passwordTitle => 'パスワード';

  @override
  String get loginTitle => 'ログイン';

  @override
  String get signInTitle => 'サインイン';

  @override
  String get orTitle => 'または';

  @override
  String get continueWithGoogleTitle => 'Googleで続ける';

  @override
  String get continueWithGoogleDescription => 'Googleアカウントですばやく安全にログイン';

  @override
  String get forgotPasswordTitle => 'パスワードをお忘れですか？';

  @override
  String get dontHaveAccountTitle => 'アカウントをお持ちでないですか？';

  @override
  String get alreadyAUserTitle => 'すでにアカウントをお持ちですか？';

  @override
  String get signUpTitle => '新規登録';

  @override
  String get loginFailedTitle => 'ログイン失敗';

  @override
  String get loginFailedDescription => 'メールアドレスまたはパスワードが無効です。もう一度お試しください';

  @override
  String get loginSuccessTitle => 'ログイン成功';

  @override
  String get loginSuccessDescription => 'おかえりなさい！ホーム画面へ移動します';

  @override
  String get signUpDescription => '新しいアカウントを作成';

  @override
  String get userNameTitle => 'ユーザー名';

  @override
  String get confirmPasswordTitle => 'パスワード（確認）';

  @override
  String get emailEmptyTitle => 'メールアドレスが必要です';

  @override
  String get emailEmptyDescription => 'メールアドレスを入力してください';

  @override
  String get emailInvalidDescription => '有効なメールアドレスを入力してください';

  @override
  String get nameEmptyDescription => '名前は必須です';

  @override
  String get nameTooShortDescription => '名前が短すぎます';

  @override
  String get passwordEmptyDescription => 'パスワードを入力してください';

  @override
  String get passwordTooShortDescription => 'パスワードは6文字以上である必要があります';

  @override
  String get passwordWeakDescription => 'パスワードには大文字、小文字、数字を含める必要があります';

  @override
  String get pleaseVerifyYourEmail => 'まずメールアドレスを確認してください';

  @override
  String get googleSignInCanceledDescription => 'サインインがキャンセルされました';

  @override
  String get googleNetworkErrorDescription => 'ネットワーク接続の問題';

  @override
  String get googleSignInFailedDescription => 'サインインに失敗しました';

  @override
  String get googleConfigErrorDescription => 'Googleサインイン設定エラー';

  @override
  String get googleUnexpectedErrorDescription => '予期せぬエラーが発生しました';

  @override
  String get emailAlreadyInUseDescription => 'このメールアドレスは既に登録されています';

  @override
  String get invalidEmailDescription => '無効なメールアドレス';

  @override
  String get operationNotAllowedDescription => 'サインイン方法が無効です';

  @override
  String get weakPasswordDescription => 'パスワードが弱すぎます';

  @override
  String get userDisabledDescription => 'アカウントが無効になっています';

  @override
  String get userNotFoundDescription => 'ユーザーが見つかりません';

  @override
  String get wrongPasswordDescription => 'パスワードが間違っています';

  @override
  String get invalidCredentialDescription => '無効な認証情報';

  @override
  String get networkRequestFailedDescription => '接続に失敗しました';

  @override
  String get invalidVerificationCodeDescription => '無効な確認コード';

  @override
  String get invalidVerificationIdDescription => '無効な確認ID';

  @override
  String get tooManyRequestsDescription => 'リクエストが多すぎます。後でもう一度お試しください';

  @override
  String get internalErrorDescription => '内部エラーが発生しました';

  @override
  String get accountExistsWithDifferentCredentialDescription => '別のアカウント情報で既に登録されています';

  @override
  String get credentialAlreadyInUseDescription => 'この認証情報は既に使用されています';

  @override
  String get defaultAuthErrorDescription => '予期せぬエラーが発生しました';

  @override
  String get passwordMustMatch => 'パスワードが一致しません';

  @override
  String get resetPassword => 'パスワードをリセット';

  @override
  String get resetPasswordLabel => 'アカウントに関連付けられたメールアドレスを入力してください。パスワードリセットの手順を送信します';

  @override
  String get sendInstruction => '手順を送信';

  @override
  String get forgotPassword => 'パスワードをお忘れですか？';

  @override
  String get reset => 'リセット';

  @override
  String get expiredActionCodeDescription => 'リンクの有効期限が切れています。新しいリンクをリクエストしてください。';

  @override
  String get invalidActionCodeDescription => 'リンクが無効です。新しいリンクをリクエストしてください。';

  @override
  String get emailVerifiedTitle => 'メール確認完了！';

  @override
  String get emailVerifiedSubtitle => 'アカウントが有効になり、使用準備が整いました。ご登録ありがとうございます。';

  @override
  String get continueToSignInButton => 'ログインへ進む';

  @override
  String get verificationFailedTitle => '確認失敗';

  @override
  String get backToSignInButton => 'ログインへ戻る';

  @override
  String get signin_success => 'サインインしました';

  @override
  String get check_email_activation => 'メールを確認してアカウントを有効化してください。';

  @override
  String get forget_password_sent => '送信されました';

  @override
  String get something_went_wrong => '問題が発生しました。';

  @override
  String get close => '閉じる';

  @override
  String get login_success => 'サインインしました';

  @override
  String get create_new_password => '新しいパスワードを作成';

  @override
  String get password_changed_success => 'パスワードが変更されました';

  @override
  String get confirm => '確認';

  @override
  String get invalid_or_expired_link => 'リンクが無効か、期限切れか、既に使用されています。新しいリンクをリクエストしてください。';

  @override
  String get unexpected_error => '予期せぬエラーが発生しました。もう一度お試しください。';

  @override
  String get home => 'ホーム';

  @override
  String get categories => 'カテゴリー';

  @override
  String get cart => 'カート';

  @override
  String get notifications => '通知';

  @override
  String get profile => 'プロフィール';

  @override
  String get search => '検索';

  @override
  String get emptyCategories => 'カテゴリーが見つかりません';

  @override
  String get couldNotLoadCategories => 'カテゴリーを読み込めませんでした';

  @override
  String get defaultError => '予期せぬエラーが発生しました。';

  @override
  String get adminDashboard => '管理ダッシュボード';

  @override
  String get activeEditingMode => '編集モード中';

  @override
  String get viewAsCustomer => '顧客として表示';

  @override
  String get personalDetails => '個人情報';

  @override
  String get myOrders => '注文履歴';

  @override
  String get wishlist => 'お気に入り';

  @override
  String get shippingAddress => '配送先住所';

  @override
  String get myCard => 'マイカード';

  @override
  String get settings => '設定';

  @override
  String get language => '言語';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get lightMode => 'ライトモード';

  @override
  String get helpCenter => 'ヘルプセンター';

  @override
  String get english => '英語';

  @override
  String get emptyCartTitle => 'カートは空です';

  @override
  String get emptyCartSubtitle => 'まだカートに商品がないようです。お気に入りを見つけに行きましょう！';

  @override
  String get continueShopping => '買い物を始める';

  @override
  String get addtocard => 'カートに追加';

  @override
  String get processtocheckout => 'レジに進む';

  @override
  String get mycart => 'マイカート';

  @override
  String get subtotal => '小計';

  @override
  String get shipping => '送料';

  @override
  String get total => '合計';

  @override
  String get items => '点';

  @override
  String get review => 'レビュー';

  @override
  String get availableinstock => '在庫あり';

  @override
  String get description => '説明';

  @override
  String get reviewsHeader => 'カスタマーレビュー';

  @override
  String get reviewsLoadingError => '問題が発生しました。もう一度お試しください。';

  @override
  String get noReviewsYet => 'レビューはまだありません。最初のレビューを投稿しましょう！';

  @override
  String get addReviewTitle => 'レビューを書く';

  @override
  String get experienceHint => 'この商品の体験はいかがでしたか？';

  @override
  String get postButton => '投稿';

  @override
  String get errorHappened => 'エラーが発生しました！';

  @override
  String get reviews => 'レビュー';

  @override
  String get size => 'サイズ';

  @override
  String get addToCart => 'カートに追加';

  @override
  String get removeFromCart => 'カートから削除';

  @override
  String get notAvailable => '利用不可';

  @override
  String get noAvailableSizes => '利用可能なサイズがありません';

  @override
  String get noAvailableColors => '利用可能なカラーがありません';

  @override
  String get productAddedToCart => '商品をカートに追加しました';

  @override
  String get productRemovedFromCart => '商品をカートから削除しました';

  @override
  String get shippingAddresses => '配送先住所一覧';

  @override
  String get mainAddress => 'メインの住所';

  @override
  String get noMainAddress => 'メインの住所がありません';

  @override
  String get dragAnAddress => '住所を上にドラッグしてメインに設定します。';

  @override
  String get otherAddresses => 'その他の住所';

  @override
  String get setMain => 'メインに設定';

  @override
  String get delete => '削除';

  @override
  String get addNewAddress => '新しい住所を追加';

  @override
  String get tapToAdd => 'タップして追加';

  @override
  String get swipeToManage => 'スワイプして管理';

  @override
  String get street => '住所（番地など）';

  @override
  String get city => '市区町村';

  @override
  String get phoneNumber => '電話番号';

  @override
  String get country => '国';

  @override
  String get addAddress => '住所を追加';

  @override
  String get addressAddedSuccessfully => '住所が正常に追加されました';

  @override
  String get streetEmptyDescription => '住所は空にできません。';

  @override
  String get streetTooShortDescription => '住所が短すぎます。5文字以上入力してください。';

  @override
  String get cityEmptyDescription => '市区町村は空にできません。';

  @override
  String get cityTooShortDescription => '市区町村が短すぎます。2文字以上入力してください。';

  @override
  String get countryEmptyDescription => '国名は空にできません。';

  @override
  String get countryTooShortDescription => '国名が短すぎます。2文字以上入力してください。';

  @override
  String get phoneEmptyDescription => '電話番号は空にできません。';

  @override
  String get phoneInvalidDescription => '有効な電話番号を入力してください。';

  @override
  String get phoneLengthDescription => '電話番号は8〜15桁である必要があります。';

  @override
  String get uploadImage => '画像をアップロード';

  @override
  String get name => '名前';

  @override
  String get email => 'メールアドレス';

  @override
  String get logOut => 'ログアウト';

  @override
  String get priceRange => '価格帯';

  @override
  String get sortBy => '並び替え';

  @override
  String get rating => '評価';

  @override
  String get applyNow => '適用する';

  @override
  String get noProductsFound => '商品が見つかりません';

  @override
  String get filteredProducts => '絞り込み結果';

  @override
  String get checkout => '会計';

  @override
  String get deliveryAddress => 'お届け先住所';

  @override
  String get products => '商品';

  @override
  String get placeOrder => '注文を確定する';

  @override
  String get selectDeliveryAddress => 'お届け先を選択';

  @override
  String get noAddressFound => '住所が見つかりません';

  @override
  String get pleaseAddAddress => '続行するには住所を追加してください。';

  @override
  String get orderPlacedSuccessfully => '注文完了！';

  @override
  String get orderSuccessSubtitle => 'ご注文の商品はまもなく発送されます。\nご利用ありがとうございます！';

  @override
  String get backToHome => 'ホームに戻る';

  @override
  String get trackYourOrder => '注文を追跡';

  @override
  String get orderFailedError => '問題が発生しました。もう一度お試しください。';

  @override
  String get nothingFound => '見つかりませんでした';

  @override
  String emptyCategoryDescription(Object categoryName) {
    return '現在「$categoryName」カテゴリーには商品がありません。後でもう一度確認するか、他のカテゴリーをご覧ください。';
  }

  @override
  String get addCategory => '新しいカテゴリーを追加';

  @override
  String get editCategory => 'カテゴリーを編集';

  @override
  String get categoryName => 'カテゴリー名';

  @override
  String get enterCategoryName => 'カテゴリー名を入力';

  @override
  String get isActive => '有効';

  @override
  String get savedSuccessfully => '保存しました';

  @override
  String get fillAllFields => '必須項目をすべて入力してください';

  @override
  String get reorderCategories => 'カテゴリーを並べ替え';

  @override
  String get saveChanges => '変更を保存';

  @override
  String get areYouSureToSaveCategoryOrder => '新しいカテゴリー順序を保存してもよろしいですか？';

  @override
  String get categoryOrderUpdatedSuccessfully => 'カテゴリー順序を更新しました';

  @override
  String get deleteCategory => 'カテゴリーを削除';

  @override
  String get areYouSureToDeleteCategory => '本当にこのカテゴリーを削除しますか？この操作は取り消せません。';

  @override
  String get categoryDeletedSuccessfully => 'カテゴリーを削除しました';

  @override
  String get categorySavedSuccessfully => 'カテゴリーを保存しました';

  @override
  String get newChatRequest => '新しいチャットリクエスト';

  @override
  String get accept => '承認';

  @override
  String get online => 'オンライン';

  @override
  String get offline => 'オフライン';

  @override
  String get typing => '入力中...';

  @override
  String get noConnection => '接続がありません';

  @override
  String get sayHi => '挨拶しましょう！';

  @override
  String get typeMessage => 'メッセージを入力...';

  @override
  String get searchByEmail => 'メールで検索してチャットを開始';

  @override
  String get chats => 'チャット';

  @override
  String get newUsers => '新規ユーザー';

  @override
  String get error => 'エラー';

  @override
  String get noNewUsersFound => '新規ユーザーは見つかりませんでした';

  @override
  String get startNewChat => '新しいチャットを開始';

  @override
  String get messages => 'メッセージ';

  @override
  String get chatsTab => 'チャット';

  @override
  String get requestsTab => 'リクエスト';

  @override
  String get justNow => 'たった今';

  @override
  String secondsAgo(Object seconds) {
    return '$seconds秒前';
  }

  @override
  String minutesAgo(Object minutes) {
    return '$minutes分前';
  }

  @override
  String hoursAgo(Object hours) {
    return '$hours時間前';
  }

  @override
  String get yesterday => '昨日';

  @override
  String daysAgo(Object days) {
    return '$days日前';
  }

  @override
  String get noChatsYet => 'チャットはまだありません';

  @override
  String get noRequestsYet => 'リクエストはまだありません';

  @override
  String get youRestricted => 'このユーザーを制限しました';

  @override
  String get youRestrictedBy => 'このユーザーによって制限されています';

  @override
  String get moveToChats => 'ブロック解除してチャットへ移動';

  @override
  String get restrictedTab => 'ブロック中';

  @override
  String get noRestrictedYet => 'ブロック中のユーザーはいません';

  @override
  String get sendTo => '送信先...';

  @override
  String get shareToOtherApps => '他のアプリで共有';

  @override
  String get moveToRequests => 'リクエストへ移動';

  @override
  String get moveToRestricted => '制限リストへ移動';

  @override
  String get areYouSureToLogout => 'ログアウトしてもよろしいですか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String failedToLogout(Object errorMessage) {
    return 'ログアウトに失敗しました: \'$errorMessage\'';
  }

  @override
  String get pleaseEnterUrl => 'URLを入力してください';

  @override
  String get invalidUrl => '無効なURL';

  @override
  String get pasteImagesUrl => '画像のURLを貼り付け';

  @override
  String get save => '保存';

  @override
  String get select => '選択';

  @override
  String get addSize => 'サイズを追加';

  @override
  String get addNumber => '番号を追加';

  @override
  String get addStock => '在庫を追加';

  @override
  String get selectSize => 'サイズを選択';

  @override
  String get selectNumber => '番号を選択';

  @override
  String get quantity => '数量';

  @override
  String get enterQuantity => '数量を入力';

  @override
  String get choose => '選択...';

  @override
  String get add => '追加';

  @override
  String get edit => '編集';

  @override
  String get addImageFrom => '画像の追加元';

  @override
  String get gallery => 'ギャラリー';

  @override
  String get urlLink => 'URLリンク';

  @override
  String get productThumbnail => '商品サムネイル';

  @override
  String get mainImage => 'メイン画像（カバー）';

  @override
  String get editProduct => '商品を編集';

  @override
  String get productColors => '商品カラー';

  @override
  String get addNewColor => '新しいカラーを追加';

  @override
  String get enterProductName => '商品名';

  @override
  String get productNameRequired => '商品名は必須です';

  @override
  String get productNameMinLength => '商品名は3文字以上である必要があります';

  @override
  String get enterSubTitle => '商品サブタイトル';

  @override
  String get subTitle => 'サブタイトル';

  @override
  String get subtitleRequired => 'サブタイトルは必須です';

  @override
  String get subtitleMinLength => 'サブタイトルは2文字以上である必要があります';

  @override
  String get enterDescription => '商品説明';

  @override
  String get descriptionRequired => '説明は必須です';

  @override
  String get descriptionMinLength => '説明は10文字以上である必要があります';

  @override
  String get enterPrice => '価格を入力';

  @override
  String get price => '価格';

  @override
  String get priceRequired => '価格は必須です';

  @override
  String get pleaseEnterValidPrice => '有効な価格を入力してください';

  @override
  String get priceGreaterThanZero => '価格は0より大きい必要があります';

  @override
  String get errorFetchingCategories => 'カテゴリーの取得中にエラーが発生しました';

  @override
  String get sizesAndStock => 'サイズと在庫';

  @override
  String get noSizesAdded => 'サイズはまだ追加されていません。';

  @override
  String get pleaseAddColorsFirst => 'バリエーションを管理するには、先にカラーを追加してください。';

  @override
  String get manageStockAndSizes => '在庫とサイズの管理';

  @override
  String get preview => 'プレビュー';

  @override
  String get productAddedSuccessfully => '商品を追加しました';

  @override
  String get productEditedSuccessfully => '商品を編集しました';

  @override
  String get addProduct => '商品を追加';

  @override
  String get stock => '在庫';

  @override
  String get number => '番号';

  @override
  String get category => 'カテゴリー';

  @override
  String get areYouSureToDeleteProduct => '本当にこの商品を削除しますか？この操作は取り消せません。';

  @override
  String get productDeletedSuccessfully => '商品を削除しました';

  @override
  String get deleteProduct => '商品を削除';

  @override
  String get yourWishlistIsEmpty => 'お気に入りは空です';

  @override
  String get wishlistEmptyMessage => 'まだお気に入りに商品を追加していないようです。素敵な商品を見つけに行きましょう！';

  @override
  String get noItemsMatchSearch => '検索条件に一致する商品はありません';

  @override
  String get itemAddedToCart => '商品をカートに追加しました！';

  @override
  String get itemRemovedFromCart => '商品をカートから削除しました';

  @override
  String get productNotFound => '商品が見つかりません';

  @override
  String get productNotFoundMessage => '申し訳ありませんが、この商品は現在利用できません。他の商品を探してみましょう！';

  @override
  String get orderSummary => '注文概要';

  @override
  String get discount => '割引';

  @override
  String get promoCode => 'プロモーションコード';

  @override
  String get apply => '適用';

  @override
  String get cartItemRemovedMsg => '申し訳ありませんが、このオプションは在庫切れのためカートから削除されました';

  @override
  String get wishlistItemRemovedMsg => '申し訳ありませんが、この商品は現在利用できないため、ウィッシュリストから削除されました';

  @override
  String get outOfStock => '在庫切れ';

  @override
  String get paymentMethod => '支払い方法';

  @override
  String get payOnDelivery => '代金引換';

  @override
  String get payOnDeliverySubtitle => '受け取り時に現金で支払う';

  @override
  String get allOrdersAdmin => '全ての注文（管理者）';

  @override
  String get noOrdersYet => 'まだ注文はありません';

  @override
  String get emptyOrdersSubtitle => 'まだ注文がないようです。ショッピングを始めてリストを埋めましょう！';

  @override
  String get startShopping => 'ショッピングを始める';

  @override
  String orderNumber(Object orderId) {
    return '注文 #$orderId';
  }

  @override
  String get userLabel => 'ユーザー: ';

  @override
  String itemsCount(Object count) {
    return '$count 個';
  }

  @override
  String get totalLabel => '合計: ';

  @override
  String get changeStatus => 'ステータス変更';

  @override
  String get statusPending => '保留中';

  @override
  String get statusProcessing => '処理中';

  @override
  String get statusShipped => '発送済み';

  @override
  String get statusDelivered => '配達済み';

  @override
  String get statusCancelled => 'キャンセル';

  @override
  String get orderDetails => '注文詳細';

  @override
  String get customerLabel => 'お客様: ';

  @override
  String get phoneLabel => '電話: ';

  @override
  String get paymentSummary => 'お支払い概要';

  @override
  String get free => '無料';

  @override
  String get totalAmount => '合計金額';

  @override
  String get sizeLabel => 'サイズ: ';

  @override
  String get changeOrderStatus => '注文ステータスを変更';

  @override
  String get applied => '適用済み';

  @override
  String get invalid => '無効';
}

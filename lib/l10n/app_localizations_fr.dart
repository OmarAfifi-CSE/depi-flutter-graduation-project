// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get test => 'Test';

  @override
  String get hello => 'Bonjour';

  @override
  String get welcome => 'Bienvenue';

  @override
  String userName(Object name) {
    return 'Nom';
  }

  @override
  String get discountNewArrivalTitle => '20% de réduction sur les nouveaux arrivages';

  @override
  String get discountNewArrivalDescription => 'Découvrez des remises incroyables sur notre dernière collection. Obtenez 20% de réduction sur tous les nouveaux produits.';

  @override
  String get takeAdvantageShoppingTitle => 'Profitez des offres shopping';

  @override
  String get takeAdvantageShoppingDescription => 'Ne manquez pas les offres exclusives. Économisez davantage sur vos articles préférés avec des offres spéciales.';

  @override
  String get allTypesOffersTitle => 'Toutes sortes d\'offres à votre portée';

  @override
  String get allTypesOffersDescription => 'Parcourez diverses catégories et trouvez les meilleures offres adaptées à vos besoins et préférences.';

  @override
  String get welcomeTitle => 'Bienvenue !';

  @override
  String get welcomeDescription => 'Veuillez vous connecter ou vous inscrire pour continuer';

  @override
  String get emailTitle => 'E-mail';

  @override
  String get passwordTitle => 'Mot de passe';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get signInTitle => 'Se connecter';

  @override
  String get orTitle => 'ou';

  @override
  String get continueWithGoogleTitle => 'Continuer avec Google';

  @override
  String get continueWithGoogleDescription => 'Connexion rapide et sécurisée avec votre compte Google';

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié ?';

  @override
  String get dontHaveAccountTitle => 'Pas encore de compte ?';

  @override
  String get alreadyAUserTitle => 'Déjà utilisateur ?';

  @override
  String get signUpTitle => 'S\'inscrire';

  @override
  String get loginFailedTitle => 'Échec de la connexion';

  @override
  String get loginFailedDescription => 'E-mail ou mot de passe invalide. Veuillez réessayer';

  @override
  String get loginSuccessTitle => 'Connexion réussie';

  @override
  String get loginSuccessDescription => 'Bon retour ! Redirection vers l\'accueil';

  @override
  String get signUpDescription => 'Créer un nouveau compte';

  @override
  String get userNameTitle => 'Nom d\'utilisateur';

  @override
  String get confirmPasswordTitle => 'Confirmer le mot de passe';

  @override
  String get emailEmptyTitle => 'E-mail requis';

  @override
  String get emailEmptyDescription => 'Veuillez entrer votre e-mail';

  @override
  String get emailInvalidDescription => 'Veuillez entrer une adresse e-mail valide';

  @override
  String get nameEmptyDescription => 'Le nom est requis';

  @override
  String get nameTooShortDescription => 'Le nom est trop court';

  @override
  String get passwordEmptyDescription => 'Veuillez entrer votre mot de passe';

  @override
  String get passwordTooShortDescription => 'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get passwordWeakDescription => 'Le mot de passe doit contenir des majuscules, des minuscules et un chiffre';

  @override
  String get pleaseVerifyYourEmail => 'Veuillez d\'abord vérifier votre e-mail';

  @override
  String get googleSignInCanceledDescription => 'Connexion annulée';

  @override
  String get googleNetworkErrorDescription => 'Problème de connexion réseau';

  @override
  String get googleSignInFailedDescription => 'Échec de la connexion';

  @override
  String get googleConfigErrorDescription => 'Erreur de configuration Google Sign-In';

  @override
  String get googleUnexpectedErrorDescription => 'Une erreur inattendue s\'est produite';

  @override
  String get emailAlreadyInUseDescription => 'E-mail déjà enregistré';

  @override
  String get invalidEmailDescription => 'Adresse e-mail invalide';

  @override
  String get operationNotAllowedDescription => 'Méthode de connexion désactivée';

  @override
  String get weakPasswordDescription => 'Mot de passe trop faible';

  @override
  String get userDisabledDescription => 'Compte désactivé';

  @override
  String get userNotFoundDescription => 'Utilisateur introuvable';

  @override
  String get wrongPasswordDescription => 'Mot de passe incorrect';

  @override
  String get invalidCredentialDescription => 'Identifiants invalides';

  @override
  String get networkRequestFailedDescription => 'Échec de la connexion';

  @override
  String get invalidVerificationCodeDescription => 'Code de vérification invalide';

  @override
  String get invalidVerificationIdDescription => 'ID de vérification invalide';

  @override
  String get tooManyRequestsDescription => 'Trop de demandes, réessayez plus tard';

  @override
  String get internalErrorDescription => 'Une erreur interne s\'est produite';

  @override
  String get accountExistsWithDifferentCredentialDescription => 'Un compte existe déjà avec des identifiants différents';

  @override
  String get credentialAlreadyInUseDescription => 'Identifiants utilisés ailleurs';

  @override
  String get defaultAuthErrorDescription => 'Une erreur inattendue s\'est produite';

  @override
  String get passwordMustMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordLabel => 'Entrez l\'e-mail associé à votre compte et nous vous enverrons un e-mail avec les instructions pour réinitialiser votre mot de passe';

  @override
  String get sendInstruction => 'Envoyer les instructions';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get reset => 'Réinitialiser';

  @override
  String get expiredActionCodeDescription => 'Le lien a expiré. Veuillez en demander un nouveau.';

  @override
  String get invalidActionCodeDescription => 'Le lien est invalide. Veuillez en demander un nouveau.';

  @override
  String get emailVerifiedTitle => 'E-mail vérifié !';

  @override
  String get emailVerifiedSubtitle => 'Votre compte est maintenant actif et prêt à être utilisé. Merci de nous avoir rejoint.';

  @override
  String get continueToSignInButton => 'Continuer vers la connexion';

  @override
  String get verificationFailedTitle => 'Échec de la vérification';

  @override
  String get backToSignInButton => 'Retour à la connexion';

  @override
  String get signin_success => 'Connexion réussie';

  @override
  String get check_email_activation => 'Veuillez vérifier votre e-mail pour activer votre compte.';

  @override
  String get forget_password_sent => 'Envoyé avec succès';

  @override
  String get something_went_wrong => 'Une erreur s\'est produite.';

  @override
  String get close => 'Fermer';

  @override
  String get login_success => 'Connexion réussie';

  @override
  String get create_new_password => 'Créer un nouveau mot de passe';

  @override
  String get password_changed_success => 'Mot de passe modifié avec succès';

  @override
  String get confirm => 'Confirmer';

  @override
  String get invalid_or_expired_link => 'Le lien est invalide, a expiré ou a déjà été utilisé. Veuillez en demander un nouveau.';

  @override
  String get unexpected_error => 'Une erreur inattendue s\'est produite. Veuillez réessayer.';

  @override
  String get home => 'Accueil';

  @override
  String get categories => 'Catégories';

  @override
  String get cart => 'Panier';

  @override
  String get notifications => 'Notifications';

  @override
  String get profile => 'Profil';

  @override
  String get search => 'Rechercher';

  @override
  String get emptyCategories => 'Aucune catégorie trouvée';

  @override
  String get couldNotLoadCategories => 'Impossible de charger les catégories';

  @override
  String get defaultError => 'Une erreur inattendue s\'est produite.';

  @override
  String get adminDashboard => 'Tableau de bord Admin';

  @override
  String get activeEditingMode => 'Mode édition actif';

  @override
  String get viewAsCustomer => 'Voir en tant que client';

  @override
  String get personalDetails => 'Détails personnels';

  @override
  String get myOrders => 'Mes commandes';

  @override
  String get wishlist => 'Liste de souhaits';

  @override
  String get shippingAddress => 'Adresse de livraison';

  @override
  String get myCard => 'Ma carte';

  @override
  String get settings => 'Paramètres';

  @override
  String get language => 'Langue';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get helpCenter => 'Centre d\'aide';

  @override
  String get english => 'Anglais';

  @override
  String get emptyCartTitle => 'Votre panier est vide';

  @override
  String get emptyCartSubtitle => 'Il semble que vous n\'ayez encore rien ajouté à votre panier. Allons trouver quelque chose que vous aimerez !';

  @override
  String get continueShopping => 'Continuer vos achats';

  @override
  String get addtocard => 'Ajouter au panier';

  @override
  String get processtocheckout => 'Passer à la caisse';

  @override
  String get mycart => 'Mon panier';

  @override
  String get subtotal => 'Sous-total';

  @override
  String get shipping => 'Livraison';

  @override
  String get total => 'Total';

  @override
  String get items => 'articles';

  @override
  String get review => 'Avis';

  @override
  String get availableinstock => 'Disponible en stock';

  @override
  String get description => 'Description';

  @override
  String get reviewsHeader => 'Avis clients';

  @override
  String get reviewsLoadingError => 'Une erreur s\'est produite. Veuillez réessayer.';

  @override
  String get noReviewsYet => 'Pas encore d\'avis. Soyez le premier à partager votre opinion !';

  @override
  String get addReviewTitle => 'Écrire un avis';

  @override
  String get experienceHint => 'Comment s\'est passée votre expérience avec ce produit ?';

  @override
  String get postButton => 'Publier';

  @override
  String get errorHappened => 'Une erreur est survenue !';

  @override
  String get reviews => 'Avis';

  @override
  String get size => 'Taille';

  @override
  String get addToCart => 'Ajouter au panier';

  @override
  String get removeFromCart => 'Retirer du panier';

  @override
  String get notAvailable => 'Indisponible';

  @override
  String get noAvailableSizes => 'Aucune taille disponible';

  @override
  String get noAvailableColors => 'Aucune couleur disponible';

  @override
  String get productAddedToCart => 'Produit ajouté au panier';

  @override
  String get productRemovedFromCart => 'Produit retiré du panier';

  @override
  String get shippingAddresses => 'Adresses de livraison';

  @override
  String get mainAddress => 'Adresse principale';

  @override
  String get noMainAddress => 'Aucune adresse principale';

  @override
  String get dragAnAddress => 'Faites glisser une adresse vers le haut pour la définir comme principale.';

  @override
  String get otherAddresses => 'Autres adresses';

  @override
  String get setMain => 'Définir comme principale';

  @override
  String get delete => 'Supprimer';

  @override
  String get addNewAddress => 'Ajouter une nouvelle adresse';

  @override
  String get tapToAdd => 'Appuyer pour ajouter';

  @override
  String get swipeToManage => 'Glisser pour gérer';

  @override
  String get street => 'Rue';

  @override
  String get city => 'Ville';

  @override
  String get phoneNumber => 'Numéro de téléphone';

  @override
  String get country => 'Pays';

  @override
  String get addAddress => 'Ajouter l\'adresse';

  @override
  String get addressAddedSuccessfully => 'Adresse ajoutée avec succès';

  @override
  String get streetEmptyDescription => 'La rue ne peut pas être vide.';

  @override
  String get streetTooShortDescription => 'La rue est trop courte, doit comporter au moins 5 caractères.';

  @override
  String get cityEmptyDescription => 'La ville ne peut pas être vide.';

  @override
  String get cityTooShortDescription => 'La ville est trop courte, doit comporter au moins 2 caractères.';

  @override
  String get countryEmptyDescription => 'Le pays ne peut pas être vide.';

  @override
  String get countryTooShortDescription => 'Le pays est trop court, doit comporter au moins 2 caractères.';

  @override
  String get phoneEmptyDescription => 'Le numéro de téléphone ne peut pas être vide.';

  @override
  String get phoneInvalidDescription => 'Veuillez entrer un numéro de téléphone valide.';

  @override
  String get phoneLengthDescription => 'Le numéro de téléphone doit comporter entre 8 et 15 chiffres.';

  @override
  String get uploadImage => 'Télécharger une image';

  @override
  String get name => 'Nom';

  @override
  String get email => 'E-mail';

  @override
  String get logOut => 'Se déconnecter';

  @override
  String get priceRange => 'Fourchette de prix';

  @override
  String get sortBy => 'Trier par';

  @override
  String get rating => 'Évaluation';

  @override
  String get applyNow => 'Appliquer maintenant';

  @override
  String get noProductsFound => 'Aucun produit trouvé';

  @override
  String get filteredProducts => 'Produits filtrés';

  @override
  String get checkout => 'Paiement';

  @override
  String get deliveryAddress => 'Adresse de livraison';

  @override
  String get products => 'Produits';

  @override
  String get placeOrder => 'Passer la commande';

  @override
  String get selectDeliveryAddress => 'Sélectionner l\'adresse de livraison';

  @override
  String get noAddressFound => 'Aucune adresse trouvée';

  @override
  String get pleaseAddAddress => 'Veuillez ajouter une adresse pour continuer.';

  @override
  String get orderPlacedSuccessfully => 'Commande passée !';

  @override
  String get orderSuccessSubtitle => 'Votre commande sera bientôt livrée.\nMerci d\'avoir acheté chez nous !';

  @override
  String get backToHome => 'Retour à l\'accueil';

  @override
  String get trackYourOrder => 'Suivre votre commande';

  @override
  String get orderFailedError => 'Une erreur s\'est produite, veuillez réessayer.';

  @override
  String get nothingFound => 'Rien trouvé';

  @override
  String emptyCategoryDescription(Object categoryName) {
    return 'Nous n\'avons trouvé aucun produit dans la catégorie \'$categoryName\' pour le moment. Réessayez plus tard ou explorez d\'autres catégories.';
  }

  @override
  String get addCategory => 'Ajouter une catégorie';

  @override
  String get editCategory => 'Modifier la catégorie';

  @override
  String get categoryName => 'Nom de la catégorie';

  @override
  String get enterCategoryName => 'Entrer le nom de la catégorie';

  @override
  String get isActive => 'Est active';

  @override
  String get savedSuccessfully => 'Enregistré avec succès';

  @override
  String get fillAllFields => 'Veuillez remplir tous les champs requis';

  @override
  String get reorderCategories => 'Réorganiser les catégories';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get areYouSureToSaveCategoryOrder => 'Êtes-vous sûr de vouloir enregistrer le nouvel ordre des catégories ?';

  @override
  String get categoryOrderUpdatedSuccessfully => 'Ordre des catégories mis à jour avec succès';

  @override
  String get deleteCategory => 'Supprimer la catégorie';

  @override
  String get areYouSureToDeleteCategory => 'Êtes-vous sûr de vouloir supprimer cette catégorie ? Cette action est irréversible.';

  @override
  String get categoryDeletedSuccessfully => 'Catégorie supprimée avec succès';

  @override
  String get categorySavedSuccessfully => 'Catégorie enregistrée avec succès';

  @override
  String get newChatRequest => 'Nouvelle demande de chat';

  @override
  String get accept => 'Accepter';

  @override
  String get online => 'En ligne';

  @override
  String get offline => 'Hors ligne';

  @override
  String get typing => 'écrit...';

  @override
  String get noConnection => 'Pas de connexion';

  @override
  String get sayHi => 'Dites bonjour !';

  @override
  String get typeMessage => 'Tapez votre message...';

  @override
  String get searchByEmail => 'Rechercher par e-mail pour commencer un chat';

  @override
  String get chats => 'Chats';

  @override
  String get newUsers => 'Nouveaux utilisateurs';

  @override
  String get error => 'Erreur';

  @override
  String get noNewUsersFound => 'Aucun nouvel utilisateur trouvé';

  @override
  String get startNewChat => 'Commencer un nouveau chat';

  @override
  String get messages => 'Messages';

  @override
  String get chatsTab => 'Discussions';

  @override
  String get requestsTab => 'Demandes';

  @override
  String get justNow => 'À l\'instant';

  @override
  String secondsAgo(Object seconds) {
    return 'Il y a ${seconds}s';
  }

  @override
  String minutesAgo(Object minutes) {
    return 'Il y a ${minutes}m';
  }

  @override
  String hoursAgo(Object hours) {
    return 'Il y a ${hours}h';
  }

  @override
  String get yesterday => 'Hier';

  @override
  String daysAgo(Object days) {
    return 'Il y a ${days}j';
  }

  @override
  String get noChatsYet => 'Pas encore de discussions';

  @override
  String get noRequestsYet => 'Pas encore de demandes';

  @override
  String get youRestricted => 'Vous avez restreint cet utilisateur';

  @override
  String get youRestrictedBy => 'Vous êtes restreint par cet utilisateur';

  @override
  String get moveToChats => 'Débloquer et déplacer vers les chats';

  @override
  String get restrictedTab => 'Bloqué';

  @override
  String get noRestrictedYet => 'Aucun utilisateur bloqué';

  @override
  String get sendTo => 'Envoyer à...';

  @override
  String get shareToOtherApps => 'Partager vers d\'autres applis';

  @override
  String get moveToRequests => 'Déplacer vers les demandes';

  @override
  String get moveToRestricted => 'Déplacer vers restreint';

  @override
  String get areYouSureToLogout => 'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get cancel => 'Annuler';

  @override
  String failedToLogout(Object errorMessage) {
    return 'Échec de la déconnexion : \'$errorMessage\'';
  }

  @override
  String get pleaseEnterUrl => 'Veuillez entrer une URL';

  @override
  String get invalidUrl => 'URL invalide';

  @override
  String get pasteImagesUrl => 'Coller les URL des images';

  @override
  String get save => 'Enregistrer';

  @override
  String get select => 'Sélectionner';

  @override
  String get addSize => 'Ajouter une taille';

  @override
  String get addNumber => 'Ajouter un nombre';

  @override
  String get addStock => 'Ajouter du stock';

  @override
  String get selectSize => 'Sélectionner une taille';

  @override
  String get selectNumber => 'Sélectionner un nombre';

  @override
  String get quantity => 'Quantité';

  @override
  String get enterQuantity => 'Entrer la quantité';

  @override
  String get choose => 'Choisir...';

  @override
  String get add => 'Ajouter';

  @override
  String get edit => 'Modifier';

  @override
  String get addImageFrom => 'Ajouter une image depuis';

  @override
  String get gallery => 'Galerie';

  @override
  String get urlLink => 'Lien URL';

  @override
  String get productThumbnail => 'Miniature du produit';

  @override
  String get mainImage => 'Image principale (Couverture)';

  @override
  String get editProduct => 'Modifier le produit';

  @override
  String get productColors => 'Couleurs du produit';

  @override
  String get addNewColor => 'Ajouter une nouvelle couleur';

  @override
  String get enterProductName => 'Nom du produit';

  @override
  String get productNameRequired => 'Le nom du produit est requis';

  @override
  String get productNameMinLength => 'Le nom du produit doit comporter au moins 3 caractères';

  @override
  String get enterSubTitle => 'Sous-titre du produit';

  @override
  String get subTitle => 'Sous-titre';

  @override
  String get subtitleRequired => 'Le sous-titre est requis';

  @override
  String get subtitleMinLength => 'Le sous-titre doit comporter au moins 2 caractères';

  @override
  String get enterDescription => 'Description du produit';

  @override
  String get descriptionRequired => 'La description est requise';

  @override
  String get descriptionMinLength => 'La description doit comporter au moins 10 caractères';

  @override
  String get enterPrice => 'Entrer le prix';

  @override
  String get price => 'Prix';

  @override
  String get priceRequired => 'Le prix est requis';

  @override
  String get pleaseEnterValidPrice => 'Veuillez entrer un prix valide';

  @override
  String get priceGreaterThanZero => 'Le prix doit être supérieur à 0';

  @override
  String get errorFetchingCategories => 'Erreur lors de la récupération des catégories';

  @override
  String get sizesAndStock => 'Tailles et Stock';

  @override
  String get noSizesAdded => 'Aucune taille ajoutée pour le moment.';

  @override
  String get pleaseAddColorsFirst => 'Veuillez d\'abord ajouter des couleurs pour gérer les variantes.';

  @override
  String get manageStockAndSizes => 'Gérer le Stock et les Tailles';

  @override
  String get preview => 'Aperçu';

  @override
  String get productAddedSuccessfully => 'Produit ajouté avec succès';

  @override
  String get productEditedSuccessfully => 'Produit modifié avec succès';

  @override
  String get addProduct => 'Ajouter un produit';

  @override
  String get stock => 'Stock';

  @override
  String get number => 'Nombre';

  @override
  String get category => 'Catégorie';

  @override
  String get areYouSureToDeleteProduct => 'Êtes-vous sûr de vouloir supprimer ce produit ? Cette action est irréversible.';

  @override
  String get productDeletedSuccessfully => 'Produit supprimé avec succès';

  @override
  String get deleteProduct => 'Supprimer le produit';

  @override
  String get yourWishlistIsEmpty => 'Votre liste de souhaits est vide';

  @override
  String get wishlistEmptyMessage => 'Il semble que vous n\'ayez encore rien ajouté à votre liste de souhaits. Allons trouver quelque chose que vous aimerez !';

  @override
  String get noItemsMatchSearch => 'Aucun article ne correspond à votre recherche';

  @override
  String get itemAddedToCart => 'Article ajouté au panier !';

  @override
  String get itemRemovedFromCart => 'Article retiré du panier';

  @override
  String get productNotFound => 'Produit non trouvé';

  @override
  String get productNotFoundMessage => 'Désolé, ce produit n\'est plus disponible. Allons trouver autre chose que vous aimerez !';

  @override
  String get orderSummary => 'Résumé de la commande';

  @override
  String get discount => 'Remise';

  @override
  String get promoCode => 'Code promo';

  @override
  String get apply => 'Appliquer';

  @override
  String get cartItemRemovedMsg => 'Désolé, cette option vient de s\'épuiser et a été retirée de votre panier';

  @override
  String get wishlistItemRemovedMsg => 'Désolé, ce produit n\'est plus disponible et a été retiré de votre liste de souhaits';

  @override
  String get outOfStock => 'Rupture de stock';

  @override
  String get paymentMethod => 'Mode de paiement';

  @override
  String get payOnDelivery => 'Paiement à la livraison';

  @override
  String get payOnDeliverySubtitle => 'Payez en espèces à la réception';

  @override
  String get allOrdersAdmin => 'Toutes les commandes (Admin)';

  @override
  String get noOrdersYet => 'Pas encore de commandes';

  @override
  String orderNumber(Object orderId) {
    return 'Commande #$orderId';
  }

  @override
  String get userLabel => 'Utilisateur: ';

  @override
  String itemsCount(Object count) {
    return '$count Articles';
  }

  @override
  String get totalLabel => 'Total: ';

  @override
  String get changeStatus => 'Changer le statut';

  @override
  String get statusPending => 'En attente';

  @override
  String get statusProcessing => 'En cours';

  @override
  String get statusShipped => 'Expédié';

  @override
  String get statusDelivered => 'Livré';

  @override
  String get statusCancelled => 'Annulé';
}

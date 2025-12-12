// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get test => 'Prueba';

  @override
  String get hello => 'Hola';

  @override
  String get welcome => 'Bienvenido';

  @override
  String userName(Object name) {
    return 'Nombre';
  }

  @override
  String get discountNewArrivalTitle => '20% de Descuento en Nuevos Productos';

  @override
  String get discountNewArrivalDescription => 'Descubre descuentos increíbles en nuestra última colección. Obtén un 20% de descuento en todos los productos recién llegados.';

  @override
  String get takeAdvantageShoppingTitle => 'Aprovecha la Oferta de Compra';

  @override
  String get takeAdvantageShoppingDescription => 'No te pierdas las ofertas exclusivas. Ahorra más en tus artículos favoritos con ofertas especiales.';

  @override
  String get allTypesOffersTitle => 'Todo tipo de ofertas a tu alcance';

  @override
  String get allTypesOffersDescription => 'Navega por varias categorías y encuentra las mejores ofertas que se adapten a tus necesidades y preferencias.';

  @override
  String get welcomeTitle => '¡Bienvenido!';

  @override
  String get welcomeDescription => 'Por favor, inicia sesión o regístrate para continuar en nuestra app';

  @override
  String get emailTitle => 'Correo electrónico';

  @override
  String get passwordTitle => 'Contraseña';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get signInTitle => 'Ingresar';

  @override
  String get orTitle => 'o';

  @override
  String get continueWithGoogleTitle => 'Continuar con Google';

  @override
  String get continueWithGoogleDescription => 'Inicio de sesión rápido y seguro con tu cuenta de Google';

  @override
  String get forgotPasswordTitle => '¿Olvidaste tu contraseña?';

  @override
  String get dontHaveAccountTitle => '¿No tienes una cuenta?';

  @override
  String get alreadyAUserTitle => '¿Ya eres usuario?';

  @override
  String get signUpTitle => 'Registrarse';

  @override
  String get loginFailedTitle => 'Error de inicio de sesión';

  @override
  String get loginFailedDescription => 'Correo o contraseña inválidos. Inténtalo de nuevo';

  @override
  String get loginSuccessTitle => 'Inicio de sesión exitoso';

  @override
  String get loginSuccessDescription => '¡Bienvenido de nuevo! Redirigiendo a la pantalla de inicio';

  @override
  String get signUpDescription => 'Crear una nueva cuenta';

  @override
  String get userNameTitle => 'Nombre de usuario';

  @override
  String get confirmPasswordTitle => 'Confirmar contraseña';

  @override
  String get emailEmptyTitle => 'Correo requerido';

  @override
  String get emailEmptyDescription => 'Por favor, introduce tu correo';

  @override
  String get emailInvalidDescription => 'Por favor, introduce una dirección de correo válida';

  @override
  String get nameEmptyDescription => 'El nombre es obligatorio';

  @override
  String get nameTooShortDescription => 'El nombre es demasiado corto';

  @override
  String get passwordEmptyDescription => 'Por favor, introduce tu contraseña';

  @override
  String get passwordTooShortDescription => 'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordWeakDescription => 'La contraseña debe contener mayúsculas, minúsculas y un número';

  @override
  String get pleaseVerifyYourEmail => 'Por favor, verifica tu correo primero';

  @override
  String get googleSignInCanceledDescription => 'Inicio de sesión cancelado';

  @override
  String get googleNetworkErrorDescription => 'Problema de conexión de red';

  @override
  String get googleSignInFailedDescription => 'Fallo en el inicio de sesión';

  @override
  String get googleConfigErrorDescription => 'Error de configuración de Google Sign-In';

  @override
  String get googleUnexpectedErrorDescription => 'Ocurrió un error inesperado';

  @override
  String get emailAlreadyInUseDescription => 'El correo ya está registrado';

  @override
  String get invalidEmailDescription => 'Dirección de correo inválida';

  @override
  String get operationNotAllowedDescription => 'Método de inicio de sesión deshabilitado';

  @override
  String get weakPasswordDescription => 'Contraseña demasiado débil';

  @override
  String get userDisabledDescription => 'Cuenta deshabilitada';

  @override
  String get userNotFoundDescription => 'Usuario no encontrado';

  @override
  String get wrongPasswordDescription => 'Contraseña incorrecta';

  @override
  String get invalidCredentialDescription => 'Credenciales inválidas';

  @override
  String get networkRequestFailedDescription => 'Conexión fallida';

  @override
  String get invalidVerificationCodeDescription => 'Código de verificación inválido';

  @override
  String get invalidVerificationIdDescription => 'ID de verificación inválido';

  @override
  String get tooManyRequestsDescription => 'Demasiadas solicitudes, intenta más tarde';

  @override
  String get internalErrorDescription => 'Ocurrió un error interno';

  @override
  String get accountExistsWithDifferentCredentialDescription => 'La cuenta existe con un inicio de sesión diferente';

  @override
  String get credentialAlreadyInUseDescription => 'Credenciales usadas en otro lugar';

  @override
  String get defaultAuthErrorDescription => 'Ocurrió un error inesperado';

  @override
  String get passwordMustMatch => 'Las contraseñas no coinciden';

  @override
  String get resetPassword => 'Restablecer contraseña';

  @override
  String get resetPasswordLabel => 'Ingresa el correo asociado a tu cuenta y te enviaremos un correo con instrucciones para restablecer tu contraseña';

  @override
  String get sendInstruction => 'Enviar instrucciones';

  @override
  String get forgotPassword => '¿Olvidaste la contraseña?';

  @override
  String get reset => 'Restablecer';

  @override
  String get expiredActionCodeDescription => 'El enlace ha caducado. Por favor solicita uno nuevo.';

  @override
  String get invalidActionCodeDescription => 'El enlace es inválido. Por favor solicita uno nuevo.';

  @override
  String get emailVerifiedTitle => '¡Correo verificado!';

  @override
  String get emailVerifiedSubtitle => 'Tu cuenta ahora está activa y lista para usar. Gracias por unirte a nosotros.';

  @override
  String get continueToSignInButton => 'Continuar al inicio de sesión';

  @override
  String get verificationFailedTitle => 'Verificación fallida';

  @override
  String get backToSignInButton => 'Volver al inicio de sesión';

  @override
  String get signin_success => 'Sesión iniciada con éxito';

  @override
  String get check_email_activation => 'Por favor revisa tu correo para activar tu cuenta.';

  @override
  String get forget_password_sent => 'Enviado con éxito';

  @override
  String get something_went_wrong => 'Algo salió mal.';

  @override
  String get close => 'Cerrar';

  @override
  String get login_success => 'Sesión iniciada con éxito';

  @override
  String get create_new_password => 'Crear nueva contraseña';

  @override
  String get password_changed_success => 'Contraseña cambiada con éxito';

  @override
  String get confirm => 'Confirmar';

  @override
  String get invalid_or_expired_link => 'El enlace es inválido, ha caducado o ya ha sido usado. Por favor solicita uno nuevo.';

  @override
  String get unexpected_error => 'Ocurrió un error inesperado. Por favor intenta de nuevo.';

  @override
  String get home => 'Inicio';

  @override
  String get categories => 'Categorías';

  @override
  String get cart => 'Carrito';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get profile => 'Perfil';

  @override
  String get search => 'Buscar';

  @override
  String get emptyCategories => 'No se encontraron categorías';

  @override
  String get couldNotLoadCategories => 'No se pudieron cargar las categorías';

  @override
  String get defaultError => 'Ocurrió un error inesperado.';

  @override
  String get adminDashboard => 'Panel de Admin';

  @override
  String get activeEditingMode => 'Modo de Edición Activo';

  @override
  String get viewAsCustomer => 'Ver como Cliente';

  @override
  String get personalDetails => 'Detalles Personales';

  @override
  String get myOrders => 'Mis Pedidos';

  @override
  String get wishlist => 'Lista de Deseos';

  @override
  String get shippingAddress => 'Dirección de Envío';

  @override
  String get myCard => 'Mi Tarjeta';

  @override
  String get settings => 'Ajustes';

  @override
  String get language => 'Idioma';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get helpCenter => 'Centro de Ayuda';

  @override
  String get english => 'Inglés';

  @override
  String get emptyCartTitle => 'Tu carrito está vacío';

  @override
  String get emptyCartSubtitle => 'Parece que aún no has añadido nada a tu carrito. ¡Vamos a buscar algo que te encante!';

  @override
  String get continueShopping => 'Seguir comprando';

  @override
  String get addtocard => 'Añadir al Carrito';

  @override
  String get processtocheckout => 'Proceder al Pago';

  @override
  String get mycart => 'Mi Carrito';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get shipping => 'Envío';

  @override
  String get total => 'Total';

  @override
  String get items => 'artículos';

  @override
  String get review => 'Reseña';

  @override
  String get availableinstock => 'Disponible en stock';

  @override
  String get description => 'Descripción';

  @override
  String get reviewsHeader => 'Reseñas de Clientes';

  @override
  String get reviewsLoadingError => 'Algo salió mal. Por favor intenta de nuevo.';

  @override
  String get noReviewsYet => 'Aún no hay reseñas. ¡Sé el primero en compartir tu opinión!';

  @override
  String get addReviewTitle => 'Escribir una Reseña';

  @override
  String get experienceHint => '¿Cómo fue tu experiencia con este producto?';

  @override
  String get postButton => 'Publicar';

  @override
  String get errorHappened => '¡Ocurrió un error!';

  @override
  String get reviews => 'Reseñas';

  @override
  String get size => 'Talla';

  @override
  String get addToCart => 'Añadir al carrito';

  @override
  String get removeFromCart => 'Eliminar del carrito';

  @override
  String get notAvailable => 'No disponible';

  @override
  String get noAvailableSizes => 'No hay tallas disponibles';

  @override
  String get noAvailableColors => 'No hay colores disponibles';

  @override
  String get productAddedToCart => 'Producto añadido al carrito';

  @override
  String get productRemovedFromCart => 'Producto eliminado del carrito';

  @override
  String get shippingAddresses => 'Direcciones de Envío';

  @override
  String get mainAddress => 'Dirección Principal';

  @override
  String get noMainAddress => 'Sin Dirección Principal';

  @override
  String get dragAnAddress => 'Arrastra una dirección hacia arriba para establecerla como principal.';

  @override
  String get otherAddresses => 'Otras Direcciones';

  @override
  String get setMain => 'Establecer Principal';

  @override
  String get delete => 'Eliminar';

  @override
  String get addNewAddress => 'Añadir Nueva Dirección';

  @override
  String get tapToAdd => 'Toca para añadir';

  @override
  String get swipeToManage => 'Desliza para gestionar';

  @override
  String get street => 'Calle';

  @override
  String get city => 'Ciudad';

  @override
  String get phoneNumber => 'Número de Teléfono';

  @override
  String get country => 'País';

  @override
  String get addAddress => 'Añadir Dirección';

  @override
  String get addressAddedSuccessfully => 'Dirección añadida con éxito';

  @override
  String get streetEmptyDescription => 'La calle no puede estar vacía.';

  @override
  String get streetTooShortDescription => 'La calle es demasiado corta, debe tener al menos 5 caracteres.';

  @override
  String get cityEmptyDescription => 'La ciudad no puede estar vacía.';

  @override
  String get cityTooShortDescription => 'La ciudad es demasiado corta, debe tener al menos 2 caracteres.';

  @override
  String get countryEmptyDescription => 'El país no puede estar vacío.';

  @override
  String get countryTooShortDescription => 'El país es demasiado corto, debe tener al menos 2 caracteres.';

  @override
  String get phoneEmptyDescription => 'El número de teléfono no puede estar vacío.';

  @override
  String get phoneInvalidDescription => 'Por favor introduce un número de teléfono válido.';

  @override
  String get phoneLengthDescription => 'El número de teléfono debe tener entre 8 y 15 dígitos.';

  @override
  String get uploadImage => 'Subir Imagen';

  @override
  String get name => 'Nombre';

  @override
  String get email => 'Correo';

  @override
  String get logOut => 'Cerrar Sesión';

  @override
  String get priceRange => 'Rango de Precios';

  @override
  String get sortBy => 'Ordenar Por';

  @override
  String get rating => 'Valoración';

  @override
  String get applyNow => 'Aplicar Ahora';

  @override
  String get noProductsFound => 'No se encontraron productos';

  @override
  String get filteredProducts => 'Productos Filtrados';

  @override
  String get checkout => 'Pago';

  @override
  String get deliveryAddress => 'Dirección de Entrega';

  @override
  String get products => 'Productos';

  @override
  String get placeOrder => 'Realizar Pedido';

  @override
  String get selectDeliveryAddress => 'Seleccionar Dirección de Entrega';

  @override
  String get noAddressFound => 'No se encontró dirección';

  @override
  String get pleaseAddAddress => 'Por favor añade una dirección para continuar.';

  @override
  String get orderPlacedSuccessfully => '¡Pedido Realizado!';

  @override
  String get orderSuccessSubtitle => 'Tu pedido será entregado pronto.\n¡Gracias por comprar con nosotros!';

  @override
  String get backToHome => 'Volver al Inicio';

  @override
  String get trackYourOrder => 'Rastrea tu Pedido';

  @override
  String get orderFailedError => 'Algo salió mal, por favor intenta de nuevo.';

  @override
  String get nothingFound => 'Nada Encontrado';

  @override
  String emptyCategoryDescription(Object categoryName) {
    return 'No pudimos encontrar productos en la categoría \'$categoryName\' en este momento. Intenta volver más tarde o explora otras categorías.';
  }

  @override
  String get addCategory => 'Añadir Nueva Categoría';

  @override
  String get editCategory => 'Editar Categoría';

  @override
  String get categoryName => 'Nombre de la Categoría';

  @override
  String get enterCategoryName => 'Introduce nombre de categoría';

  @override
  String get isActive => 'Está Activo';

  @override
  String get savedSuccessfully => 'Guardado con éxito';

  @override
  String get fillAllFields => 'Por favor completa todos los campos requeridos';

  @override
  String get reorderCategories => 'Reordenar Categorías';

  @override
  String get saveChanges => 'Guardar Cambios';

  @override
  String get areYouSureToSaveCategoryOrder => '¿Estás seguro de que quieres guardar el nuevo orden de categorías?';

  @override
  String get categoryOrderUpdatedSuccessfully => 'Orden de categorías actualizado con éxito';

  @override
  String get deleteCategory => 'Eliminar Categoría';

  @override
  String get areYouSureToDeleteCategory => '¿Estás seguro de que quieres eliminar esta categoría? Esta acción no se puede deshacer.';

  @override
  String get categoryDeletedSuccessfully => 'Categoría eliminada con éxito';

  @override
  String get categorySavedSuccessfully => 'Categoría guardada con éxito';

  @override
  String get newChatRequest => 'Nueva solicitud de chat';

  @override
  String get accept => 'Aceptar';

  @override
  String get online => 'En línea';

  @override
  String get offline => 'Desconectado';

  @override
  String get typing => 'escribiendo...';

  @override
  String get noConnection => 'Sin Conexión';

  @override
  String get sayHi => '¡Di hola!';

  @override
  String get typeMessage => 'Escribe un mensaje...';

  @override
  String get searchByEmail => 'Busca por correo para iniciar un nuevo chat';

  @override
  String get chats => 'Chats';

  @override
  String get newUsers => 'Nuevos Usuarios';

  @override
  String get error => 'Error';

  @override
  String get noNewUsersFound => 'No se encontraron nuevos usuarios';

  @override
  String get startNewChat => 'Iniciar un nuevo chat';

  @override
  String get messages => 'Mensajes';

  @override
  String get chatsTab => 'Chats';

  @override
  String get requestsTab => 'Solicitudes';

  @override
  String get justNow => 'Ahora mismo';

  @override
  String secondsAgo(Object seconds) {
    return 'hace ${seconds}s';
  }

  @override
  String minutesAgo(Object minutes) {
    return 'hace ${minutes}m';
  }

  @override
  String hoursAgo(Object hours) {
    return 'hace ${hours}h';
  }

  @override
  String get yesterday => 'Ayer';

  @override
  String daysAgo(Object days) {
    return 'hace ${days}d';
  }

  @override
  String get noChatsYet => 'Aún no hay chats';

  @override
  String get noRequestsYet => 'Aún no hay solicitudes';

  @override
  String get youRestricted => 'Has restringido a este usuario';

  @override
  String get youRestrictedBy => 'Estás restringido por este usuario';

  @override
  String get moveToChats => 'Desbloquear y mover a chats';

  @override
  String get restrictedTab => 'Bloqueados';

  @override
  String get noRestrictedYet => 'No hay usuarios bloqueados';

  @override
  String get sendTo => 'Enviar a...';

  @override
  String get shareToOtherApps => 'Compartir en otras apps';

  @override
  String get moveToRequests => 'Mover a Solicitudes';

  @override
  String get moveToRestricted => 'Mover a restringidos';

  @override
  String get areYouSureToLogout => '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String failedToLogout(Object errorMessage) {
    return 'Fallo al cerrar sesión: \'$errorMessage\'';
  }

  @override
  String get pleaseEnterUrl => 'Por favor introduce una URL';

  @override
  String get invalidUrl => 'URL inválida';

  @override
  String get pasteImagesUrl => 'Pegar URLs de imágenes';

  @override
  String get save => 'Guardar';

  @override
  String get select => 'Seleccionar';

  @override
  String get addSize => 'Añadir talla';

  @override
  String get addNumber => 'Añadir número';

  @override
  String get addStock => 'Añadir stock';

  @override
  String get selectSize => 'Seleccionar talla';

  @override
  String get selectNumber => 'Seleccionar número';

  @override
  String get quantity => 'Cantidad';

  @override
  String get enterQuantity => 'Introducir cantidad';

  @override
  String get choose => 'Elegir...';

  @override
  String get add => 'Añadir';

  @override
  String get edit => 'Editar';

  @override
  String get addImageFrom => 'Añadir imagen desde';

  @override
  String get gallery => 'Galería';

  @override
  String get urlLink => 'Enlace URL';

  @override
  String get productThumbnail => 'Miniatura del producto';

  @override
  String get mainImage => 'Imagen principal (Portada)';

  @override
  String get editProduct => 'Editar Producto';

  @override
  String get productColors => 'Colores del Producto';

  @override
  String get addNewColor => 'Añadir Nuevo Color';

  @override
  String get enterProductName => 'Nombre del Producto';

  @override
  String get productNameRequired => 'El nombre del producto es obligatorio';

  @override
  String get productNameMinLength => 'El nombre del producto debe tener al menos 3 caracteres';

  @override
  String get enterSubTitle => 'Subtítulo del producto';

  @override
  String get subTitle => 'Subtítulo';

  @override
  String get subtitleRequired => 'El subtítulo es obligatorio';

  @override
  String get subtitleMinLength => 'El subtítulo debe tener al menos 2 caracteres';

  @override
  String get enterDescription => 'Descripción del Producto';

  @override
  String get descriptionRequired => 'La descripción es obligatoria';

  @override
  String get descriptionMinLength => 'La descripción debe tener al menos 10 caracteres';

  @override
  String get enterPrice => 'Introducir Precio';

  @override
  String get price => 'Precio';

  @override
  String get priceRequired => 'El precio es obligatorio';

  @override
  String get pleaseEnterValidPrice => 'Por favor introduce un precio válido';

  @override
  String get priceGreaterThanZero => 'El precio debe ser mayor a 0';

  @override
  String get errorFetchingCategories => 'Error al obtener categorías';

  @override
  String get sizesAndStock => 'Tallas y Stock';

  @override
  String get noSizesAdded => 'Aún no se han añadido tallas.';

  @override
  String get pleaseAddColorsFirst => 'Por favor añade colores primero para gestionar variantes.';

  @override
  String get manageStockAndSizes => 'Gestionar Stock y Tallas';

  @override
  String get preview => 'Vista Previa';

  @override
  String get productAddedSuccessfully => 'Producto añadido con éxito';

  @override
  String get productEditedSuccessfully => 'Producto editado con éxito';

  @override
  String get addProduct => 'Añadir Producto';

  @override
  String get stock => 'Stock';

  @override
  String get number => 'Número';

  @override
  String get category => 'Categoría';

  @override
  String get areYouSureToDeleteProduct => '¿Estás seguro de que quieres eliminar este producto? Esta acción no se puede deshacer.';

  @override
  String get productDeletedSuccessfully => 'Producto eliminado con éxito';

  @override
  String get deleteProduct => 'Eliminar Producto';

  @override
  String get yourWishlistIsEmpty => 'Tu lista de deseos está vacía';

  @override
  String get wishlistEmptyMessage => 'Parece que aún no has añadido nada a tu lista de deseos. ¡Vamos a buscar algo que te encante!';

  @override
  String get noItemsMatchSearch => 'No hay artículos que coincidan con tu búsqueda';

  @override
  String get itemAddedToCart => '¡Artículo añadido al carrito!';

  @override
  String get itemRemovedFromCart => 'Artículo eliminado del carrito';

  @override
  String get productNotFound => 'Producto no encontrado';

  @override
  String get productNotFoundMessage => 'Lo sentimos, este producto ya no está disponible. ¡Vamos a buscar algo más que te encante!';

  @override
  String get orderSummary => 'Resumen del Pedido';

  @override
  String get discount => 'Descuento';

  @override
  String get promoCode => 'Código promocional';

  @override
  String get apply => 'Aplicar';

  @override
  String get cartItemRemovedMsg => 'Lo siento, esta opción se acaba de agotar y se eliminó de tu carrito';

  @override
  String get wishlistItemRemovedMsg => 'Lo siento, este producto ya no está disponible y se eliminó de tu lista de deseos';

  @override
  String get outOfStock => 'Agotado';

  @override
  String get paymentMethod => 'Método de pago';

  @override
  String get payOnDelivery => 'Pago contra entrega';

  @override
  String get payOnDeliverySubtitle => 'Paga en efectivo al recibir';

  @override
  String get allOrdersAdmin => 'Todos los pedidos (Admin)';

  @override
  String get noOrdersYet => 'Aún no hay pedidos';

  @override
  String orderNumber(Object orderId) {
    return 'Pedido #$orderId';
  }

  @override
  String get userLabel => 'Usuario: ';

  @override
  String itemsCount(Object count) {
    return '$count Artículos';
  }

  @override
  String get totalLabel => 'Total: ';

  @override
  String get changeStatus => 'Cambiar estado';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusProcessing => 'Procesando';

  @override
  String get statusShipped => 'Enviado';

  @override
  String get statusDelivered => 'Entregado';

  @override
  String get statusCancelled => 'Cancelado';
}

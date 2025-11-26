import 'package:batrina/controllers/cubit/chat/get_messages_cubit/get_messages_cubit.dart';
import 'package:batrina/controllers/provider/local_chats_provider.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/models/chat_page_models/message_model.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/product/widgets/heart.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductImagesSlider extends StatefulWidget {
  const ProductImagesSlider({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductImagesSlider> createState() => _ProductImagesSliderState();
}

class _ProductImagesSliderState extends State<ProductImagesSlider> {
  final PageController _pageController = PageController();

  void _moveRight() {
    if (!_pageController.hasClients || _pageController.page == null) return;
    if (_pageController.page! < 2) {
      _pageController.animateToPage(
        (_pageController.page! + 1).toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _moveLeft() {
    if (!_pageController.hasClients || _pageController.page == null) return;
    if (_pageController.page! != 0) {
      _pageController.animateToPage(
        (_pageController.page! + -1).toInt(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  String getCompositeChatId(String userId1, String userId2) {
    if (userId1.compareTo(userId2) > 0) {
      return '${userId2}_$userId1';
    } else {
      return '${userId1}_$userId2';
    }
  }

  void _shareProduct() {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    ProductProvider productProvider = context.read<ProductProvider>();
    final loc = AppLocalizations.of(context);
    showModalBottomSheet(
      backgroundColor: theme.scaffoldBackgroundColor,
      context: context,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      isScrollControlled: true,

      builder: (context) {
        return BlocProvider(
          create: (context) => GetMessagesCubit()..getMessages(),
          child: BlocBuilder<GetMessagesCubit, GetMessagesState>(
            builder: (context, state) {
              return Container(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 50.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),

                    CustomText(
                      data: loc!.sendTo,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 20.h),

                    _buildShareList(context, state, appColors, productProvider),

                    SizedBox(height: 20.h),
                    CustomElevatedButton(
                      onPressed: () {},
                      buttonChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            data: loc.shareToOtherApps,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: theme.scaffoldBackgroundColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildShareList(
    BuildContext context,
    GetMessagesState state,
    AppColorTheme appColors,
    ProductProvider productProvider,
  ) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    if (state is! GetMessagesSuccess) {
      return SizedBox(
        height: 120.h,
        child: Center(
          child: CupertinoActivityIndicator(color: theme.primaryColor),
        ),
      );
    }
    for (var p in state.conversations) {
      print(p.me.conversationState);
    }
    final acceptedList = state.conversations
        .where((element) => element.me.conversationState == 'accepted')
        .toList();
    for (var p in acceptedList) {
      print(p.otherUser.name);
    }

    return ChangeNotifierProvider(
      create: (context) => LocalChatController(),
      child: SizedBox(
        height: 120.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            ParticipantData? otherUser;
            if (index < acceptedList.length) {
              otherUser = acceptedList[index].otherUser;
            }

            return SizedBox(
              width: 80.w,
              child: GestureDetector(
                onTap: () async {
                  if (index < acceptedList.length) {
                    final String myId = FirebaseAuth.instance.currentUser!.uid;
                    final String otherUserId = acceptedList[index].participants
                        .firstWhere((id) => id != myId);

                    final String chatId = getCompositeChatId(myId, otherUserId);
                    await context.push(
                      '/chatScreen/$chatId/$otherUserId',
                      extra: {
                        "anotherUserModel": UserModel(
                          id: otherUserId,
                          name: otherUser!.name,
                          email: otherUser.email,
                          role: otherUser.role,
                          picture: otherUser.photoUrl,
                        ),
                        'initialMessage': MessageModel(
                          id: "",
                          senderId: "",
                          text: productProvider.productModel.name,
                          type: "image",
                          pId: productProvider.productModel.id,
                          imageUrl: productProvider.productModel.thumbnail,
                          readBy: [],
                        ),
                      },
                    );
                    context.read<GetMessagesCubit>().getMessages();
                  } else {
                    LocalChatController localChatController = context
                        .read<LocalChatController>();
                    localChatController.updateList(state.conversations);
                    await context.pushNamed(
                      AppRoutes.chatSearchScreen,
                      extra: {
                        'provider': localChatController,
                        'initialMessage': MessageModel(
                          id: "",
                          senderId: "",
                          text: productProvider.productModel.name,
                          type: "image",
                          pId: productProvider.productModel.id,
                          imageUrl: productProvider.productModel.thumbnail,
                          readBy: [],
                        ),
                        'initialList': state.conversations,
                      },
                    );
                    context.read<GetMessagesCubit>().getMessages();
                  }
                },
                child: index < acceptedList.length
                    ? Column(
                        children: [
                          otherUser!.photoUrl != null &&
                                  otherUser.photoUrl!.isNotEmpty
                              ? SizedBox(
                                  width: 60.w,
                                  height: 60.h,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(100.r),
                                    clipBehavior: Clip.antiAlias,
                                    child: BuildDynamicImage(
                                      imageUrl: otherUser.photoUrl!,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 60.w,
                                  height: 60.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadiusGeometry.circular(
                                      100.r,
                                    ),
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                        "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          SizedBox(height: 8.h),

                          CustomText(
                            data: otherUser.name,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            maxLines: 1,
                            fontFamily: AppFonts.englishFontFamily,
                          ),
                          SizedBox(height: 8.h),

                          CustomText(
                            data: otherUser.email,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: appColors.secondaryText,
                            maxLines: 1,
                            fontFamily: AppFonts.englishFontFamily,
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusGeometry.circular(
                                100.r,
                              ),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),

                          CustomText(
                            data: loc!.startNewChat,
                            textAlign: TextAlign.center,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            maxLines: 2,
                            color: theme.primaryColor,
                            forceStrutHeight: true,
                          ),
                        ],
                      ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(width: 15.w),
          itemCount: acceptedList.length + 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          reverseDuration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: PageView(
            key: ValueKey(productProvider.currentColorName),
            controller: _pageController,
            children: List.generate(productProvider.currentSliderImage.length, (
              index,
            ) {
              return BuildDynamicImage(
                imageUrl: productProvider.currentSliderImage[index],
              );
            }),
          ),
        ),
        Positioned(
          left: 25.w,
          top: 35.h,
          right: 25.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BackArrow(),
              if (!productProvider.preview)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () => _shareProduct(),
                      child: Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.primaryColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.share_sharp,
                            color: theme.scaffoldBackgroundColor,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    if (FireBaseFireStore.currentUser?.role == "admin")
                      GestureDetector(
                        onTap: () => context.pushNamed(
                          AppRoutes.editProductScreen,
                          extra: productProvider.productModel.copyWith(),
                        ),
                        child: Container(
                          width: 35.w,
                          height: 35.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primaryColor,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              color: theme.scaffoldBackgroundColor,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
        Positioned.fill(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0.w),
              child: productProvider.currentSliderImage.length > 1
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _moveLeft,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: appColors.secondaryText,
                            size: 18.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: _moveRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: appColors.secondaryText,
                            size: 18.sp,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 36.h,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: productProvider.currentSliderImage.length > 1
                ? SmoothPageIndicator(
                    controller: _pageController,
                    count: productProvider.currentSliderImage.length,
                    effect: ExpandingDotsEffect(
                      spacing: 8.0,
                      radius: 10.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.fill,
                      strokeWidth: 1.5,
                      dotColor: appColors.dividerColor!,
                      activeDotColor: theme.primaryColor,
                    ),
                    onDotClicked: (index) {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  )
                : const SizedBox(),
          ),
        ),
        Positioned(
          right: 25.w,
          bottom: 38.h,
          child: Heart(productModel: widget.productModel),
        ),
      ],
    );
  }
}

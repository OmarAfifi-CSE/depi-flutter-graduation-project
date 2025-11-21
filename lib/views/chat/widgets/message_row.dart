import 'package:batrina/controllers/provider/local_chats_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/models/chat_page_models/message_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/number_localizer.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/chat/users_state.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_down_button/pull_down_button.dart';

class MessageRow extends StatelessWidget {
  const MessageRow({
    super.key,
    required this.conversationModel,
    this.messageModel,
    this.openRestrictOption = false,
  });
  final ConversationModel conversationModel;
  final MessageModel? messageModel;
  final bool openRestrictOption;
  String getCompositeChatId(String userId1, String userId2) {
    if (userId1.compareTo(userId2) > 0) {
      return '${userId2}_$userId1';
    } else {
      return '${userId1}_$userId2';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final String myId = FirebaseAuth.instance.currentUser!.uid;
    final loc = AppLocalizations.of(context);
    final String otherUserId = conversationModel.participants.firstWhere(
      (id) => id != myId,
    );
    return PullDownButton(
      itemBuilder: (context) => [
        PullDownMenuItem(
          title: loc!.moveToRestricted,
          icon: Icons.visibility_off_outlined,
          iconColor: Colors.red,
          itemTheme: PullDownMenuItemTheme(
            textStyle: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
              fontFamily: AppFonts.mainFontName,
            ),
          ),
          onTap: () {
            FirebaseFirestore.instance
                .collection('conversations')
                .doc(getCompositeChatId(myId, otherUserId))
                .update({
                  'participantsData.${FirebaseAuth.instance.currentUser!.uid}.conversationState':
                      'restricted',
                });
          },
        ),
      ],
      buttonBuilder: (context, showMenu) {
        return Center(
          child: Material(
            color: theme.scaffoldBackgroundColor,

            borderRadius: BorderRadius.circular(4.r),

            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onLongPress: openRestrictOption ? showMenu : null,
              onTap: () {
                UserModel userModel = UserModel(
                  id: otherUserId,
                  role: conversationModel.otherUser.role,
                  name: conversationModel.otherUser.name,
                  email: conversationModel.otherUser.email,
                  picture: conversationModel.otherUser.photoUrl,
                );

                final String chatId = getCompositeChatId(myId, otherUserId);

                UserStates userStates = UserStates.fromConvModel(
                  conversationModel,
                );
                LocalChatController localChatController = context
                    .read<LocalChatController>();

                context.push(
                  '/chatScreen/$chatId/$otherUserId',
                  extra: {
                    "anotherUserModel": userModel,
                    "userStates": userStates,
                    'initialMessage': messageModel,
                    'provider': localChatController,
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.h, vertical: 5.h),
                child: SizedBox(
                  height: 60.h,
                  child: Row(
                    children: [
                      conversationModel.otherUser.photoUrl != null &&
                              conversationModel.otherUser.photoUrl!.isNotEmpty
                          ? SizedBox(
                              width: 60.w,
                              height: 60.h,
                              child: Material(
                                borderRadius: BorderRadius.circular(100.r),
                                clipBehavior:
                                    Clip.antiAlias, // This is the key property
                                child: BuildDynamicImage(
                                  imageUrl:
                                      conversationModel.otherUser.photoUrl!,
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
                      SizedBox(width: 18.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              data: conversationModel.otherUser.name,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: AppFonts.englishFontFamily,
                            ),
                            CustomText(
                              data: conversationModel.lastMessage,
                              textAlign: TextAlign.start,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: appColors.secondaryText,
                              maxLines: 2,
                              fontFamily: AppFonts.englishFontFamily,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CustomText(
                              data: conversationModel.timeAgo(context),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              forceStrutHeight: true,
                            ),
                          ),
                          conversationModel.myUnreadCount != 0
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: Container(
                                      width: 30.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: theme.primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: CustomText(
                                        data: NumberLocalizer.formatNumber(
                                          conversationModel.myUnreadCount,
                                          Localizations.localeOf(
                                            context,
                                          ).languageCode,
                                        ),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w700,
                                        color: theme.scaffoldBackgroundColor,
                                        forceStrutHeight: true,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

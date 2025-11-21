import 'package:batrina/controllers/provider/local_chats_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/number_localizer.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/chat/widgets/message_row.dart';
import 'package:batrina/views/chat/widgets/search_field.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final myId = FirebaseAuth.instance.currentUser!.uid;

    return ChangeNotifierProvider(
      create: (context) => LocalChatController(),
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            center: CustomText(
              data: loc!.messages,
              textAlign: TextAlign.center,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            prefix: const BackArrow(),
          ),
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0.w),
          child: Builder(
            builder: (newContext) {
              return Directionality(
                textDirection: TextDirection.ltr,
                child: Column(
                  children: [
                    SizedBox(height: 30.h),
                    Hero(
                      tag: "1",
                      child: GestureDetector(
                        onTap: () {
                          final localChatController = newContext
                              .read<LocalChatController>();
                          context.pushNamed(
                            AppRoutes.chatSearchScreen,
                            extra: {'provider': localChatController},
                          );
                        },
                        child: const AbsorbPointer(child: SearchField()),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('conversations')
                            .where('participants', arrayContains: myId)
                            .orderBy('lastMessageTime', descending: true)
                            .snapshots(),
                        builder: (context, asyncSnapshot) {
                          if (asyncSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CupertinoActivityIndicator(
                                color: theme.primaryColor,
                              ),
                            );
                          }
                          if (asyncSnapshot.hasError) {
                            return Center(
                              child: CustomText(
                                data: loc.noConnection,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.secondaryText,
                              ),
                            );
                          }

                          List<ConversationModel> allConversations =
                              asyncSnapshot.data?.docs
                                  .map(
                                    (e) => ConversationModel.fromJson(e.data()),
                                  )
                                  .toList() ??
                              [];

                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (newContext.mounted) {
                              newContext.read<LocalChatController>().updateList(
                                allConversations,
                              );
                            }
                          });

                          final List<ConversationModel> acceptedChats =
                              allConversations.where((convo) {
                                return convo.me.conversationState == 'accepted';
                              }).toList();

                          final List<ConversationModel> pendingRequests =
                              allConversations.where((convo) {
                                return convo.me.conversationState ==
                                        'pending' ||
                                    convo.me.conversationState == null;
                              }).toList();
                          final List<ConversationModel> restricted =
                              allConversations.where((convo) {
                                return convo.me.conversationState ==
                                    'restricted';
                              }).toList();
                          return DefaultTabController(
                            length: restricted.isEmpty ? 2 : 3,
                            child: Column(
                              children: [
                                TabBar(
                                  labelColor: theme.primaryColor,
                                  unselectedLabelColor: appColors.secondaryText,
                                  indicatorColor: theme.primaryColor,
                                  padding: EdgeInsets.zero,
                                  labelPadding: EdgeInsets.zero,
                                  labelStyle: TextStyle(
                                    fontFamily: AppFonts.mainFontName,
                                    fontSize: 14.sp,
                                  ),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        loc.chatsTab,
                                        strutStyle: const StrutStyle(
                                          forceStrutHeight: true,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            loc.requestsTab,
                                            strutStyle: const StrutStyle(
                                              forceStrutHeight: true,
                                            ),
                                          ),
                                          if (pendingRequests.isNotEmpty) ...[
                                            SizedBox(width: 8.w),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 2.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: theme.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(12.r),
                                              ),
                                              child: CustomText(
                                                data:
                                                    NumberLocalizer.formatNumber(
                                                      pendingRequests.length,
                                                      Localizations.localeOf(
                                                        context,
                                                      ).languageCode,
                                                    ),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.sp,
                                                forceStrutHeight: true,
                                                color: theme
                                                    .scaffoldBackgroundColor,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    if (restricted.isNotEmpty)
                                      Tab(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              loc.restrictedTab,
                                              strutStyle: const StrutStyle(
                                                forceStrutHeight: true,
                                              ),
                                            ),
                                            if (restricted.isNotEmpty) ...[
                                              SizedBox(width: 8.w),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 2.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: theme.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        12.r,
                                                      ),
                                                ),
                                                child: CustomText(
                                                  data:
                                                      NumberLocalizer.formatNumber(
                                                        restricted.length,
                                                        Localizations.localeOf(
                                                          context,
                                                        ).languageCode,
                                                      ),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11.sp,
                                                  forceStrutHeight: true,
                                                  color: theme
                                                      .scaffoldBackgroundColor,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Expanded(
                                  child: TabBarView(
                                    children: [
                                      acceptedChats.isNotEmpty
                                          ? ListView.separated(
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 20.h),
                                              itemCount: acceptedChats.length,
                                              itemBuilder: (context, index) {
                                                return MessageRow(
                                                  conversationModel:
                                                      acceptedChats[index],
                                                  openRestrictOption: true,
                                                );
                                              },
                                            )
                                          : Center(
                                              child: CustomText(
                                                data: loc.noChatsYet,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: appColors.secondaryText,
                                              ),
                                            ),
                                      pendingRequests.isNotEmpty
                                          ? ListView.separated(
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 20.h),
                                              itemCount: pendingRequests.length,
                                              itemBuilder: (context, index) {
                                                return MessageRow(
                                                  conversationModel:
                                                      pendingRequests[index],
                                                  openRestrictOption: true,
                                                );
                                              },
                                            )
                                          : Center(
                                              child: CustomText(
                                                data: loc.noRequestsYet,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: appColors.secondaryText,
                                              ),
                                            ),
                                      if (restricted.isNotEmpty)
                                        ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 20.h),
                                          itemCount: restricted.length,
                                          itemBuilder: (context, index) {
                                            return MessageRow(
                                              conversationModel:
                                                  restricted[index],
                                              openRestrictOption: false,
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

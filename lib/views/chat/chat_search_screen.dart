import 'package:batrina/controllers/provider/local_chats_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/models/chat_page_models/message_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/chat/widgets/message_row.dart';
import 'package:batrina/views/chat/widgets/search_field.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ChatSearchScreen extends StatefulWidget {
  const ChatSearchScreen({super.key, this.messageModel, this.initialList});

  final MessageModel? messageModel;
  final List<ConversationModel>? initialList;
  @override
  State<ChatSearchScreen> createState() => _ChatSearchScreenState();
}

class _ChatSearchScreenState extends State<ChatSearchScreen> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => focusNode.requestFocus(),
    );
    super.initState();
  }

  void onChange(String text) {
    setState(() {});
  }

  String getCompositeChatId(String userId1, String userId2) {
    if (userId1.compareTo(userId2) > 0) {
      return '${userId2}_$userId1';
    } else {
      return '${userId1}_$userId2';
    }
  }

  Future<List<UserModel>> searchForNewUsers(
    String emailToSearch,
    List<ConversationModel> localChats,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String searchText = emailToSearch.trim().toLowerCase();

    if (searchText.isEmpty) {
      return [];
    }

    String endText = searchText + '\uf8ff';

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection("users")
        .where("email", isGreaterThanOrEqualTo: searchText)
        .where("email", isLessThanOrEqualTo: endText)
        .limit(10)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    List<UserModel> searchedUsers =
        querySnapshot.docs.map((doc) {
          return UserModel.fromJson(doc.data());
        }).toList()..removeWhere(
          (element) => element.id == FirebaseAuth.instance.currentUser!.uid,
        );
    final Set<String> existingChatUserEmails = localChats
        .map((convo) => convo.otherUser.email)
        .toSet();

    searchedUsers.removeWhere(
      (user) => existingChatUserEmails.contains(user.email),
    );

    return searchedUsers;
  }

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w),
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    children: [
                      Expanded(
                        child: Hero(
                          tag: "1",
                          child: SearchField(
                            onChanged: onChange,
                            controller: editingController,
                            focusNode: focusNode,
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {
                          if (editingController.text.trim().isNotEmpty) {
                            editingController.clear();
                            setState(() {});
                          } else {
                            context.pop();
                          }
                        },
                        child: Container(
                          width: 35.w,
                          height: 35.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: editingController.text.trim().isEmpty
                                ? theme.primaryColor
                                : Colors.red,
                          ),
                          alignment: Alignment.center,
                          child: editingController.text.trim().isNotEmpty
                              ? Icon(
                                  Icons.close,
                                  color: theme.scaffoldBackgroundColor,
                                  size: 20.w,
                                )
                              : SvgPicture.asset(
                                  AppAssets.arrowBack,
                                  fit: BoxFit.scaleDown,
                                  colorFilter: ColorFilter.mode(
                                    theme.scaffoldBackgroundColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: editingController.text.trim().isEmpty
                      ? Center(
                          child: CustomText(
                            data: loc!.searchByEmail,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.sp,
                            color: appColors.secondaryText,
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              textAlign: TextAlign.start,
                              data: loc!.chats,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: appColors.secondaryText,
                            ),
                            widget.initialList == null
                                ? Consumer<LocalChatController>(
                                    builder: (context, value, child) {
                                      List<ConversationModel> searchedList =
                                          value.conversationModels.where((
                                            element,
                                          ) {
                                            return element.otherUser.email
                                                        .toLowerCase()
                                                        .contains(
                                                          editingController.text
                                                              .trim()
                                                              .toLowerCase(),
                                                        ) &&
                                                    element
                                                            .me
                                                            .conversationState ==
                                                        'accepted' ||
                                                element.me.conversationState ==
                                                    'pending' ||
                                                element.me.conversationState ==
                                                    null;
                                          }).toList();
                                      return ListView.separated(
                                        itemCount: searchedList.length > 3
                                            ? 3
                                            : searchedList.length,
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 10.h),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return _buildChatResultItem(
                                            searchedList[index],
                                          );
                                        },
                                      );
                                    },
                                  )
                                : () {
                                    List<ConversationModel> searchedList =
                                        widget.initialList!
                                            .where(
                                              (element) => element
                                                  .otherUser
                                                  .email
                                                  .toLowerCase()
                                                  .contains(
                                                    editingController.text
                                                        .trim()
                                                        .toLowerCase(),
                                                  ),
                                            )
                                            .toList();
                                    return ListView.separated(
                                      itemCount: searchedList.length > 3
                                          ? 3
                                          : searchedList.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 10.h),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return _buildChatResultItem(
                                          searchedList[index],
                                        );
                                      },
                                    );
                                  }(),
                            SizedBox(height: 20.h),
                            CustomText(
                              data: loc.newUsers,
                              textAlign: TextAlign.start,

                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: appColors.secondaryText,
                            ),
                            SizedBox(height: 4.h),
                            widget.initialList == null
                                ? Expanded(
                                    child: Consumer<LocalChatController>(
                                      builder: (context, value, child) {
                                        return FutureBuilder<List<UserModel>>(
                                          future: searchForNewUsers(
                                            editingController.text,
                                            value.conversationModels,
                                          ),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                                      color: theme.primaryColor,
                                                    ),
                                              );
                                            }

                                            if (snapshot.hasError) {
                                              return Center(
                                                child: CustomText(
                                                  data: loc.error,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              );
                                            }

                                            if (!snapshot.hasData ||
                                                snapshot.data!.isEmpty) {
                                              return Center(
                                                child: CustomText(
                                                  data: loc.noNewUsersFound,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.sp,
                                                ),
                                              );
                                            }
                                            final List<UserModel> userResults =
                                                snapshot.data!;
                                            return ListView.separated(
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 10.h),
                                              itemCount: userResults.length,
                                              itemBuilder: (context, index) {
                                                UserModel user =
                                                    userResults[index];
                                                return _buildUserResultItem(
                                                  user,
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  )
                                : Expanded(
                                    child: FutureBuilder<List<UserModel>>(
                                      future: searchForNewUsers(
                                        editingController.text,
                                        widget.initialList!,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: CupertinoActivityIndicator(
                                              color: theme.primaryColor,
                                            ),
                                          );
                                        }

                                        if (snapshot.hasError) {
                                          return Center(
                                            child: CustomText(
                                              data: loc.error,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          );
                                        }

                                        if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return Center(
                                            child: CustomText(
                                              data: loc.noNewUsersFound,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp,
                                            ),
                                          );
                                        }
                                        final List<UserModel> userResults =
                                            snapshot.data!;
                                        return ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 10.h),
                                          itemCount: userResults.length,
                                          itemBuilder: (context, index) {
                                            UserModel user = userResults[index];
                                            return _buildUserResultItem(user);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatResultItem(ConversationModel conversation) {
    return MessageRow(
      conversationModel: conversation,
      messageModel: widget.messageModel,
    );
  }

  Widget _buildUserResultItem(UserModel user) {
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return InkWell(
      onTap: () {
        final String myId = FirebaseAuth.instance.currentUser!.uid;
        final String otherUserId = user.id;

        final String chatId = getCompositeChatId(myId, otherUserId);
        context.push(
          '/chatScreen/$chatId/$otherUserId',
          extra: {
            "anotherUserModel": user,
            'initialMessage': widget.messageModel,
          },
        );
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          height: 60.h,
          child: Row(
            children: [
              user.picture != null && user.picture!.isNotEmpty
                  ? SizedBox(
                      width: 60.w,
                      height: 60.h,
                      child: Material(
                        borderRadius: BorderRadius.circular(100.r),
                        clipBehavior:
                            Clip.antiAlias, // This is the key property
                        child: BuildDynamicImage(
                          imageUrl: user.picture ?? "",
                          // imageUrl: conversationModel.otherUser.photoUrl,
                        ),
                      ),
                    )
                  : Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(100.r),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      data: user.name,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppFonts.englishFontFamily,
                    ),
                    CustomText(
                      data: user.email,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.englishFontFamily,
                    ),
                    CustomText(
                      data: loc!.startNewChat,
                      textAlign: TextAlign.start,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      maxLines: 2,
                      color: appColors.textField,
                      forceStrutHeight: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

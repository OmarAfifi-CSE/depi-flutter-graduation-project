import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/chat_page_models/presence_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/chat/users_state.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatHeader extends StatefulWidget {
  const ChatHeader({
    super.key,
    required this.chatId,
    required this.otherId,
    required this.otherUser,
    required this.userStates,
  });
  final String chatId;
  final String otherId;
  final UserModel otherUser;
  final UserStates userStates;

  @override
  State<ChatHeader> createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  String? status;

  bool isLoading = false;
  bool isThereStream = false;

  @override
  void initState() {
    super.initState();
  }

  void _acceptChat() async {
    final myId = FirebaseAuth.instance.currentUser?.uid;
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseFirestore.instance
          .collection('conversations')
          .doc(widget.chatId)
          .set({
            'participantsData': {
              myId: {'unreadCount': 0, 'conversationState': 'accepted'},
            },
          }, SetOptions(merge: true));
    } catch (e) {
      print("Error accepting chat: $e");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('presence')
          .doc(widget.chatId)
          .collection('presence')
          .doc(widget.otherId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.exists) {
          final presence = PresenceModel.fromFirestore(snapshot.data!);
          status = presence.online ? loc!.online : loc!.offline;
          if (presence.typing) {
            status = loc.typing;
          }
        }
        return Container(
          height: 80.h,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(15.r),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: .15),
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              widget.otherUser.picture != null &&
                      widget.otherUser.picture!.isNotEmpty
                  ? SizedBox(
                      width: 60.w,
                      height: 60.h,
                      child: Material(
                        borderRadius: BorderRadius.circular(100.r),
                        clipBehavior:
                            Clip.antiAlias, // This is the key property
                        child: BuildDynamicImage(
                          imageUrl: widget.otherUser.picture!,
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
              SizedBox(width: 18.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      data: widget.otherUser.name,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 4.h),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, -0.5),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child:
                          widget.userStates.isPending ||
                              widget.userStates.isRestricted
                          ? Wrap(
                              spacing: 10.w,
                              key: const ValueKey('accept_widget'),
                              children: [
                                CustomText(
                                  data: widget.userStates.isRestricted
                                      ? loc!.youRestricted
                                      : loc!.newChatRequest,
                                  fontSize: 11.sp,
                                  color: appColors.secondaryText,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(width: 10.w),

                                InkWell(
                                  onTap: _acceptChat,
                                  child: isLoading
                                      ? CupertinoActivityIndicator(
                                          color: theme.primaryColor,
                                        )
                                      : CustomText(
                                          data: widget.userStates.isRestricted
                                              ? loc.moveToChats
                                              : loc.accept,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          color: theme.primaryColor,
                                        ),
                                ),
                              ],
                            )
                          : widget.userStates.isAnotherUserPending
                          ? const SizedBox()
                          : CustomText(
                              key: const ValueKey('status_widget'),
                              data: widget.userStates.isAnotherUserRestricted
                                  ? loc!.youRestrictedBy
                                  : (status ?? loc!.offline),
                              textAlign: TextAlign.start,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w700,
                              color: widget.userStates.isAnotherUserRestricted
                                  ? Colors.red
                                  : ((status == loc!.online ||
                                            status == loc.typing)
                                        ? Colors.green
                                        : appColors.secondaryText),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

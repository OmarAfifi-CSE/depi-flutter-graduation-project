import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/models/chat_page_models/message_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/chat/widgets/chat_header.dart';
import 'package:batrina/views/chat/widgets/message.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String otherUserId;

  final UserModel anotherUser;
  final bool isPending;
  final MessageModel? initialMessage;
  const ChatScreen({
    super.key,
    required this.chatId,
    required this.otherUserId,
    required this.anotherUser,
    required this.isPending,
    this.initialMessage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final String _myId;
  late bool isPending;
  // to avoid loading when rebuild
  late final Stream<QuerySnapshot> _messagesStream;

  bool showImage = false;

  @override
  void initState() {
    super.initState();
    isPending = widget.isPending;
    showImage = widget.initialMessage != null;
    _messagesStream = _firestore
        .collection('messages')
        .doc(widget.chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
    _myId = FirebaseAuth.instance.currentUser!.uid;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateMyPresence(true);
      _markAsRead();
    });
  }

  @override
  void dispose() {
    _updateMyPresence(false);
    _markAsRead();
    _messageController.dispose();
    super.dispose();
  }

  void _updateMyPresence(bool isOnline) {
    _firestore
        .collection('presence')
        .doc(widget.chatId)
        .collection('presence')
        .doc(_myId)
        .set({'online': isOnline, 'typing': false}, SetOptions(merge: true));
  }

  void _markAsRead() {
    _firestore
        .collection('conversations')
        .doc(widget.chatId)
        .update({
          // بنستخدم (Dot Notation) عشان نعدل قيمة جوه ماب
          'participantsData.$_myId.unreadCount': 0,
        })
        .catchError((e) {
          print("Could not mark as read (maybe new chat): $e");
        });
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty && showImage == false) {
      return;
    }

    final String messageText = _messageController.text.trim();
    _messageController.clear();

    final messageRef = _firestore
        .collection('messages')
        .doc(widget.chatId)
        .collection('messages')
        .doc();

    final convoRef = _firestore.collection('conversations').doc(widget.chatId);

    _firestore
        .runTransaction((transaction) async {
          final convoSnapshot = await transaction.get(convoRef);

          int newUnreadCount = 1;

          String finalMessageText = messageText;

          MessageModel newMessage = MessageModel(
            id: messageRef.id,
            senderId: _myId,
            text: finalMessageText,
            type: 'text',
            timestamp: null,
            readBy: [_myId],
          );

          if (convoSnapshot.exists) {
            final data = convoSnapshot.data() as Map<String, dynamic>;

            newUnreadCount =
                (data['participantsData']?[widget
                        .otherUserId]?['unreadCount'] ??
                    0) +
                1;
          }

          if (showImage == true) {
            finalMessageText = "${widget.initialMessage!.text}\n $messageText";
            newMessage = MessageModel(
              id: messageRef.id,
              senderId: _myId,
              text: finalMessageText,
              type: widget.initialMessage!.type,
              imageUrl: widget.initialMessage!.imageUrl,
              pId: widget.initialMessage!.pId,
              timestamp: null,
              readBy: [_myId],
            );

            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                showImage = false;
              });
            });
          }

          transaction.set(messageRef, newMessage.toJson());

          transaction.set(convoRef, {
            'lastMessage': finalMessageText,
            'lastMessageSenderId': _myId,
            'lastMessageTime': FieldValue.serverTimestamp(),
            'participants': [_myId, widget.otherUserId],

            'participantsData': {
              _myId: {
                'name': FireBaseFireStore.currentUser!.name,
                'photoUrl': FireBaseFireStore.currentUser?.picture,
                'email': FireBaseFireStore.currentUser!.email,
                'role': FireBaseFireStore.currentUser!.role,
                'unreadCount': 0,
                'conversationState': 'accepted',
              },
              widget.otherUserId: {
                'name': widget.anotherUser.name,
                'photoUrl': widget.anotherUser.picture,
                'email': widget.anotherUser.email,
                'role': widget.anotherUser.role,
                'unreadCount': newUnreadCount,
              },
            },
          }, SetOptions(merge: true));
        })
        .catchError((e) {
          print("---!!! Transaction Error !!!---");
          print(e.toString());
        });
  }

  void reset() {
    setState(() {
      isPending = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            prefix: BackArrow(
              additionalFun: () {
                final router = GoRouter.of(context);
                final matches =
                    router.routerDelegate.currentConfiguration.matches;

                if (matches.length < 2) {
                  return;
                }

                final previousMatch = matches[matches.length - 2];

                bool searchScreenExists = previousMatch.matchedLocation
                    .contains(AppRoutes.chatSearchScreen);
                if (searchScreenExists) {
                  context.pop();
                  context.pop();
                } else {
                  context.pop();
                }
              },
            ),
          ),
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Expanded(
                  child: Stack(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: _messagesStream,
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
                                data: loc!.noConnection,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.secondaryText,
                              ),
                            );
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: CustomText(
                                data: loc!.sayHi,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500,
                                color: appColors.secondaryText,
                              ),
                            );
                          }

                          return ShaderMask(
                            shaderCallback: (bounds) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,

                                end: Alignment.bottomCenter,

                                colors: [
                                  Colors.transparent,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                ],

                                stops: [0.0, 0.1, 0.9, 1.0],
                              ).createShader(bounds);
                            },
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 20.h),
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final msg = MessageModel.fromFirestore(
                                  snapshot.data!.docs[index],
                                );

                                bool isMe = msg.senderId == _myId;
                                return Message(isMe: isMe, messageModel: msg);
                              },
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: ChatHeader(
                          chatId: widget.chatId,
                          otherId: widget.otherUserId,
                          otherUser: widget.anotherUser,
                          isPending: isPending,
                          resetChatPage: reset,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                isPending
                    ? const SizedBox()
                    : SafeArea(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  showImage
                                      ? Container(
                                          decoration: BoxDecoration(
                                            color:
                                                theme.scaffoldBackgroundColor,
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20.r),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: theme.primaryColor
                                                    .withValues(alpha: .15),
                                                blurRadius: 10,
                                                spreadRadius: -3,
                                                offset: const Offset(0, -5),
                                              ),
                                            ],
                                          ),
                                          padding: EdgeInsets.all(10.r),
                                          child: Row(
                                            children: [
                                              widget.initialMessage?.imageUrl !=
                                                          null &&
                                                      widget
                                                          .initialMessage!
                                                          .imageUrl!
                                                          .isNotEmpty
                                                  ? SizedBox(
                                                      width: 30.w,
                                                      height: 30.h,
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12.r,
                                                            ),
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        child: BuildDynamicImage(
                                                          imageUrl:
                                                              widget
                                                                  .initialMessage
                                                                  ?.imageUrl ??
                                                              "",
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 30.w,
                                                      height: 30.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadiusGeometry.circular(
                                                              12.r,
                                                            ),
                                                        image: const DecorationImage(
                                                          image: NetworkImage(
                                                            "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                              SizedBox(width: 5.w),
                                              Expanded(
                                                child: CustomText(
                                                  textAlign: TextAlign.start,
                                                  data: widget
                                                      .initialMessage!
                                                      .text,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  maxLines: 1,
                                                  forceStrutHeight: true,
                                                  fontFamily: AppFonts
                                                      .englishFontFamily,
                                                ),
                                              ),
                                              SizedBox(width: 5.w),

                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    showImage = false;
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : const SizedBox(),
                                  SizedBox(
                                    child: TextField(
                                      controller: _messageController,
                                      maxLines: 5,
                                      minLines: 1,
                                      keyboardType: TextInputType.multiline,
                                      style: TextStyle(
                                        fontFamily: AppFonts.englishFontFamily,
                                        color: theme.primaryColor,
                                        fontSize: 14.sp,
                                      ),

                                      decoration: InputDecoration(
                                        hintText: loc!.typeMessage,
                                        hintStyle: TextStyle(
                                          fontFamily:
                                              AppFonts.englishFontFamily,
                                          color: theme.dividerColor,
                                          fontSize: 14.sp,
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.w,
                                          vertical: 10.h,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: appColors.textField!,
                                            width: 1.2.w,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.r),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: appColors.textField!,
                                            width: 1.2.w,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.r),
                                          ),
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: appColors.textField!,
                                            width: 1.2.w,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.r),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: appColors.textField!,
                                            width: 1.2.w,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(30.r),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: _sendMessage,

                              child: Container(
                                width: 50.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.primaryColor,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AppAssets.sendIcon,
                                    colorFilter: ColorFilter.mode(
                                      theme.scaffoldBackgroundColor,
                                      BlendMode.srcIn,
                                    ),
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

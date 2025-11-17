import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/number_localizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ParticipantData {
  final String name;
  final String? photoUrl;
  final String email;
  final String role;
  final int unreadCount;

  ParticipantData({
    required this.name,
    required this.photoUrl,
    required this.unreadCount,
    required this.email,
    required this.role,
  });

  factory ParticipantData.fromMap(Map<String, dynamic> json) {
    return ParticipantData(
      role: json['role'] ?? "",
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'unreadCount': unreadCount,
      'role': role,
      'email': email,
    };
  }
}

class ConversationModel {
  final String id;
  final List<String> participants;
  final Map<String, ParticipantData> participantsData;
  final String lastMessage;
  final String lastMessageSenderId;
  final DateTime? lastMessageTime;
  final String status;

  ConversationModel({
    required this.id,
    required this.participants,
    required this.participantsData,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.lastMessageTime,
    required this.status,
  });

  int get myUnreadCount {
    final myId = FirebaseAuth.instance.currentUser?.uid;

    if (participantsData.containsKey(myId)) {
      return participantsData[myId]!.unreadCount;
    }

    return 0;
  }

  String timeAgo(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;

    if (lastMessageTime == null) {
      return '';
    }

    final now = DateTime.now();
    final difference = now.difference(lastMessageTime!);

    if (difference.inSeconds < 5) {
      return loc.justNow;
    } else if (difference.inMinutes < 1) {
      String seconds = NumberLocalizer.formatNumber(
        difference.inSeconds,
        localeCode,
      );
      return loc.secondsAgo(seconds);
      // "30s ago" / "منذ ٣٠ث"
    } else if (difference.inHours < 1) {
      String minutes = NumberLocalizer.formatNumber(
        difference.inMinutes,
        localeCode,
      );
      return loc.minutesAgo(minutes);
      // "5m ago" / "منذ ٥د"
    } else if (difference.inDays < 1) {
      String hours = NumberLocalizer.formatNumber(
        difference.inHours,
        localeCode,
      );
      return loc.hoursAgo(hours);
      // "2h ago" / "منذ ٢س"
    } else if (difference.inDays == 1) {
      if (now.day - lastMessageTime!.day == 1) {
        return loc.yesterday;
      } else {
        String days = NumberLocalizer.formatNumber(1, localeCode);
        return loc.daysAgo(days);
        // "1d ago" / "منذ ١ي"
      }
    } else if (difference.inDays < 7) {
      String days = NumberLocalizer.formatNumber(difference.inDays, localeCode);
      return loc.daysAgo(days);
      // "3d ago" / "منذ ٣ي"
    } else {
      String day = NumberLocalizer.formatNumber(
        lastMessageTime!.day,
        localeCode,
      );
      String month = NumberLocalizer.formatNumber(
        lastMessageTime!.month,
        localeCode,
      );
      String year = NumberLocalizer.formatNumber(
        lastMessageTime!.year,
        localeCode,
      );
      return '$day/$month/$year';
    }
  }

  ParticipantData get otherUser {
    return participantsData.entries
        .firstWhere(
          (entry) => entry.key != FirebaseAuth.instance.currentUser!.uid,
        )
        .value;
  }

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    Map<String, ParticipantData> participantsMap = {};
    (json['participantsData'] as Map<String, dynamic>).forEach((key, value) {
      participantsMap[key] = ParticipantData.fromMap(value);
    });

    return ConversationModel(
      id: json['id'] ?? "",
      participants: List<String>.from(json['participants'] ?? []),
      participantsData: participantsMap,
      lastMessage: json['lastMessage'] ?? '',
      lastMessageSenderId: json['lastMessageSenderId'] ?? '',
      lastMessageTime: (json['lastMessageTime'] as Timestamp?)?.toDate(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> participantsDataForJson = {};
    participantsData.forEach((key, value) {
      participantsDataForJson[key] = value
          .toJson(); //  <-- استخدمنا الـ toJson بتاع ParticipantData
    });

    return {
      'participants': participants,
      'participantsData':
          participantsDataForJson, //  <-- ده الـ Map اللي جهزناه
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageTime': lastMessageTime, // تحويل لـ Timestamp
      'status': status,
    };
  }
}

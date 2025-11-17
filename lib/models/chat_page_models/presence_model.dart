import 'package:cloud_firestore/cloud_firestore.dart';

class PresenceModel {
  final String userId;
  final bool typing;
  final bool online;
  final DateTime? lastTypingUpdate;

  PresenceModel({
    required this.userId,
    required this.typing,
    required this.online,
    this.lastTypingUpdate, // خليه اختياري
  });

  factory PresenceModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PresenceModel(
      userId: doc.id,
      typing: data['typing'] ?? false,
      online: data['online'] ?? false,

      lastTypingUpdate: DateTime.tryParse(data['lastTypingUpdate'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'typing': typing,
      'online': online,
      'lastTypingUpdate': lastTypingUpdate?.toIso8601String(),
    };
  }
}

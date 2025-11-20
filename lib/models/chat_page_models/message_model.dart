import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id; // <-- ده الـ Document ID
  final String senderId;
  final String text;
  final String type;
  final String? imageUrl;
  final String? pId;
  final DateTime? timestamp;
  final List<String> readBy;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.text,
    required this.type,
    this.timestamp, // خليه اختياري عشان الـ serverTimestamp
    required this.readBy,
    this.imageUrl,
    this.pId,
  });

  // 1. بنستقبل DocumentSnapshot مش Map
  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return MessageModel(
      id: doc.id,
      senderId: data['senderId'] ?? '',
      text: data['text'] ?? '',
      type: data['type'] ?? 'text',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate(),
      readBy: List<String>.from(data['readBy'] ?? []),
      imageUrl: data['imageUrl'],
      pId: data['pId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'text': text,
      'type': type,
      'timestamp': FieldValue.serverTimestamp(),
      'readBy': readBy,
      'imageUrl': imageUrl,
      'pId': pId,
    };
  }
}

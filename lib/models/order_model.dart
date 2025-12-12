import 'package:batrina/models/address_model.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userId;
  final String userName;
  final double totalAmount;
  final String status; // Pending, Processing, Shipped, Delivered, Cancelled
  final AddressModel shippingAddress;
  final List<CartModel> items;
  final DateTime createdAt;

  OrderModel({
    this.id = '',
    required this.userId,
    required this.userName,
    required this.totalAmount,
    required this.status,
    required this.shippingAddress,
    required this.items,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'totalAmount': totalAmount,
      'status': status,
      'shippingAddress': shippingAddress.toJson(),
      'items': items.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json, String id) {
    return OrderModel(
      id: id,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      status: json['status'] ?? 'Pending',
      shippingAddress: AddressModel.fromJson(json['shippingAddress']),
      items: (json['items'] as List).map((e) => CartModel.fromJson(e)).toList(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
}

import 'package:flutter/material.dart';

class PaymentMethodOption {
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  PaymentMethodOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
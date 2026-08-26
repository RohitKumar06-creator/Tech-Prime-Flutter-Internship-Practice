import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  PaymentMethod({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}

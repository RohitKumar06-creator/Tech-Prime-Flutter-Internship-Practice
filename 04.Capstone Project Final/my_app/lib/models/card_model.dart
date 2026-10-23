import 'package:flutter/material.dart';

class PaymentCardModel {
  final String id;
  final String cardHolder;
  final String cardNumber;
  final String last4;
  final String expiry;
  final String cvv;
  final String brand; // Visa, Mastercard, Amex
  final List<Color> gradientColors;
  bool isDefault;

  PaymentCardModel({
    required this.id,
    required this.cardHolder,
    required this.cardNumber,
    required this.last4,
    required this.expiry,
    required this.cvv,
    required this.brand,
    required this.gradientColors,
    this.isDefault = false,
  });

  factory PaymentCardModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return PaymentCardModel(
      id: documentId,
      cardHolder: map['cardHolder'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      last4: map['last4'] ?? '',
      expiry: map['expiry'] ?? '',
      cvv: map['cvv'] ?? '',
      brand: map['brand'] ?? 'Visa',
      gradientColors: const [Color(0xFF8A7CFF), Color(0xFF624AF2)],
      isDefault: map['isDefault'] ?? false,
    );
  }

  String? get cardType => null;

  Map<String, dynamic> toMap() {
    return {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'last4': last4,
      'expiry': expiry,
      'cvv': cvv,
      'brand': brand,
      'isDefault': isDefault,
    };
  }
}

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

  String get maskedNumber => '**** **** **** $last4';

  static List<Color> getBrandGradient(String brandName) {
    final b = brandName.toLowerCase();
    if (b.contains('visa')) {
      return const [Color(0xFF11998E), Color(0xFF38EF7D)]; // Teal/Emerald
    } else if (b.contains('amex') || b.contains('american')) {
      return const [Color(0xFFA8FF78), Color(0xFF78FFD6)]; // Lime/Cyan
    } else {
      return const [
        Color(0xFF8E2DE2),
        Color(0xFF4A00E0),
      ]; // Purple/Violet (Mastercard)
    }
  }

  factory PaymentCardModel.fromMap(Map<String, dynamic> map, String id) {
    final rawNumber = map['cardNumber'] ?? '';
    final computedLast4 = rawNumber.length >= 4
        ? rawNumber.substring(rawNumber.length - 4)
        : (map['last4'] ?? '0000');

    final brandName = map['brand'] ?? 'Mastercard';

    return PaymentCardModel(
      id: id,
      cardHolder: map['cardHolder'] ?? 'Zhafira Azalea',
      cardNumber: rawNumber,
      last4: computedLast4,
      expiry: map['expiry'] ?? '',
      cvv: map['cvv'] ?? '',
      brand: brandName,
      gradientColors: getBrandGradient(brandName),
      isDefault: map['isDefault'] ?? false,
    );
  }

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

import 'package:flutter/material.dart';

import '../../../models/card_model.dart';

class PaymentViewModel extends ChangeNotifier {
  final List<PaymentCardModel> _cards = [
    PaymentCardModel(
      id: 'card_1',
      cardHolder: 'Zhafira Azalea',
      cardNumber: '**** **** **** 0329',
      last4: '0329',
      expiry: '03/24',
      cvv: '123',
      brand: 'Mastercard',
      gradientColors: [const Color(0xFF8A7CFF), const Color(0xFF624AF2)],
      isDefault: true,
    ),
    PaymentCardModel(
      id: 'card_2',
      cardHolder: 'Zhafira Azalea',
      cardNumber: '**** **** **** 0329',
      last4: '0329',
      expiry: '03/24',
      cvv: '456',
      brand: 'Visa',
      gradientColors: [const Color(0xFF2FD3C6), const Color(0xFF1E88E5)],
      isDefault: false,
    ),
    PaymentCardModel(
      id: 'card_3',
      cardHolder: 'Zhafira Azalea',
      cardNumber: '**** **** **** 0329',
      last4: '0329',
      expiry: '03/24',
      cvv: '789',
      brand: 'Amex',
      gradientColors: [const Color(0xFFA8E063), const Color(0xFF56AB2F)],
      isDefault: false,
    ),
  ];

  PaymentCardModel? _selectedCard;

  // Getters
  List<PaymentCardModel> get cards => _cards;

  PaymentCardModel get activeCard =>
      _cards.firstWhere((c) => c.isDefault, orElse: () => _cards.first);

  List<PaymentCardModel> get secondaryCards =>
      _cards.where((c) => c.id != activeCard.id).toList();

  PaymentCardModel? get selectedCard => _selectedCard ?? activeCard;

  // Actions
  void selectCard(PaymentCardModel card) {
    _selectedCard = card;
    notifyListeners();
  }

  void addCard(PaymentCardModel newCard) {
    if (newCard.isDefault) {
      for (var card in _cards) {
        card.isDefault = false;
      }
    }
    _cards.add(newCard);
    notifyListeners();
  }

  void setDefaultCard(String cardId) {
    for (var card in _cards) {
      card.isDefault = (card.id == cardId);
    }
    notifyListeners();
  }

  void deleteCard(String cardId) {
    _cards.removeWhere((card) => card.id == cardId);
    if (_cards.isNotEmpty && !_cards.any((c) => c.isDefault)) {
      _cards.first.isDefault = true;
    }
    notifyListeners();
  }
}

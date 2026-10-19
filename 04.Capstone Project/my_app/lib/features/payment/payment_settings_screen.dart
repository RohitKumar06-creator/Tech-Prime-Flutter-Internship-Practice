import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/card_model.dart';
import 'widgets/add_card_sheet.dart';
import 'widgets/card_options_sheet.dart';

class PaymentSettingsScreen extends StatefulWidget {
  const PaymentSettingsScreen({super.key});

  @override
  State<PaymentSettingsScreen> createState() => _PaymentSettingsScreenState();
}

class _PaymentSettingsScreenState extends State<PaymentSettingsScreen> {
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

  void _openAddCardSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddCardSheet(
        onCardAdded: (newCard) {
          setState(() {
            if (newCard.isDefault) {
              for (var c in _cards) {
                c.isDefault = false;
              }
            }
            _cards.add(newCard);
          });
        },
      ),
    );
  }

  void _openCardOptions(PaymentCardModel card) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => CardOptionsSheet(
        onSetDefault: () {
          setState(() {
            for (var c in _cards) {
              c.isDefault = (c.id == card.id);
            }
          });
        },
        onDelete: () {
          setState(() {
            _cards.removeWhere((c) => c.id == card.id);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeCard = _cards.firstWhere(
      (c) => c.isDefault,
      orElse: () => _cards.first,
    );
    final otherCards = _cards.where((c) => c.id != activeCard.id).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Payment',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _openAddCardSheet,
            child: const Text(
              'Add Card',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Active Card',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),
              _buildCardItem(activeCard),
              const SizedBox(height: 28),

              if (otherCards.isNotEmpty) ...[
                const Text(
                  'Payment Methods',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                ...otherCards.map(
                  (card) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: _buildCardItem(card),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(PaymentCardModel card) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: card.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: card.gradientColors.first.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card.cardHolder,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () => _openCardOptions(card),
              ),
            ],
          ),
          const Spacer(),
          Text(
            card.cardNumber,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'VALID THRU ${card.expiry}',
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  card.brand.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

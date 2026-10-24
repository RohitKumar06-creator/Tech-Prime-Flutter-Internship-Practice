import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/card_model.dart';
import 'viewmodels/payment_viewmodel.dart';
import 'widgets/add_card_sheet.dart';
import 'widgets/card_options_sheet.dart';

class PaymentSettingsScreen extends StatelessWidget {
  const PaymentSettingsScreen({super.key});

  static const Color _appPrimaryColor = Color(0xFF4FC3F7);

  void _openAddCardSheet(
    BuildContext context,
    PaymentViewModel viewModel,
  ) async {
    final newCard = await showModalBottomSheet<PaymentCardModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddCardBottomSheet(),
    );

    if (newCard != null) {
      viewModel.addCard(newCard);
    }
  }

  void _openCardOptions(
    BuildContext context,
    PaymentCardModel card,
    PaymentViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => CardOptionsSheet(
        onSetDefault: () => viewModel.setDefaultCard(card.id),
        onDelete: () => viewModel.deleteCard(card.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentViewModel(),
      child: Consumer<PaymentViewModel>(
        builder: (context, viewModel, _) {
          final activeCard = viewModel.activeCard;
          final secondaryCards = viewModel.secondaryCards;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black87,
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
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => _openAddCardSheet(context, viewModel),
                  child: const Text(
                    'Add Card',
                    style: TextStyle(
                      color: _appPrimaryColor,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (activeCard != null) ...[
                      const Text(
                        'Active Card',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildCardItem(context, activeCard, viewModel),
                      const SizedBox(height: 28),
                    ],

                    if (secondaryCards.isNotEmpty) ...[
                      const Text(
                        'Payment Methods',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...secondaryCards.map(
                        (card) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: _buildCardItem(context, card, viewModel),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardItem(
    BuildContext context,
    PaymentCardModel card,
    PaymentViewModel viewModel,
  ) {
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
                onPressed: () => _openCardOptions(context, card, viewModel),
              ),
            ],
          ),
          const Spacer(),
          Text(
            card.maskedNumber,
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

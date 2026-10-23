import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../models/card_model.dart';
import '../../payment/widgets/add_card_sheet.dart';

class PaymentMethodStep extends StatefulWidget {
  final Function(PaymentCardModel) onCardSelected;

  const PaymentMethodStep({super.key, required this.onCardSelected});

  @override
  State<PaymentMethodStep> createState() => _PaymentMethodStepState();
}

class _PaymentMethodStepState extends State<PaymentMethodStep> {
  bool _agreeToTerms = true;

  final List<PaymentCardModel> _cards = [
    PaymentCardModel(
      id: '1',
      cardHolder: 'Zhafira Azalea',
      cardNumber: '**** **** **** 0329',
      last4: '0329',
      expiry: '03/24',
      cvv: '123',
      brand: 'Mastercard',
      gradientColors: [const Color(0xFF8E84F5), const Color(0xFF6C5CE7)],
      isDefault: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 20),

          // Horizontal Credit Cards Carousel
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _cards.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                if (index == _cards.length) {
                  // Add New Card Button Card
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => AddCardSheet(
                          onCardAdded: (newCard) {
                            setState(() => _cards.add(newCard));
                            widget.onCardSelected(newCard);
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 280,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F9FC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: Color(0xFF4FC3F7),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Add New Card',
                              style: TextStyle(
                                color: Color(0xFF4FC3F7),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                final card = _cards[index];
                return Container(
                  width: 280,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: card.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.cardHolder,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        card.cardNumber,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'VALID THRU ${card.expiry}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                          const Icon(Icons.payment, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Terms Checkbox
          Row(
            children: [
              Checkbox(
                value: _agreeToTerms,
                activeColor: const Color(0xFF4FC3F7),
                onChanged: (val) =>
                    setState(() => _agreeToTerms = val ?? false),
              ),
              const Expanded(
                child: Text(
                  'I agree to the company Term of Service and Privacy Policy',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

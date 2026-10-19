import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class PaymentMethodStep extends StatefulWidget {
  final Function(String last4, String name) onCardSelected;

  const PaymentMethodStep({super.key, required this.onCardSelected});

  @override
  State<PaymentMethodStep> createState() => _PaymentMethodStepState();
}

class _PaymentMethodStepState extends State<PaymentMethodStep> {
  bool _agreedToTerms = true;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 24),
        SizedBox(
          height: 190,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCreditCard(
                color: const Color(0xFF8A7CFF),
                name: 'Zhafira Azalea',
                cardNumber: '**** **** **** 0329',
                expiry: '03/24',
              ),
              const SizedBox(width: 16),
              _buildCreditCard(
                color: const Color(0xFF2FD3C6),
                name: 'Zhafira Azalea',
                cardNumber: '**** **** **** 9812',
                expiry: '08/25',
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _agreedToTerms,
                activeColor: AppColors.primaryBlue,
                onChanged: (val) =>
                    setState(() => _agreedToTerms = val ?? false),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: const TextSpan(
                  text: 'I agree to the company ',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                  children: [
                    TextSpan(
                      text: 'Term of Service ',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: 'and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCreditCard({
    required Color color,
    required String name,
    required String cardNumber,
    required String expiry,
  }) {
    return GestureDetector(
      onTap: () => widget.onCardSelected(cardNumber.split(' ').last, name),
      child: Container(
        width: 290,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
            const Spacer(),
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VALID THRU $expiry',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'mastercard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

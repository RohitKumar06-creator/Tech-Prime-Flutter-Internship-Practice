import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/card_model.dart';

class AddCardSheet extends StatefulWidget {
  final Function(PaymentCardModel) onCardAdded;

  const AddCardSheet({super.key, required this.onCardAdded});

  @override
  State<AddCardSheet> createState() => _AddCardSheetState();
}

class _AddCardSheetState extends State<AddCardSheet> {
  final _numberController = TextEditingController(
    text: '0192 - 1245 - 0000 - 0000',
  );
  final _expiryController = TextEditingController(text: '12/22');
  final _cvvController = TextEditingController(text: '234');
  bool _setAsDefault = false;

  @override
  void dispose() {
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              const Text(
                'Add Card',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const Text(
            'Start typing to add your credit card details. Everything will upadate according to your data.',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),

          // Card Number Field
          TextField(
            controller: _numberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: 24,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              suffixIcon: const Icon(
                Icons.check_circle,
                color: Color(0xFF00C853),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: AppColors.primaryBlue),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Expiry and CVV Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _expiryController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.check_circle,
                      color: Color(0xFF00C853),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _cvvController,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.check_circle,
                      color: Color(0xFF00C853),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Set as Default Switch Row
          Row(
            children: [
              Switch(
                value: _setAsDefault,
                activeColor: AppColors.primaryBlue,
                onChanged: (val) => setState(() => _setAsDefault = val),
              ),
              const SizedBox(width: 8),
              const Text(
                'Set as default',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Save Card Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () {
                final newCard = PaymentCardModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  cardHolder: 'Zhafira Azalea',
                  cardNumber: _numberController.text,
                  last4: _numberController.text.length >= 4
                      ? _numberController.text.substring(
                          _numberController.text.length - 4,
                        )
                      : '0000',
                  expiry: _expiryController.text,
                  cvv: _cvvController.text,
                  brand: 'Mastercard',
                  gradientColors: const [Color(0xFF8A7CFF), Color(0xFF624AF2)],
                  isDefault: _setAsDefault,
                );
                widget.onCardAdded(newCard);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Save Card',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

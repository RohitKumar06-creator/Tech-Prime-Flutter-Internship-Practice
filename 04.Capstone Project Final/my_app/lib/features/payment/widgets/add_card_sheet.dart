import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/card_model.dart';

// Formatter to auto-format MM/YY automatically
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonOnlyDigits = i + 1;
      if (nonOnlyDigits == 2 && !text.contains('/')) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}

class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _holderController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  bool _isDefault = false;
  bool _isSaving = false;

  static const Color _appPrimaryColor = Color(0xFF4FC3F7);

  Future<void> _saveCard() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() => _isSaving = false);
      return;
    }

    try {
      final cardNum = _numberController.text.replaceAll(' ', '');
      final last4Digits = cardNum.length >= 4
          ? cardNum.substring(cardNum.length - 4)
          : cardNum;

      final brandName = _detectBrand(cardNum);
      final ref = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cards')
          .doc();

      final newCard = PaymentCardModel(
        id: ref.id,
        cardHolder: _holderController.text.trim().isEmpty
            ? 'Zhafira Azalea'
            : _holderController.text.trim(),
        cardNumber: cardNum,
        last4: last4Digits,
        expiry: _expiryController.text.trim(),
        cvv: _cvvController.text.trim(),
        brand: brandName,
        isDefault: _isDefault,
        gradientColors: brandName.toLowerCase() == 'visa'
            ? [const Color(0xFF11998E), const Color(0xFF38EF7D)]
            : [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)],
      );

      await ref.set(newCard.toMap());

      if (mounted) {
        Navigator.pop(context, newCard);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to save card: $e')));
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  String _detectBrand(String number) {
    if (number.startsWith('4')) return 'Visa';
    if (number.startsWith('3')) return 'Amex';
    return 'Mastercard';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // Fixes 61px bottom overflow issue
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48),
                    const Text(
                      'Add Card',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Start typing to add your credit card details. Everything will update according to your data.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _holderController,
                  decoration: InputDecoration(
                    labelText: 'Cardholder Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    prefixIcon: const Icon(Icons.credit_card),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (val) => val == null || val.length < 12
                      ? 'Enter valid number'
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                          DateInputFormatter(), // Converts 1122 to 11/22
                        ],
                        decoration: InputDecoration(
                          labelText: 'Expiry (MM/YY)',
                          hintText: 'MM/YY',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (val) {
                          if (val == null ||
                              val.isEmpty ||
                              !val.contains('/')) {
                            return 'Required';
                          }
                          final parts = val.split('/');
                          if (parts.length != 2) return 'Invalid';
                          final month = int.tryParse(parts[0]) ?? 0;
                          if (month < 1 || month > 12) return 'Invalid MM';
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(4),
                        ],
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        validator: (val) =>
                            val == null || val.length < 3 ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('Set as default'),
                  value: _isDefault,
                  activeColor: _appPrimaryColor,
                  onChanged: (val) => setState(() => _isDefault = val),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _appPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _isSaving ? null : _saveCard,
                    child: _isSaving
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Save Card',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

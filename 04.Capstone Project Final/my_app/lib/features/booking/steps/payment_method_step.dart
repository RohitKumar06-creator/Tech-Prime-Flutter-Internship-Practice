import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/card_model.dart';
import '../../payment/widgets/add_card_sheet.dart';
import '../../payment/widgets/card_options_sheet.dart';

class PaymentMethodStep extends StatefulWidget {
  final ValueChanged<PaymentCardModel?> onCardSelected;

  const PaymentMethodStep({super.key, required this.onCardSelected});

  @override
  State<PaymentMethodStep> createState() => _PaymentMethodStepState();
}

class _PaymentMethodStepState extends State<PaymentMethodStep> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  List<PaymentCardModel> _cards = [];
  PaymentCardModel? _selectedCard;
  bool _isLoading = true;
  bool _agreeToTerms = true;

  static const Color _appPrimaryColor = Color(0xFF4FC3F7);

  @override
  void initState() {
    super.initState();
    _fetchUserCards();
  }

  List<PaymentCardModel> _getInitialMockCards() {
    return [
      PaymentCardModel(
        id: 'mock_mastercard',
        cardHolder: 'Zhafira Azalea',
        cardNumber: '**** **** **** 0329',
        last4: '0329',
        expiry: '03/24',
        cvv: '123',
        brand: 'Mastercard',
        gradientColors: const [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
        isDefault: true,
      ),
      PaymentCardModel(
        id: 'mock_visa',
        cardHolder: 'Zhafira Azalea',
        cardNumber: '**** **** **** 9812',
        last4: '9812',
        expiry: '03/24',
        cvv: '456',
        brand: 'Visa',
        gradientColors: const [Color(0xFF11998E), Color(0xFF38EF7D)],
        isDefault: false,
      ),
      PaymentCardModel(
        id: 'mock_amex',
        cardHolder: 'Zhafira Azalea',
        cardNumber: '**** **** **** 5100',
        last4: '5100',
        expiry: '05/25',
        cvv: '789',
        brand: 'American Express',
        gradientColors: const [Color(0xFFA8FF78), Color(0xFF78FFD6)],
        isDefault: false,
      ),
    ];
  }

  Future<void> _fetchUserCards() async {
    if (_uid == null) {
      final mock = _getInitialMockCards();
      setState(() {
        _cards = mock;
        _selectedCard = mock.first;
        _isLoading = false;
      });
      widget.onCardSelected(_selectedCard);
      return;
    }

    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_uid)
          .collection('cards')
          .get();

      final loadedCards = snapshot.docs
          .map((doc) => PaymentCardModel.fromMap(doc.data(), doc.id))
          .toList();

      setState(() {
        _cards = loadedCards.isNotEmpty ? loadedCards : _getInitialMockCards();
        _selectedCard = _cards.firstWhere(
          (c) => c.isDefault,
          orElse: () => _cards.first,
        );
        _isLoading = false;
      });
      widget.onCardSelected(_selectedCard);
    } catch (e) {
      final mock = _getInitialMockCards();
      setState(() {
        _cards = mock;
        _selectedCard = mock.first;
        _isLoading = false;
      });
      widget.onCardSelected(_selectedCard);
    }
  }

  void _openAddCardSheet() async {
    final newCard = await showModalBottomSheet<PaymentCardModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const AddCardBottomSheet(),
    );

    if (newCard != null) {
      setState(() {
        _cards.add(newCard);
        _selectedCard = newCard;
      });
      widget.onCardSelected(newCard);
    }
  }

  void _openCardOptions(PaymentCardModel card) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => CardOptionsSheet(
        onSetDefault: () async {
          if (_uid != null && !card.id.startsWith('mock_')) {
            for (var c in _cards) {
              c.isDefault = (c.id == card.id);
              await _firestore
                  .collection('users')
                  .doc(_uid)
                  .collection('cards')
                  .doc(c.id)
                  .update({'isDefault': c.isDefault});
            }
          } else {
            for (var c in _cards) {
              c.isDefault = (c.id == card.id);
            }
          }
          setState(() {
            _selectedCard = card;
          });
          widget.onCardSelected(card);
        },
        onDelete: () async {
          if (_uid != null && !card.id.startsWith('mock_')) {
            await _firestore
                .collection('users')
                .doc(_uid)
                .collection('cards')
                .doc(card.id)
                .delete();
          }

          setState(() {
            _cards.removeWhere((c) => c.id == card.id);
            if (_cards.isNotEmpty) {
              if (!_cards.any((c) => c.isDefault)) {
                _cards.first.isDefault = true;
              }
              _selectedCard = _cards.firstWhere(
                (c) => c.isDefault,
                orElse: () => _cards.first,
              );
            } else {
              _selectedCard = null;
            }
          });
          widget.onCardSelected(_selectedCard);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: _appPrimaryColor),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton.icon(
                onPressed: _openAddCardSheet,
                icon: const Icon(Icons.add, color: _appPrimaryColor, size: 18),
                label: const Text(
                  'Add Card',
                  style: TextStyle(
                    color: _appPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_cards.isEmpty) ...[
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  children: [
                    const Text(
                      'No cards available.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _appPrimaryColor,
                      ),
                      onPressed: _openAddCardSheet,
                      child: const Text(
                        'Add Card',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            // Horizontal Card Carousel Slider
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _cards.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  final isSelected = _selectedCard?.id == card.id;

                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedCard = card);
                      widget.onCardSelected(card);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 290,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: card.gradientColors,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(color: _appPrimaryColor, width: 3)
                            : null,
                        boxShadow: [
                          BoxShadow(
                            color: card.gradientColors.first.withOpacity(0.3),
                            blurRadius: 8,
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () => _openCardOptions(card),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            card.maskedNumber,
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
                                'VALID THRU ${card.expiry}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 10,
                                ),
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
                                child: Text(
                                  card.brand.toUpperCase(),
                                  style: const TextStyle(
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
                },
              ),
            ),
          ],

          const SizedBox(height: 32),

          // Term of Service Checkbox (Matching Booking-3.png)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: _agreeToTerms,
                  activeColor: _appPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (val) {
                    setState(() => _agreeToTerms = val ?? true);
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: 'I agree to the company '),
                      TextSpan(
                        text: 'Term of Service',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.black87,
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
      ),
    );
  }
}

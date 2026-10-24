import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/card_model.dart'; // Contains PaymentCardModel
import '../payment/widgets/add_card_sheet.dart';
import './steps/booking_success_step.dart';

class BookingDetailScreen extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String specialty;
  final DateTime selectedDateTime;
  final String appointmentType;

  const BookingDetailScreen({
    super.key,
    required this.doctorId,
    required this.doctorName,
    required this.specialty,
    required this.selectedDateTime,
    required this.appointmentType,
  });

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  List<PaymentCardModel> _savedCards = [];
  PaymentCardModel? _selectedCard;
  bool _isLoadingCards = true;

  @override
  void initState() {
    super.initState();
    _fetchUserCards();
  }

  Future<void> _fetchUserCards() async {
    if (_uid == null) {
      setState(() => _isLoadingCards = false);
      return;
    }
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(_uid)
          .collection('cards')
          .get();

      final cards = snapshot.docs
          .map((doc) => PaymentCardModel.fromMap(doc.data(), doc.id))
          .toList();

      setState(() {
        _savedCards = cards;
        if (cards.isNotEmpty) {
          _selectedCard = cards.firstWhere(
            (c) => c.isDefault,
            orElse: () => cards.first,
          );
        }
        _isLoadingCards = false;
      });
    } catch (e) {
      setState(() => _isLoadingCards = false);
    }
  }

  String _formatDateTime(DateTime dt) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    final dayName = days[dt.weekday - 1];
    final monthName = months[dt.month - 1];
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';

    return '$dayName, ${dt.day} $monthName ${dt.year}\n$hour:$minute $period';
  }

  void _showPaymentSelectionSheet() {
    final primaryColor = Theme.of(context).primaryColor;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 48),
                      const Text(
                        'Select Payment',
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
                  const SizedBox(height: 16),
                  _isLoadingCards
                      ? const Center(child: CircularProgressIndicator())
                      : _savedCards.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                            'No saved cards found.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _savedCards.length,
                          itemBuilder: (context, index) {
                            final card = _savedCards[index];
                            final isSelected = _selectedCard?.id == card.id;

                            return GestureDetector(
                              onTap: () {
                                setState(() => _selectedCard = card);
                                setModalState(() {});
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isSelected
                                        ? primaryColor
                                        : Colors.grey.shade200,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    _getBrandIcon(card.brand),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            card.brand,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            card.maskedNumber,
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      isSelected
                                          ? Icons.check_circle
                                          : Icons.radio_button_off,
                                      color: isSelected
                                          ? primaryColor
                                          : Colors.grey.shade400,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () async {
                      final newCard = await _showAddCardSheet();
                      if (newCard != null) {
                        setModalState(() {
                          _savedCards.add(newCard);
                          _selectedCard = newCard;
                        });
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.add_circle_outline, color: primaryColor),
                    label: Text(
                      'Add Card',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<PaymentCardModel?> _showAddCardSheet() async {
    return await showModalBottomSheet<PaymentCardModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddCardBottomSheet(),
    );
  }

  Widget _getBrandIcon(String brand) {
    IconData iconData = Icons.credit_card;
    Color color = Colors.grey;

    if (brand.toLowerCase() == 'visa') {
      iconData = Icons.payment;
      color = Colors.blue.shade900;
    } else if (brand.toLowerCase() == 'mastercard') {
      iconData = Icons.credit_card_sharp;
      color = Colors.orange;
    }

    return Icon(iconData, color: color, size: 40);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Booking Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Booking Info',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Pending Payment',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              color: Colors.blueGrey.shade50.withOpacity(0.4),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.calendar_today),
                      ),
                      title: const Text(
                        'Date & Time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _formatDateTime(widget.selectedDateTime),
                        style: TextStyle(color: Colors.blueGrey.shade700),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.people)),
                      title: const Text(
                        'Appointment Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${widget.appointmentType}\nNone',
                        style: TextStyle(color: Colors.blueGrey.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Selected Payment Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _showPaymentSelectionSheet,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    _selectedCard != null
                        ? _getBrandIcon(_selectedCard!.brand)
                        : const Icon(
                            Icons.credit_card,
                            size: 40,
                            color: Colors.grey,
                          ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        _selectedCard != null
                            ? '${_selectedCard!.brand} - ${_selectedCard!.maskedNumber}'
                            : 'Choose Payment Method',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _selectedCard == null
                    ? _showPaymentSelectionSheet
                    : () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingSuccessStep(
                              doctorName: widget.doctorName,
                              specialty: widget.specialty,
                            ),
                          ),
                        );
                      },
                child: const Text(
                  'Pay Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

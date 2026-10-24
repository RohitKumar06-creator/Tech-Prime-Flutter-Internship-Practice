import 'package:flutter/material.dart';

import '../../../models/card_model.dart';
import 'add_card_sheet.dart';

class SelectPaymentSheet extends StatefulWidget {
  final List<PaymentCardModel> cards;
  final PaymentCardModel? selectedCard;
  final Function(PaymentCardModel) onCardSelected;
  final Function(PaymentCardModel) onCardAdded;

  const SelectPaymentSheet({
    super.key,
    required this.cards,
    required this.selectedCard,
    required this.onCardSelected,
    required this.onCardAdded,
  });

  @override
  State<SelectPaymentSheet> createState() => _SelectPaymentSheetState();
}

class _SelectPaymentSheetState extends State<SelectPaymentSheet> {
  PaymentCardModel? _currentSelected;
  static const Color _appPrimaryColor = Color(0xFF4FC3F7);

  @override
  void initState() {
    super.initState();
    _currentSelected =
        widget.selectedCard ??
        (widget.cards.isNotEmpty ? widget.cards.first : null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              const Text(
                'Select Payment',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...widget.cards.map((card) {
            final isSelected = _currentSelected?.id == card.id;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? _appPrimaryColor.withOpacity(0.08)
                    : Colors.white,
                border: Border.all(
                  color: isSelected ? _appPrimaryColor : Colors.grey.shade200,
                  width: isSelected ? 1.5 : 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: RadioListTile<String>(
                value: card.id,
                groupValue: _currentSelected?.id,
                activeColor: _appPrimaryColor,
                onChanged: (_) {
                  setState(() => _currentSelected = card);
                  widget.onCardSelected(card);
                  Navigator.pop(context);
                },
                secondary: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    card.brand.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: card.brand.toLowerCase() == 'visa'
                          ? Colors.blue
                          : Colors.deepOrange,
                    ),
                  ),
                ),
                title: Text(
                  card.brand,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Text(
                  card.maskedNumber,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () async {
              Navigator.pop(context);
              final newCard = await showModalBottomSheet<PaymentCardModel>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const AddCardBottomSheet(),
              );
              if (newCard != null) {
                widget.onCardAdded(newCard);
              }
            },
            icon: const Icon(Icons.add_circle_outline, color: _appPrimaryColor),
            label: const Text(
              'Add Card',
              style: TextStyle(
                color: _appPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

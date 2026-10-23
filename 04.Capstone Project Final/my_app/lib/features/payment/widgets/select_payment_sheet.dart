import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
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
          // Drag Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              const Text(
                'Select Payment',
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
          const SizedBox(height: 20),

          // Cards Radio List
          ...widget.cards.map((card) {
            final isSelected = _currentSelected?.id == card.id;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFF2FAFF) : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryBlue
                      : Colors.grey.shade200,
                  width: isSelected ? 1.5 : 1.0,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: RadioListTile<String>(
                value: card.id,
                groupValue: _currentSelected?.id,
                activeColor: AppColors.primaryBlue,
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
                      color: card.brand == 'Visa'
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
                    color: AppColors.textDark,
                  ),
                ),
                subtitle: Text(
                  '**** **** **** ${card.last4}',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }),

          const SizedBox(height: 12),

          // Add Card Button
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => AddCardSheet(onCardAdded: widget.onCardAdded),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppColors.primaryBlue,
            ),
            label: const Text(
              'Add Card',
              style: TextStyle(
                color: AppColors.primaryBlue,
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

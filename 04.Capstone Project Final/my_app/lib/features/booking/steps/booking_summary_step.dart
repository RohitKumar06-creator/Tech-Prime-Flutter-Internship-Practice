import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../viewmodels/booking_viewmodel.dart';

class BookingSummaryStep extends StatelessWidget {
  final BookingViewModel viewModel;

  const BookingSummaryStep({super.key, required this.viewModel});

  Widget _getBrandLogo(String brand) {
    final b = brand.toLowerCase();
    String label = 'VISA';
    Color color = Colors.indigo;

    if (b.contains('mastercard')) {
      label = 'MC';
      color = Colors.deepOrange;
    } else if (b.contains('amex') || b.contains('american')) {
      label = 'AMEX';
      color = Colors.blue.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doc = viewModel.selectedDoctor;
    final card = viewModel.selectedCard;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 24),

          // Booking Info Section
          const Text(
            'Booking Info',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F9FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Date & Time',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${viewModel.selectedDay}, ${viewModel.selectedDateNum} Jun 2026',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Text(
                    viewModel.selectedTime,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Doctor Info Section
          const Text(
            'Doctor Info',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  doc?.imageUrl ?? 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=400',
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc?.name ?? 'dr. Nirmala Azalea',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    doc?.specialization ?? 'Orthopedic',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      viewModel.selectedReason,
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Payment Info Section (Reflects Selected Card)
          const Text(
            'Payment Info',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _getBrandLogo(card?.brand ?? 'Mastercard'),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card?.brand ?? 'Mastercard',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '**** **** **** ${card?.last4 ?? '0329'}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Total Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Text(
                '\$ 12',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SelectScheduleStep extends StatelessWidget {
  final String? selectedDay;
  final String? selectedDateNum;
  final String? selectedTime;
  final Function(String day, String dateNum) onDateSelected;
  final Function(String time) onTimeSelected;

  const SelectScheduleStep({
    super.key,
    required this.selectedDay,
    required this.selectedDateNum,
    required this.selectedTime,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final days = [
      {'day': 'M', 'num': '7'},
      {'day': 'T', 'num': '8'},
      {'day': 'W', 'num': '10'},
      {'day': 'T', 'num': '11'},
      {'day': 'F', 'num': '12'},
      {'day': 'S', 'num': '13'},
    ];

    final morningSlots = [
      '08:00 AM',
      '08:30 AM',
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
    ];
    final nightSlots = [
      '08:00 AM',
      '08:30 AM',
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Schedule',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((item) {
              final isSelected = selectedDateNum == item['num'];
              return GestureDetector(
                onTap: () => onDateSelected(item['day']!, item['num']!),
                child: Container(
                  width: 48,
                  height: 70,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryBlue
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryBlue
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['day']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['num']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),

          const Text(
            'Morning',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: morningSlots
                .map((time) => _buildTimePill(time, context))
                .toList(),
          ),
          const SizedBox(height: 24),

          const Text(
            'Night',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: nightSlots
                .map((time) => _buildTimePill(time, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTimePill(String time, BuildContext context) {
    final isSelected = selectedTime == time;
    return GestureDetector(
      onTap: () => onTimeSelected(time),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade200,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}

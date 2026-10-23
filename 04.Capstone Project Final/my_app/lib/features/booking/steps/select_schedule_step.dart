import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SelectScheduleStep extends StatelessWidget {
  final String selectedDay;
  final dynamic selectedDateNum;
  final String selectedTime;
  final Function(String day, dynamic dateNum) onDateSelected;
  final Function(String time) onTimeSelected;

  const SelectScheduleStep({
    super.key,
    required this.selectedDay,
    required this.selectedDateNum,
    required this.selectedTime,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  // Generates 7 consecutive days starting from today
  List<Map<String, dynamic>> _generateUpcomingDays() {
    final List<Map<String, dynamic>> generated = [];
    final now = DateTime.now();

    final dayLabels = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    for (int i = 0; i < 7; i++) {
      final date = now.add(Duration(days: i));
      generated.add({'day': dayLabels[date.weekday % 7], 'num': date.day});
    }
    return generated;
  }

  @override
  Widget build(BuildContext context) {
    final upcomingDays = _generateUpcomingDays();

    final List<String> morningSlots = [
      '08:00 AM',
      '08:30 AM',
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
    ];

    final List<String> nightSlots = [
      '07:00 PM',
      '07:30 PM',
      '08:00 PM',
      '08:30 PM',
      '09:00 PM',
      '09:30 PM',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Schedule',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Dynamic Upcoming 7-Days Row starting from Today
          SizedBox(
            height: 70,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingDays.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final d = upcomingDays[index];
                final isSelected =
                    selectedDay == d['day'] &&
                    selectedDateNum.toString() == d['num'].toString();

                return InkWell(
                  onTap: () => onDateSelected(d['day'] as String, d['num']),
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4FC3F7)
                          : const Color(0xFFF7F9FC),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF4FC3F7)
                            : Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          d['day'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.white : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${d['num']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Morning Time Slots
          const Text(
            'Morning',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: morningSlots.map((time) {
              final isSelected = selectedTime == time;
              return InkWell(
                onTap: () => onTimeSelected(time),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4FC3F7) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4FC3F7)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Night Time Slots (Selecting here clears Morning selection)
          const Text(
            'Night',
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: nightSlots.map((time) {
              final isSelected = selectedTime == time;
              return InkWell(
                onTap: () => onTimeSelected(time),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4FC3F7) : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4FC3F7)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

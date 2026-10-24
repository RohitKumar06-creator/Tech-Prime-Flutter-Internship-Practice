import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class MedicalRecordsScreen extends StatelessWidget {
  const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = [
      {
        'title': 'Orthopedic Consultation',
        'doctor': 'Dr. Nirmala Azalea',
        'date': 'June 20, 2026',
        'type': 'Check-up',
      },
      {
        'title': 'Blood Panel Lab Test',
        'doctor': 'Dr. Agus Subandono',
        'date': 'May 10, 2026',
        'type': 'Pathology',
      },
      {
        'title': 'General Health Screening',
        'doctor': 'Dr. Bambang Sucat',
        'date': 'Jan 15, 2026',
        'type': 'Routine',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Medical Records',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: records.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final rec = records[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.show_chart_rounded,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rec['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${rec['doctor']} • ${rec['date']}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

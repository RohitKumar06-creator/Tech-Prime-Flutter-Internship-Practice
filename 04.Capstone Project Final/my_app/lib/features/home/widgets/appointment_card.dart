import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/doctor_model.dart';
import '../../booking/booking_detail_screen.dart';

class AppointmentCard extends StatelessWidget {
  final DoctorModel doctor;
  final String date;
  final String time;

  const AppointmentCard({
    super.key,
    required this.doctor,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookingDetailScreen(
              doctorId: doctor.id ?? '',
              doctorName: doctor.name ?? 'Doctor',
              specialty: doctor.specialization,
              selectedDateTime:
                  DateTime.now(), // Or combine date and time if available
              appointmentType: 'In Person',
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date & Action Header Row
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 18,
                  color: AppColors.textDark,
                ),
                const SizedBox(width: 8),
                Text(
                  '$date  •  $time',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.more_vert,
                  color: AppColors.textMuted,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(color: Colors.grey.shade200, height: 1),
            const SizedBox(height: 16),

            // Doctor Information Row
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: doctor.imageUrl != null
                      ? NetworkImage(doctor.imageUrl!)
                      : null,
                  child: doctor.imageUrl == null
                      ? const Icon(Icons.person, color: Colors.grey, size: 30)
                      : null,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialization,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Experience: ${doctor.experience}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

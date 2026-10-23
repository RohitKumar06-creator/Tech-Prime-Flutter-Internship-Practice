import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/doctor_model.dart';
import '../../models/notification_model.dart';
import '../home/widgets/appointment_card.dart';
import 'widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Pending Approval Doctor details[cite: 22]
    final DoctorModel pendingDoctor = DoctorModel(
      id: 'doc_pending',
      name: 'dr. Nirmala Azalea',
      specialization: 'Surgery',
      experience: '5 Years',
      imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=200&auto=format&fit=crop',
    );

    // Dummy list for Earlier Notifications[cite: 22]
    final List<NotificationModel> earlierNotifications = [
      NotificationModel(
        id: 'notif_1',
        avatarUrl: 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?q=80&w=200&auto=format&fit=crop',
        date: 'Jun 20',
        time: '8:00 AM',
        message: 'Lorem ipsum dolor sit amet cosectures adipsing chalengge',
      ),
      NotificationModel(
        id: 'notif_2',
        avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
        date: 'Jun 20',
        time: '8:00 AM',
        message: 'Lorem ipsum dolor sit amet cosectures adipsing chalengge',
      ),
      NotificationModel(
        id: 'notif_3',
        avatarUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=200&auto=format&fit=crop',
        date: 'Jun 20',
        time: '8:00 AM',
        message: 'Lorem ipsum dolor sit amet cosectures adipsing chalengge',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pending Approval Section Title[cite: 22]
              const Text(
                'Pending Approval',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 16),

              // Pending Appointment Card Stack with Video Call Badge[cite: 22]
              Stack(
                children: [
                  AppointmentCard(
                    doctor: pendingDoctor,
                    date: 'Wed Jun 20',
                    time: '8:00 - 8:30 AM',
                  ),
                  // Green Video Call Indicator Icon over Doctor Avatar
                  Positioned(
                    left: 56,
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.videocam_rounded,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Earlier Notification Section Title[cite: 22]
              const Text(
                'Earlier Notification',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 12),

              // List of Earlier Notifications[cite: 22]
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: earlierNotifications.length,
                separatorBuilder: (_, __) =>
                    Divider(color: Colors.grey.shade100, height: 1),
                itemBuilder: (context, index) {
                  return NotificationTile(
                    notification: earlierNotifications[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

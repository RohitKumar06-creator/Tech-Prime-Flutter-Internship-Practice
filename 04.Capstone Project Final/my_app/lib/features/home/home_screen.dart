import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../ambulance/ambulance_screen.dart';
import '../appointments/appointments_screen.dart';
import '../chat/chat_list_screen.dart';
import '../consultation/consultation_screen.dart';
import '../medicines/medicines_screen.dart';
import '../profile/profile_screen.dart';
import '../profile/viewmodels/profile_viewmodel.dart';
import '../waiting_room/waiting_room_screen.dart'; // Adjust path if your waiting room screen is located elsewhere

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeContentView(
        onSeeAllAppointments: () {
          setState(() => _currentIndex = 1);
        },
      ),
      const AppointmentsScreen(),
      const ChatListScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF26C6DA),
          unselectedItemColor: AppColors.textMuted,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 28),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subtitles_outlined, size: 26),
              activeIcon: Icon(Icons.subtitles_rounded, size: 26),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline_rounded, size: 24),
              activeIcon: Icon(Icons.chat_bubble_rounded, size: 24),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded, size: 28),
              activeIcon: Icon(Icons.person_rounded, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class HomeContentView extends StatelessWidget {
  final VoidCallback onSeeAllAppointments;

  const HomeContentView({super.key, required this.onSeeAllAppointments});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<ProfileViewModel>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Container with Light Blue Gradient
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF80E8FF), Color(0xFFE0F7FA)],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: Column(
                  children: [
                    // Top Bar: Avatar & Notification Bell
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: AppColors.textDark,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Welcome White Card Overlay
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            top: 24,
                            bottom: 44,
                            left: 16,
                            right: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'WELCOME BACK!',
                                style: TextStyle(
                                  fontSize: 12,
                                  letterSpacing: 0.8,
                                  color: AppColors.textMuted,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                profileViewModel.displayName,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Have a nice day ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  Text('😊', style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Floating "Find Doctor" Action Button -> Opens ConsultationScreen
                        Positioned(
                          bottom: -22,
                          child: SizedBox(
                            height: 44,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const ConsultationScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF26C6DA),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              icon: const Icon(
                                Icons.medical_services_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                              label: const Text(
                                'Find Doctor',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),

          // Main Body Content
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Waiting Room Banner Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF80E8FF), Color(0xFF26C6DA)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.white,
                        size: 36,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Your appointment is ready',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Enter Waiting Room',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF00ACC1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WaitingRoomScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Join',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // EHealthcare Services Section
                const Text(
                  'EHealthcare Services',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildServiceItem(
                      context,
                      imagePath: 'assets/images/doctor.png',
                      label: 'Consultation',
                      bgColor: const Color(0xFFE0F7FA),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ConsultationScreen(),
                          ),
                        );
                      },
                    ),
                    _buildServiceItem(
                      context,
                      imagePath: 'assets/images/medicine.png',
                      label: 'Medicines',
                      bgColor: const Color(0xFFE1F5FE),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MedicinesScreen(),
                          ),
                        );
                      },
                    ),
                    _buildServiceItem(
                      context,
                      imagePath: 'assets/images/ambulance.png',
                      label: 'Ambulance',
                      bgColor: const Color(0xFFFFEBEE),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AmbulanceScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // My Appointment Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Appointment',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    TextButton(
                      onPressed: onSeeAllAppointments,
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF26C6DA),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Appointment Summary Card
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Appointment Summary',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 12),
                            const Text(
                              'Doctor: dr. Nirmala Azalea (Orthopedic)',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Date & Time: Wed Jun 20 • 8:00 - 8:30 AM',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Status: Confirmed & Paid',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF4FC3F7),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Appointment date',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      size: 15,
                                      color: AppColors.textDark,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      'Wed Jun 20  •  8:00 - 8:30 AM',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: AppColors.textMuted,
                                size: 20,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                        ),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=200&auto=format&fit=crop',
                              ),
                            ),
                            const SizedBox(width: 14),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'dr. Nirmala Azalea',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textDark,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Orthopedic',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
    BuildContext context, {
    required String imagePath,
    required String label,
    required Color bgColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 64,
            height: 64,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}

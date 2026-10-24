import 'package:flutter/material.dart';
import 'package:my_app/features/profile/clinic_info_screen.dart';
import 'package:my_app/features/profile/insurance_detail_screen.dart';
import 'package:my_app/features/profile/medical_records_screen.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import 'account_information_screen.dart';
import 'settings_screen.dart';
import 'viewmodels/profile_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_none_rounded,
                            color: AppColors.textDark,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Profile User Banner Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4FC3F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                viewModel.firstName.isNotEmpty
                                    ? viewModel.firstName
                                    : (viewModel.username.isNotEmpty
                                          ? viewModel.username
                                          : 'User'),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                viewModel.email,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    const Text(
                      'General',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 12),

                    _buildMenuItem(
                      context,
                      icon: Icons.person_outline_rounded,
                      iconBgColor: const Color(0xFFE1F5FE),
                      iconColor: const Color(0xFF03A9F4),
                      title: 'Account Information',
                      subtitle: 'Change your account information',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: viewModel,
                              child: const AccountInformationScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                    // Inside ProfileScreen menu items:
                    _buildMenuItem(
                      context,
                      icon: Icons.credit_card_rounded,
                      iconBgColor: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF4CAF50),
                      title: 'Insurance Detail',
                      subtitle: 'Add your insurance info',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InsuranceDetailScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.show_chart_rounded,
                      iconBgColor: const Color(0xFFFFF8E1),
                      iconColor: const Color(0xFFFFB300),
                      title: 'Medical Records',
                      subtitle: 'History about you medical records',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MedicalRecordsScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.local_hospital_outlined,
                      iconBgColor: const Color(0xFFF3E5F5),
                      iconColor: const Color(0xFFAB47BC),
                      title: 'Clinic Info',
                      subtitle: 'Information about our Clinic',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ClinicInfoScreen(),
                          ),
                        );
                      },
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.settings_outlined,
                      iconBgColor: const Color(0xFFE8EAF6),
                      iconColor: const Color(0xFF3F51B5),
                      title: 'Settings',
                      subtitle: 'Manage & Settings',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: viewModel,
                              child: const SettingsScreen(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}

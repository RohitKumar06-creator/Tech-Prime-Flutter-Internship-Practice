import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class ClinicInfoScreen extends StatelessWidget {
  const ClinicInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Clinic Info',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: ColoredBox(
                    color: Color(0xFFE0F7FA),
                    child: Center(
                      child: Icon(
                        Icons.local_hospital,
                        size: 64,
                        color: Color(0xFF00ACC1),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'EHealthcare Central Clinic',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Jl. Sudirman No. 45, Bandung, West Java',
                style: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                'Operating Hours',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text('Monday - Friday: 08:00 AM - 09:00 PM'),
              const Text('Saturday - Sunday: 09:00 AM - 05:00 PM'),
              const SizedBox(height: 20),
              const Text(
                'Emergency Hotline',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                '+62 22 555-0199',
                style: TextStyle(
                  color: Color(0xFF00ACC1),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

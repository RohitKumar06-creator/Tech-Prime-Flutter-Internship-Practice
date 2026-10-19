import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/appointment_model.dart';
import '../../models/doctor_model.dart';
import '../home/widgets/appointment_card.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Local static list containing the data from your Figma design
  final List<AppointmentModel> _dummyAppointments = [
    AppointmentModel(
      id: 'app_1',
      date: 'Wed Jun 20',
      time: '8:00 - 8:30 AM',
      doctor: DoctorModel(
        id: 'doc_1',
        name: 'dr. Nirmala Azalea',
        specialization: 'Orthopedic',
        experience: '5 Years',
        imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=200&auto=format&fit=crop',
      ),
    ),
    AppointmentModel(
      id: 'app_2',
      date: 'Thu Jun 21',
      time: '8:00 - 8:30 AM',
      doctor: DoctorModel(
        id: 'doc_2',
        name: 'Dr. Narendra Joko',
        specialization: 'Obstetrician',
        experience: '8 Years',
        imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=200&auto=format&fit=crop',
      ),
    ),
  ];

  List<AppointmentModel> _filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    _filteredAppointments = _dummyAppointments;
  }

  void _filterAppointments(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAppointments = _dummyAppointments;
      } else {
        _filteredAppointments = _dummyAppointments.where((item) {
          final docName = item.doctor.name.toLowerCase();
          final spec = item.doctor.specialization.toLowerCase();
          final input = query.toLowerCase();
          return docName.contains(input) || spec.contains(input);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Screen Header Title & Notification Icon[cite: 21]
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Appointments',
                    style: TextStyle(
                      fontSize: 26,
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
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar[cite: 21]
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterAppointments,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 15,
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.textMuted,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Appointments List Section[cite: 21]
              Expanded(
                child: _filteredAppointments.isEmpty
                    ? const Center(
                        child: Text(
                          'No appointments found',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _filteredAppointments.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final appointment = _filteredAppointments[index];
                          return AppointmentCard(
                            doctor: appointment.doctor,
                            date: appointment.date,
                            time: appointment.time,
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

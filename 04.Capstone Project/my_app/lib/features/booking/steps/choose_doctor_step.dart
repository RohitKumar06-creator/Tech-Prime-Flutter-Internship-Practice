import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/doctor_model.dart';

class ChooseDoctorStep extends StatefulWidget {
  final DoctorModel? selectedDoctor;
  final Function(DoctorModel) onDoctorSelected;

  const ChooseDoctorStep({
    super.key,
    required this.selectedDoctor,
    required this.onDoctorSelected,
  });

  @override
  State<ChooseDoctorStep> createState() => _ChooseDoctorStepState();
}

class _ChooseDoctorStepState extends State<ChooseDoctorStep> {
  final List<DoctorModel> _doctors = [
    DoctorModel(
      id: 'doc_1',
      name: 'dr. Nirmala Azalea',
      specialization: 'Orthopedic',
      experience: '50+',
      imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=200&auto=format&fit=crop',
    ),
    DoctorModel(
      id: 'doc_2',
      name: 'dr. Agus Subandono',
      specialization: 'Pediatric',
      experience: '30+',
      imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=200&auto=format&fit=crop',
    ),
    DoctorModel(
      id: 'doc_3',
      name: 'dr. Bambang Sucat Pelat',
      specialization: 'Neurosurgeon',
      experience: '20+',
      imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=200&auto=format&fit=crop',
    ),
    DoctorModel(
      id: 'doc_4',
      name: 'dr. Desi Sulawesi',
      specialization: 'Obstetrician',
      experience: '50+',
      imageUrl: 'https://images.unsplash.com/photo-1594824813566-7885a3977336?q=80&w=200&auto=format&fit=crop',
    ),
  ];

  List<DoctorModel> _filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    _filteredDoctors = _doctors;
  }

  void _filterDoctors(String query) {
    setState(() {
      _filteredDoctors = _doctors
          .where(
            (d) =>
                d.name.toLowerCase().contains(query.toLowerCase()) ||
                d.specialization.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Doctor',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: _filterDoctors,
          decoration: const InputDecoration(
            hintText: 'Search doctor',
            prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryBlue),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            itemCount: _filteredDoctors.length,
            separatorBuilder: (_, __) => Divider(color: Colors.grey.shade100),
            itemBuilder: (context, index) {
              final doc = _filteredDoctors[index];
              final isSelected = widget.selectedDoctor?.id == doc.id;
              return ListTile(
                onTap: () => widget.onDoctorSelected(doc),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                leading: isSelected
                    ? Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 28,
                        ),
                      )
                    : CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(doc.imageUrl!),
                      ),
                title: Text(
                  doc.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc.specialization,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ...List.generate(
                          4,
                          (_) => const Icon(
                            Icons.star_border,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 6),
                        Text(
                          '${doc.experience}+',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textDark,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: const Text(
                  '\$12',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.textDark,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

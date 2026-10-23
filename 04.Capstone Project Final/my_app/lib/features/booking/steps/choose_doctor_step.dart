import 'package:flutter/material.dart';

import '../../../../models/doctor_model.dart';

class ChooseDoctorStep extends StatelessWidget {
  final DoctorModel? selectedDoctor;
  final List<DoctorModel> doctors;
  final ValueChanged<String> onSearch;
  final ValueChanged<DoctorModel> onDoctorSelected;

  const ChooseDoctorStep({
    super.key,
    required this.selectedDoctor,
    required this.doctors,
    required this.onSearch,
    required this.onDoctorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Doctor',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: onSearch,
          decoration: InputDecoration(
            hintText: 'Search doctor',
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: doctors.length,
            separatorBuilder: (_, __) => const Divider(height: 24),
            itemBuilder: (context, index) {
              final doc = doctors[index];
              final isSelected = selectedDoctor?.id == doc.id;

              return InkWell(
                onTap: () => onDoctorSelected(doc),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      isSelected
                          ? Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4FC3F7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            )
                          : CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(doc.imageUrl ?? ''),
                              backgroundColor: Colors.grey.shade200,
                            ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              doc.specialization,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 14,
                                ),
                                const Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${doc.experience}+',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        '\$12',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
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

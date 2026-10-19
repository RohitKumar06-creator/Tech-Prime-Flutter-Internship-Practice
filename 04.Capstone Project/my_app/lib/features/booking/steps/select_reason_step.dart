import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SelectReasonStep extends StatefulWidget {
  final String? selectedReason;
  final Function(String) onReasonSelected;

  const SelectReasonStep({
    super.key,
    required this.selectedReason,
    required this.onReasonSelected,
  });

  @override
  State<SelectReasonStep> createState() => _SelectReasonStepState();
}

class _SelectReasonStepState extends State<SelectReasonStep> {
  final List<String> _reasons = [
    'Appendicitis',
    'Backache',
    'Bone fracture',
    'Cold',
    'Constipation',
    'Cough',
    'Diarrhea',
    'Dizzy',
  ];

  List<String> _filteredReasons = [];

  @override
  void initState() {
    super.initState();
    _filteredReasons = _reasons;
  }

  void _filterReasons(String query) {
    setState(() {
      _filteredReasons = _reasons
          .where((r) => r.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Reason',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          onChanged: _filterReasons,
          decoration: const InputDecoration(
            hintText: 'Search reason',
            prefixIcon: Icon(Icons.search, color: AppColors.textMuted),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryBlue),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: _filteredReasons.length,
            separatorBuilder: (_, __) => Divider(color: Colors.grey.shade100),
            itemBuilder: (context, index) {
              final reason = _filteredReasons[index];
              final isSelected = widget.selectedReason == reason;
              return ListTile(
                onTap: () => widget.onReasonSelected(reason),
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
                title: Text(
                  reason,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: AppColors.textDark,
                  ),
                ),
                trailing: isSelected
                    ? Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      )
                    : null,
              );
            },
          ),
        ),
      ],
    );
  }
}

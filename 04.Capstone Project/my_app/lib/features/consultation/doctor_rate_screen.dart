import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'call_thank_you_screen.dart';

class DoctorRateScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String doctorAvatarUrl;

  const DoctorRateScreen({
    super.key,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.doctorAvatarUrl,
  });

  @override
  State<DoctorRateScreen> createState() => _DoctorRateScreenState();
}

class _DoctorRateScreenState extends State<DoctorRateScreen> {
  int _selectedRating = 4; // Default 4 stars matching Figma design[cite: 33]
  int _selectedEmojiIndex = 2; // Default happy face[cite: 33]
  final TextEditingController _reviewController = TextEditingController();

  final List<String> _emojiLabels = ['🙂', '😊', '😁', '🤩'];

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: const CallThankYouScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Light Blue Header with Doctor Profile Avatar[cite: 33]
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 12,
                  bottom: 28,
                  left: 20,
                  right: 20,
                ),
                decoration: const BoxDecoration(color: Color(0xFF4FC3F7)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Doctor Rate',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Doctor Profile Avatar Circle[cite: 33]
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                          image: NetworkImage(widget.doctorAvatarUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      widget.doctorName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.doctorSpecialization,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  children: [
                    // Give Rate Section[cite: 33]
                    const Text(
                      'Give Rate',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Interactive Star Scale[cite: 33]
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        final starNumber = index + 1;
                        final isFilled = starNumber <= _selectedRating;
                        return GestureDetector(
                          onTap: () {
                            setState(() => _selectedRating = starNumber);
                          },
                          child: AnimatedScale(
                            scale: isFilled ? 1.15 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Icon(
                                isFilled
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: isFilled
                                    ? const Color(0xFFFFC107)
                                    : Colors.grey.shade300,
                                size: 38,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 28),

                    // Give Review Text Input Section[cite: 33]
                    const Text(
                      'Give Review',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _reviewController,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Write review here',
                        hintStyle: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFE0E0E0)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.primaryBlue),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Ecare Experience Emojis Section[cite: 33]
                    const Text(
                      'How was Ecare experience',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(_emojiLabels.length, (index) {
                        final isSelected = _selectedEmojiIndex == index;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedEmojiIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 56,
                            height: 56,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? const Color(0xFF4FC3F7)
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF4FC3F7)
                                    : Colors.grey.shade200,
                                width: 1.5,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF4FC3F7)
                                            .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Text(
                              _emojiLabels[index],
                              style: const TextStyle(fontSize: 26),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 36),

                    // Submit Review Button[cite: 33]
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _submitReview,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Submit Review',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

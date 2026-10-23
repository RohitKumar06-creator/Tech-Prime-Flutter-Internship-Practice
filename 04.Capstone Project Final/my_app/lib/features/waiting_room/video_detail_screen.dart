import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/media_content_model.dart';

class VideoDetailScreen extends StatefulWidget {
  final MediaContentModel media;

  const VideoDetailScreen({super.key, required this.media});

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  bool _isPlaying = false;
  double _sliderValue = 0.75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Video Player View Container with Overlay Controls[cite: 30]
            SizedBox(
              height: 320,
              width: double.infinity,
              child: Stack(
                children: [
                  // Video Frame Background Image[cite: 30]
                  Positioned.fill(
                    child: Image.network(
                      widget.media.thumbnailUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Dark Vignette Overlay
                  Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.35)),
                  ),

                  // Top Action Bar (Back & Cast Icons)[cite: 30]
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 12,
                    right: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.cast_rounded,
                            color: Colors.white,
                            size: 22,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Center Playback Controls (Previous, Play/Pause, Next)[cite: 30]
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Previous',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _isPlaying = !_isPlaying),
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isPlaying
                                  ? Icons.play_arrow_rounded
                                  : Icons.pause_rounded,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.skip_next_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Bottom Progress Scrub Bar & Time Indicator[cite: 30]
                  Positioned(
                    bottom: 12,
                    left: 16,
                    right: 16,
                    child: Row(
                      children: [
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 3,
                              thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 6,
                              ),
                              overlayShape: const RoundSliderOverlayShape(
                                overlayRadius: 12,
                              ),
                              activeTrackColor: Colors.redAccent,
                              inactiveTrackColor: Colors.white.withOpacity(0.5),
                              thumbColor: Colors.redAccent,
                            ),
                            child: Slider(
                              value: _sliderValue,
                              onChanged: (val) =>
                                  setState(() => _sliderValue = val),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '-02.47',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.fullscreen_rounded,
                          color: Colors.white,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Video Description & Content Section[cite: 30]
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.media.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.media.duration,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.media.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.textDark,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

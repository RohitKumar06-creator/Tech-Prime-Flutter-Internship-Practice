import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/media_content_model.dart';
import 'video_detail_screen.dart';

class WaitingRoomScreen extends StatefulWidget {
  const WaitingRoomScreen({super.key});

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  int _selectedTab = 0; // 0: Video, 1: Audio, 2: E-Book

  // Mock data tailored for each media type
  final Map<int, List<MediaContentModel>> _mediaCategories = {
    0: [
      MediaContentModel(
        id: 'v1',
        title: 'Understanding Your Heart Health',
        duration: '15 mins',
        thumbnailUrl: 'https://images.unsplash.com/photo-1579684385127-1ef15d508118?q=80&w=600&auto=format&fit=crop',
        description: 'Learn simple everyday habits to maintain optimal cardiovascular health and manage blood pressure naturally.',
      ),
      MediaContentModel(
        id: 'v2',
        title: 'Orthopedic Stretching Basics',
        duration: '10 mins',
        thumbnailUrl: 'https://images.unsplash.com/photo-1629909613654-28e377c37b09?q=80&w=600&auto=format&fit=crop',
        description: 'Easy guided stretches to relieve joint stiffness and lower back discomfort while working from home.',
      ),
    ],
    1: [
      MediaContentModel(
        id: 'a1',
        title: 'Guided Mindfulness & Stress Relief',
        duration: '20 mins',
        thumbnailUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=600&auto=format&fit=crop',
        description: 'A soothing audio session designed to calm your nervous system before your medical consultation.',
      ),
    ],
    2: [
      MediaContentModel(
        id: 'e1',
        title: 'Healthy Nutrition Guide 2026',
        duration: '8 min read',
        thumbnailUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352?q=80&w=600&auto=format&fit=crop',
        description: 'Comprehensive e-book covering balanced meal prepping, macronutrients, and immune-boosting vitamins.',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentList = _mediaCategories[_selectedTab] ?? [];

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
          'Waiting Room',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Segmented Tab Toggle (Video, Audio, E-Book)
              Container(
                height: 50,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    _buildTabButton('Video', 0),
                    _buildTabButton('Audio', 1),
                    _buildTabButton('E-Book', 2),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Media List View based on active tab
              Expanded(
                child: currentList.isEmpty
                    ? const Center(
                        child: Text(
                          'No content available in this section.',
                          style: TextStyle(color: AppColors.textMuted),
                        ),
                      )
                    : ListView.separated(
                        itemCount: currentList.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = currentList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      VideoDetailScreen(media: item),
                                ),
                              );
                            },
                            child: Container(
                              height: 180,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.network(
                                      item.thumbnailUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.black.withOpacity(0.3),
                                    ),
                                  ),
                                  Positioned(
                                    top: 16,
                                    left: 16,
                                    right: 16,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          item.duration,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _selectedTab == 2
                                            ? Icons.menu_book_rounded
                                            : Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 32,
                                      ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.textDark : AppColors.textMuted,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

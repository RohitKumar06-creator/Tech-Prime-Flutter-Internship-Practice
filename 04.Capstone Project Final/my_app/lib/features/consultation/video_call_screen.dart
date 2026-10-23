import 'dart:async';

import 'package:flutter/material.dart';

import 'doctor_rate_screen.dart';

class VideoCallScreen extends StatefulWidget {
  final String doctorName;
  final String doctorSpecialization;
  final String doctorAvatarUrl;

  const VideoCallScreen({
    super.key,
    this.doctorName = 'dr. Nirmala Azalea',
    this.doctorSpecialization = 'Orthopedic',
    this.doctorAvatarUrl = 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=600&auto=format&fit=crop',
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isFrontCamera = true;

  // Live Timer State
  int _secondsElapsed = 337; // Starts at 05:37 to match design
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _secondsElapsed++);
      }
    });
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _endCall() {
    _timer?.cancel();
    // Navigate with smooth fade animation to Doctor Rate Screen
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: DoctorRateScreen(
            doctorName: widget.doctorName,
            doctorSpecialization: widget.doctorSpecialization,
            doctorAvatarUrl: widget.doctorAvatarUrl,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Doctor Remote Video Stream Frame (Full Screen)
          Positioned.fill(
            child: Image.network(widget.doctorAvatarUrl, fit: BoxFit.cover),
          ),

          // Vignette Overlay Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),

          // Local User Camera Floating Window (Top Left PIP)
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 110,
                height: 140,
                color: Colors.grey.shade900,
                child: _isVideoOff
                    ? const Center(
                        child: Icon(
                          Icons.videocam_off,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    : Image.network(
                        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=300&auto=format&fit=crop',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),

          // Top Right Camera Switch Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: GestureDetector(
              onTap: () {
                setState(() => _isFrontCamera = !_isFrontCamera);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _isFrontCamera
                          ? 'Switched to Front Camera'
                          : 'Switched to Rear Camera',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flip_camera_ios_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),

          // Bottom Call Controls Bar
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Live Call Duration Timer
                Text(
                  _formatDuration(_secondsElapsed),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mute / Unmute Button
                    GestureDetector(
                      onTap: () => setState(() => _isMuted = !_isMuted),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _isMuted
                              ? Colors.redAccent
                              : const Color(0xFF4FC3F7),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isMuted ? Icons.mic_off : Icons.mic,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // End Call Red Button
                    GestureDetector(
                      onTap: _endCall,
                      child: Container(
                        width: 68,
                        height: 68,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent,
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.call_end_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    // Video On / Off Toggle Button
                    GestureDetector(
                      onTap: () => setState(() => _isVideoOff = !_isVideoOff),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _isVideoOff
                              ? Colors.grey.shade700
                              : const Color(0xFF2979FF),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isVideoOff
                              ? Icons.videocam_off
                              : Icons.videocam_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

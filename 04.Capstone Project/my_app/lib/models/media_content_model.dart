class MediaContentModel {
  final String id;
  final String title;
  final String duration;
  final String thumbnailUrl;
  final String description;
  final String mediaType; // video, audio, ebook

  MediaContentModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.thumbnailUrl,
    required this.description,
    this.mediaType = 'video',
  });

  factory MediaContentModel.fromMap(Map<String, dynamic> map, String docId) {
    return MediaContentModel(
      id: docId,
      title: map['title'] ?? 'Video Title',
      duration: map['duration'] ?? '20 minutes',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      description: map['description'] ?? '',
      mediaType: map['mediaType'] ?? 'video',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'duration': duration,
      'thumbnailUrl': thumbnailUrl,
      'description': description,
      'mediaType': mediaType,
    };
  }
}

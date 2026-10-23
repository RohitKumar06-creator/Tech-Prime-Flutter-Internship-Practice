class NotificationModel {
  final String id;
  final String avatarUrl;
  final String date;
  final String time;
  final String message;

  NotificationModel({
    required this.id,
    required this.avatarUrl,
    required this.date,
    required this.time,
    required this.message,
  });

  // Factory constructor for future Firestore document parsing
  factory NotificationModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return NotificationModel(
      id: documentId,
      avatarUrl: map['avatarUrl'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      message: map['message'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avatarUrl': avatarUrl,
      'date': date,
      'time': time,
      'message': message,
    };
  }
}

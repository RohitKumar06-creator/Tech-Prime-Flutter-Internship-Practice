class ChatConversationModel {
  final String id;
  final String name;
  final String role; // Doctor, Admin, etc.
  final String avatarUrl;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  ChatConversationModel({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  factory ChatConversationModel.fromMap(
    Map<String, dynamic> map,
    String docId,
  ) {
    return ChatConversationModel(
      id: docId,
      name: map['name'] ?? '',
      role: map['role'] ?? 'Doctor',
      avatarUrl: map['avatarUrl'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
      time: map['time'] ?? '',
      unreadCount: map['unreadCount'] ?? 0,
      isOnline: map['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'role': role,
      'avatarUrl': avatarUrl,
      'lastMessage': lastMessage,
      'time': time,
      'unreadCount': unreadCount,
      'isOnline': isOnline,
    };
  }
}

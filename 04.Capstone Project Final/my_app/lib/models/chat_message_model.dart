class ChatMessageModel {
  final String id;
  final String text;
  final String time;
  final bool isMe;

  ChatMessageModel({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
  });

  factory ChatMessageModel.fromMap(Map<String, dynamic> map, String docId) {
    return ChatMessageModel(
      id: docId,
      text: map['text'] ?? '',
      time: map['time'] ?? '',
      isMe: map['isMe'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {'text': text, 'time': time, 'isMe': isMe};
  }
}

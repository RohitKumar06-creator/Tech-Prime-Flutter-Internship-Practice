import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/chat_message_model.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String specialization;
  final String avatarUrl;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.specialization,
    required this.avatarUrl,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

  // Initial messages matching Figma screen[cite: 34]
  final List<ChatMessageModel> _messages = [
    ChatMessageModel(id: 'm1', text: 'Halo, Doc', time: '08:50 AM', isMe: true),
    ChatMessageModel(
      id: 'm2',
      text: 'why does my back hurt so much?',
      time: '08:50 AM',
      isMe: true,
    ),
    ChatMessageModel(
      id: 'm3',
      text: 'You sit too long. Try drinking lots of water',
      time: '08:01 Am',
      isMe: false,
    ),
    ChatMessageModel(
      id: 'm4',
      text: 'Oh like that.',
      time: '08:50 AM',
      isMe: true,
    ),
    ChatMessageModel(
      id: 'm5',
      text: 'ok doc. I will drink lots of water and exercise.',
      time: '08:50 AM',
      isMe: true,
    ),
    ChatMessageModel(
      id: 'm6',
      text: 'Thanks a lot doc 😍',
      time: '08:50 AM',
      isMe: true,
    ),
    ChatMessageModel(
      id: 'm7',
      text: 'Don\'t mention it beby 👍',
      time: '08:01 Am',
      isMe: false,
    ),
  ];

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
          time: '08:50 AM',
          isMe: true,
        ),
      );
    });
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textDark,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.avatarUrl),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C853),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                Text(
                  widget.specialization,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat Messages List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final showTimeHeader =
                      index == 0 || index == 2 || index == 3 || index == 6;

                  return Column(
                    crossAxisAlignment: msg.isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      if (showTimeHeader)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: msg.isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Text(
                              msg.time,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 12.0,
                        ),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        decoration: BoxDecoration(
                          color: msg.isMe
                              ? const Color(0xFF4FC3F7)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            topRight: const Radius.circular(20),
                            bottomLeft: Radius.circular(msg.isMe ? 20 : 4),
                            bottomRight: Radius.circular(msg.isMe ? 4 : 20),
                          ),
                          boxShadow: [
                            if (!msg.isMe)
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        child: Text(
                          msg.text,
                          style: TextStyle(
                            fontSize: 14,
                            color: msg.isMe ? Colors.white : AppColors.textDark,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // Bottom Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.attach_file,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: AppColors.textMuted,
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Type message...',
                        hintStyle: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: AppColors.primaryBlue,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

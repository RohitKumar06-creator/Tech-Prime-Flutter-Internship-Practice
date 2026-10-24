import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import 'viewmodels/chat_viewmodel.dart';

class ChatDetailScreen extends StatefulWidget {
  final String chatId;
  final String name;
  final String specialization;
  final String avatarUrl;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.name,
    required this.specialization,
    required this.avatarUrl,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSend(ChatViewModel viewModel) {
    if (_messageController.text.trim().isNotEmpty) {
      viewModel.sendMessage(widget.chatId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ChatViewModel>(context);
    final messages = viewModel.getMessagesForChat(widget.chatId);

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
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(widget.avatarUrl),
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
            Expanded(
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        'No messages yet. Start the consultation.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return Align(
                          alignment: msg.isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.75,
                            ),
                            decoration: BoxDecoration(
                              color: msg.isMe
                                  ? const Color(0xFF4FC3F7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color: msg.isMe
                                    ? Colors.white
                                    : AppColors.textDark,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: (_) => _handleSend(viewModel),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Color(0xFF4FC3F7),
                    ),
                    onPressed: () => _handleSend(viewModel),
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

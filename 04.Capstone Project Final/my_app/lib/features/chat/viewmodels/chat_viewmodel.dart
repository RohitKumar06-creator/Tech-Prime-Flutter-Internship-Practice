import 'package:flutter/material.dart';

import '../../../models/chat_conversation_model.dart';
import '../../../models/chat_message_model.dart';

class ChatViewModel extends ChangeNotifier {
  String _searchQuery = '';

  // Active conversations list
  final List<ChatConversationModel> _conversations = [
    ChatConversationModel(
      id: 'conv_1',
      name: 'dr. Nirmala Azalea',
      role: 'Doctor',
      lastMessage: 'Hello doc!',
      time: '11:20',
      unreadCount: 2,
      isOnline: true,
      avatarUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=200&auto=format&fit=crop',
    ),
    ChatConversationModel(
      id: 'conv_2',
      name: 'dr. Rakabuming Suhu',
      role: 'Doctor',
      lastMessage: 'My progress is getting better. Thank yo...',
      time: '11:20',
      unreadCount: 0,
      isOnline: false,
      avatarUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=200&auto=format&fit=crop',
    ),
    ChatConversationModel(
      id: 'conv_3',
      name: 'Beby Jovanca',
      role: 'Admin',
      lastMessage: 'When I can get notification about my pa...',
      time: '11:20',
      unreadCount: 0,
      isOnline: false,
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
    ),
    ChatConversationModel(
      id: 'conv_4',
      name: 'dr. Zhafira Ulya',
      role: 'Doctor',
      lastMessage: 'Just take a rest and don\'t get too tired.',
      time: '11:20',
      unreadCount: 0,
      isOnline: false,
      avatarUrl: 'https://images.unsplash.com/photo-1594824813566-7885a3977336?q=80&w=200&auto=format&fit=crop',
    ),
  ];

  // Active messages list for detail view
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

  // Getters
  List<ChatMessageModel> get messages => _messages;

  List<ChatConversationModel> get filteredConversations {
    if (_searchQuery.isEmpty) return _conversations;
    return _conversations
        .where(
          (c) =>
              c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              c.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  // Actions
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    _messages.add(
      ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: trimmed,
        time: '08:50 AM',
        isMe: true,
      ),
    );
    notifyListeners();
  }
}

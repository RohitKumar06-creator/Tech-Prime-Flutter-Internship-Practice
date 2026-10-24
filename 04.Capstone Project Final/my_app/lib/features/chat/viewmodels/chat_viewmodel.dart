import 'package:flutter/material.dart';

import '../../../models/chat_conversation_model.dart';
import '../../../models/chat_message_model.dart';
import '../../../models/doctor_model.dart';

enum ChatFilter { all, unread, doctors, admins }

class ChatViewModel extends ChangeNotifier {
  String _searchQuery = '';
  ChatFilter _activeFilter = ChatFilter.all;
  final Set<String> _mutedChatIds = {};

  // Individual message maps per chat ID to isolate conversation history
  final Map<String, List<ChatMessageModel>> _chatMessagesMap = {
    'conv_1': [
      ChatMessageModel(
        id: 'm1',
        text: 'Hello doc!',
        time: '11:20 AM',
        isMe: true,
      ),
      ChatMessageModel(
        id: 'm2',
        text: 'Your test results are stable.',
        time: '11:21 AM',
        isMe: false,
      ),
    ],
    'conv_2': [
      ChatMessageModel(
        id: 'm3',
        text: 'My progress is getting better. Thank you.',
        time: '10:45 AM',
        isMe: true,
      ),
    ],
  };

  ChatFilter get activeFilter => _activeFilter;
  bool isMuted(String chatId) => _mutedChatIds.contains(chatId);

  final List<ChatConversationModel> _conversations = [
    ChatConversationModel(
      id: 'conv_1',
      name: 'dr. Nirmala Azalea',
      role: 'Doctor',
      lastMessage: 'Hello doc!',
      time: '11:20 AM',
      unreadCount: 2,
      isOnline: true,
      avatarUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=200&auto=format&fit=crop',
    ),
    ChatConversationModel(
      id: 'conv_2',
      name: 'dr. Rakabuming Suhu',
      role: 'Doctor',
      lastMessage: 'My progress is getting better. Thank you.',
      time: '10:45 AM',
      unreadCount: 0,
      isOnline: false,
      avatarUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=200&auto=format&fit=crop',
    ),
    ChatConversationModel(
      id: 'conv_3',
      name: 'Beby Jovanca',
      role: 'Admin',
      lastMessage: 'When I can get notification about my patient status?',
      time: 'Yesterday',
      unreadCount: 1,
      isOnline: false,
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=200&auto=format&fit=crop',
    ),
  ];

  // Full list of available doctors for the "Add New Chat" list
  final List<DoctorModel> _allDoctors = [
    DoctorModel(
      id: '1',
      name: 'dr. Nirmala Azalea',
      specialization: 'Orthopedic',
      experience: '50+',
      imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=400',
    ),
    DoctorModel(
      id: '2',
      name: 'dr. Agus Subandono',
      specialization: 'Pediatric',
      experience: '30+',
      imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=400',
    ),
    DoctorModel(
      id: '3',
      name: 'dr. Bambang Sucat Pelat',
      specialization: 'Neurosurgeon',
      experience: '20+',
      imageUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=400',
    ),
    DoctorModel(
      id: '4',
      name: 'dr. Desi Sulawesi',
      specialization: 'Obstetrician',
      experience: '50+',
      imageUrl: 'https://images.unsplash.com/photo-1594824813566-78a933773322?q=80&w=400',
    ),
  ];

  List<DoctorModel> get availableDoctors => _allDoctors;

  int get totalUnreadCount =>
      _conversations.fold(0, (sum, item) => sum + item.unreadCount);

  List<ChatConversationModel> get filteredConversations {
    return _conversations.where((c) {
      final matchesSearch =
          c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.lastMessage.toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesSearch) return false;

      switch (_activeFilter) {
        case ChatFilter.unread:
          return c.unreadCount > 0;
        case ChatFilter.doctors:
          return c.role.toLowerCase() == 'doctor';
        case ChatFilter.admins:
          return c.role.toLowerCase() == 'admin';
        case ChatFilter.all:
          // default:
          return true;
      }
    }).toList();
  }

  List<ChatMessageModel> getMessagesForChat(String chatId) {
    return _chatMessagesMap[chatId] ?? [];
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setFilter(ChatFilter filter) {
    _activeFilter = filter;
    notifyListeners();
  }

  void markAsRead(String conversationId) {
    final index = _conversations.indexWhere((c) => c.id == conversationId);
    if (index != -1 && _conversations[index].unreadCount > 0) {
      final c = _conversations[index];
      _conversations[index] = ChatConversationModel(
        id: c.id,
        name: c.name,
        role: c.role,
        lastMessage: c.lastMessage,
        time: c.time,
        unreadCount: 0,
        isOnline: c.isOnline,
        avatarUrl: c.avatarUrl,
      );
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _conversations.length; i++) {
      if (_conversations[i].unreadCount > 0) {
        final c = _conversations[i];
        _conversations[i] = ChatConversationModel(
          id: c.id,
          name: c.name,
          role: c.role,
          lastMessage: c.lastMessage,
          time: c.time,
          unreadCount: 0,
          isOnline: c.isOnline,
          avatarUrl: c.avatarUrl,
        );
      }
    }
    notifyListeners();
  }

  void toggleMuteChat(String chatId) {
    if (_mutedChatIds.contains(chatId)) {
      _mutedChatIds.remove(chatId);
    } else {
      _mutedChatIds.add(chatId);
    }
    notifyListeners();
  }

  void deleteChat(String chatId) {
    _conversations.removeWhere((c) => c.id == chatId);
    _chatMessagesMap.remove(chatId);
    _mutedChatIds.remove(chatId);
    notifyListeners();
  }

  void clearChatHistory(String chatId) {
    _chatMessagesMap[chatId] = [];
    final index = _conversations.indexWhere((c) => c.id == chatId);
    if (index != -1) {
      final c = _conversations[index];
      _conversations[index] = ChatConversationModel(
        id: c.id,
        name: c.name,
        role: c.role,
        lastMessage: 'Conversation history cleared.',
        time: 'Just now',
        unreadCount: 0,
        isOnline: c.isOnline,
        avatarUrl: c.avatarUrl,
      );
    }
    notifyListeners();
  }

  ChatConversationModel startOrGetConversation(DoctorModel doctor) {
    final existingIndex = _conversations.indexWhere(
      (c) => c.name.toLowerCase() == doctor.name.toLowerCase(),
    );

    if (existingIndex != -1) {
      markAsRead(_conversations[existingIndex].id);
      return _conversations[existingIndex];
    }

    final newChatId = 'conv_${DateTime.now().millisecondsSinceEpoch}';
    final newConv = ChatConversationModel(
      id: newChatId,
      name: doctor.name,
      role: 'Doctor',
      lastMessage: 'Consultation channel initialized.',
      time: 'Just now',
      unreadCount: 0,
      isOnline: true,
      avatarUrl: doctor.imageUrl ?? 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=200',
    );

    _chatMessagesMap[newChatId] = [];
    _conversations.insert(0, newConv);
    notifyListeners();
    return newConv;
  }

  void sendMessage(String chatId, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    if (!_chatMessagesMap.containsKey(chatId)) {
      _chatMessagesMap[chatId] = [];
    }

    _chatMessagesMap[chatId]!.add(
      ChatMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: trimmed,
        time: 'Just now',
        isMe: true,
      ),
    );

    final index = _conversations.indexWhere((c) => c.id == chatId);
    if (index != -1) {
      final c = _conversations[index];
      _conversations[index] = ChatConversationModel(
        id: c.id,
        name: c.name,
        role: c.role,
        lastMessage: trimmed,
        time: 'Just now',
        unreadCount: c.unreadCount,
        isOnline: c.isOnline,
        avatarUrl: c.avatarUrl,
      );
    }

    notifyListeners();
  }
}

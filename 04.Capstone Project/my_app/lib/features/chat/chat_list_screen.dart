import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/chat_conversation_model.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
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

  List<ChatConversationModel> _filteredConversations = [];

  @override
  void initState() {
    super.initState();
    _filteredConversations = _conversations;
  }

  void _filterChats(String query) {
    setState(() {
      _filteredConversations = _conversations
          .where(
            (c) =>
                c.name.toLowerCase().contains(query.toLowerCase()) ||
                c.lastMessage.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Title Row with Add and Notification icons
              Row(
                children: [
                  const Text(
                    'Message',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.textDark,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.textDark,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar Row with Filter icon[cite: 35]
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        onChanged: _filterChats,
                        decoration: const InputDecoration(
                          hintText: 'Search message',
                          hintStyle: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: AppColors.textMuted,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.tune_rounded,
                      color: AppColors.textDark,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Conversations List[cite: 35]
              Expanded(
                child: ListView.separated(
                  itemCount: _filteredConversations.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: Colors.grey.shade100, height: 1),
                  itemBuilder: (context, index) {
                    final item = _filteredConversations[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatDetailScreen(
                              name: item.name,
                              specialization: item.role == 'Doctor'
                                  ? 'Orthopedic'
                                  : 'Admin',
                              avatarUrl: item.avatarUrl,
                            ),
                          ),
                        );
                      },
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundImage: NetworkImage(item.avatarUrl),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: item.isOnline
                                    ? const Color(0xFF00C853)
                                    : Colors.grey.shade400,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: AppColors.textDark,
                            ),
                          ),
                          Text(
                            item.time,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          Text(
                            item.role,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.lastMessage,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.textDark,
                                  ),
                                ),
                              ),
                              if (item.unreadCount > 0)
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryBlue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    item.unreadCount.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
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
}

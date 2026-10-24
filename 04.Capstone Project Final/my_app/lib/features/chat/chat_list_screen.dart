import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../models/chat_conversation_model.dart';
import 'chat_detail_screen.dart';
import 'viewmodels/chat_viewmodel.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  void _showChatLongPressOptions(
    BuildContext context,
    ChatConversationModel chat,
    ChatViewModel viewModel,
  ) {
    final isMuted = viewModel.isMuted(chat.id);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(chat.avatarUrl),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          chat.role,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(
                  isMuted
                      ? Icons.notifications_active_outlined
                      : Icons.notifications_off_outlined,
                  color: AppColors.textDark,
                ),
                title: Text(
                  isMuted ? 'Unmute Notifications' : 'Mute Notifications',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                onTap: () {
                  viewModel.toggleMuteChat(chat.id);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.cleaning_services_outlined,
                  color: AppColors.textDark,
                ),
                title: const Text(
                  'Clear History',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
                onTap: () {
                  viewModel.clearChatHistory(chat.id);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.redAccent,
                ),
                title: const Text(
                  'Delete Chat',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                onTap: () {
                  viewModel.deleteChat(chat.id);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showNotificationSheet(BuildContext context, ChatViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      viewModel.markAllAsRead();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Mark all as read',
                      style: TextStyle(
                        color: Color(0xFF4FC3F7),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (viewModel.totalUnreadCount == 0)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Center(
                    child: Text(
                      'No new unread message notifications.',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ),
                )
              else
                ...viewModel.filteredConversations
                    .where((c) => c.unreadCount > 0)
                    .map(
                      (c) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(c.avatarUrl),
                        ),
                        title: Text(
                          c.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          c.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4FC3F7),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${c.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context, ChatViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Messages',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 16),
              _buildFilterOption(
                context,
                title: 'All Messages',
                filter: ChatFilter.all,
                viewModel: viewModel,
              ),
              _buildFilterOption(
                context,
                title: 'Unread Only',
                filter: ChatFilter.unread,
                viewModel: viewModel,
              ),
              _buildFilterOption(
                context,
                title: 'Doctors Only',
                filter: ChatFilter.doctors,
                viewModel: viewModel,
              ),
              _buildFilterOption(
                context,
                title: 'Admins Only',
                filter: ChatFilter.admins,
                viewModel: viewModel,
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(
    BuildContext context, {
    required String title,
    required ChatFilter filter,
    required ChatViewModel viewModel,
  }) {
    final isSelected = viewModel.activeFilter == filter;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? const Color(0xFF4FC3F7) : AppColors.textDark,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: Color(0xFF4FC3F7))
          : null,
      onTap: () {
        viewModel.setFilter(filter);
        Navigator.pop(context);
      },
    );
  }

  void _showAddDoctorBottomSheet(
    BuildContext context,
    ChatViewModel viewModel,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.55,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New Chat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AppColors.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: viewModel.availableDoctors.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: Colors.grey.shade100, height: 1),
                  itemBuilder: (context, index) {
                    final doc = viewModel.availableDoctors[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 4),
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(doc.imageUrl ?? ''),
                      ),
                      title: Text(
                        doc.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.textDark,
                        ),
                      ),
                      subtitle: Text(
                        doc.specialization,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.chat_bubble_outline,
                        color: Color(0xFF4FC3F7),
                        size: 20,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        final conversation = viewModel.startOrGetConversation(
                          doc,
                        );

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: viewModel,
                              child: ChatDetailScreen(
                                chatId: conversation.id,
                                name: conversation.name,
                                specialization: conversation.role,
                                avatarUrl: conversation.avatarUrl,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Consumer<ChatViewModel>(
        builder: (context, viewModel, _) {
          final conversations = viewModel.filteredConversations;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Title Header Row
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
                        InkWell(
                          onTap: () =>
                              _showAddDoctorBottomSheet(context, viewModel),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
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
                        ),
                        const SizedBox(width: 10),

                        // Notification Button
                        InkWell(
                          onTap: () =>
                              _showNotificationSheet(context, viewModel),
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
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
                              if (viewModel.totalUnreadCount > 0)
                                Positioned(
                                  right: 2,
                                  top: 2,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF4FC3F7),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '${viewModel.totalUnreadCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search Bar & Filter Row
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextField(
                              onChanged: viewModel.setSearchQuery,
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
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Filter Button
                        InkWell(
                          onTap: () => _showFilterSheet(context, viewModel),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: viewModel.activeFilter != ChatFilter.all
                                  ? const Color(0xFF4FC3F7).withOpacity(0.12)
                                  : Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.tune_rounded,
                              color: viewModel.activeFilter != ChatFilter.all
                                  ? const Color(0xFF4FC3F7)
                                  : AppColors.textDark,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Conversations List
                    Expanded(
                      child: conversations.isEmpty
                          ? const Center(
                              child: Text(
                                'No messages match your filter.',
                                style: TextStyle(color: AppColors.textMuted),
                              ),
                            )
                          : ListView.separated(
                              itemCount: conversations.length,
                              separatorBuilder: (_, __) => Divider(
                                color: Colors.grey.shade100,
                                height: 1,
                              ),
                              itemBuilder: (context, index) {
                                final item = conversations[index];
                                final isMuted = viewModel.isMuted(item.id);

                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  onLongPress: () => _showChatLongPressOptions(
                                    context,
                                    item,
                                    viewModel,
                                  ),
                                  onTap: () {
                                    viewModel.markAsRead(item.id);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ChangeNotifierProvider.value(
                                              value: viewModel,
                                              child: ChatDetailScreen(
                                                chatId: item.id,
                                                name: item.name,
                                                specialization: item.role,
                                                avatarUrl: item.avatarUrl,
                                              ),
                                            ),
                                      ),
                                    );
                                  },
                                  leading: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 26,
                                        backgroundImage: NetworkImage(
                                          item.avatarUrl,
                                        ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: AppColors.textDark,
                                            ),
                                          ),
                                          if (isMuted) ...[
                                            const SizedBox(width: 6),
                                            const Icon(
                                              Icons.notifications_off_outlined,
                                              size: 14,
                                              color: AppColors.textMuted,
                                            ),
                                          ],
                                        ],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: item.unreadCount > 0
                                                    ? AppColors.textDark
                                                    : AppColors.textMuted,
                                                fontWeight: item.unreadCount > 0
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                          if (item.unreadCount > 0)
                                            Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF4FC3F7),
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
        },
      ),
    );
  }
}

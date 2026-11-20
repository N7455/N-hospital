
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Appointment',
      'message': 'Rahul Sharma booked a new appointment.',
      'time': '10 minutes ago',
      'icon': Icons.calendar_month,
      'color': Colors.blue,
      'read': false,
    },
    {
      'title': 'Payment Received',
      'message': 'Payment of Rs. 2500 has been received.',
      'time': '30 minutes ago',
      'icon': Icons.currency_rupee,
      'color': Colors.green,
      'read': false,
    },
    {
      'title': 'New Patient Registered',
      'message': 'A new patient has been registered.',
      'time': '1 hour ago',
      'icon': Icons.person_add_alt_1,
      'color': Colors.orange,
      'read': true,
    },
    {
      'title': 'Doctor Schedule Updated',
      'message': 'Doctor schedule has been updated.',
      'time': 'Yesterday',
      'icon': Icons.medical_services,
      'color': Colors.red,
      'read': true,
    },
  ];

  int get unreadCount =>
      notifications.where((item) => item['read'] == false).length;

  Future<void> addNotification() async {
    final titleController = TextEditingController();
    final messageController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text(
            'Add Notification',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Notification Title',
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: messageController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Notification Message',
                    prefixIcon: Icon(Icons.message_outlined),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (titleController.text.trim().isEmpty ||
                    messageController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill both fields'),
                    ),
                  );
                  return;
                }

                Navigator.pop(dialogContext, true);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    if (result == true && mounted) {
      setState(() {
        notifications.insert(0, {
          'title': titleController.text.trim(),
          'message': messageController.text.trim(),
          'time': 'Just now',
          'icon': Icons.notifications_active,
          'color': Colors.blue,
          'read': false,
        });
      });
    }

    titleController.dispose();
    messageController.dispose();
  }

  void markAllRead() {
    setState(() {
      for (var item in notifications) {
        item['read'] = true;
      }
    });
  }

  void clearAll() {
    if (notifications.isEmpty) return;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        title: const Text('Clear Notifications?'),
        content: const Text(
          'Are you sure you want to delete all notifications?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE50914),
            ),
            onPressed: () {
              setState(() {
                notifications.clear();
              });
              Navigator.pop(dialogContext);
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151515),
        title: const Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Add Notification',
            onPressed: addNotification,
            icon: const Icon(
              Icons.add_circle_outline,
              color: Color(0xFF2979FF),
            ),
          ),
          IconButton(
            tooltip: 'Mark All as Read',
            onPressed: markAllRead,
            icon: const Icon(Icons.done_all),
          ),
          IconButton(
            tooltip: 'Clear All',
            onPressed: clearAll,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'All Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE50914).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$unreadCount Unread',
                    style: const TextStyle(
                      color: Color(0xFFE50914),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: notifications.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_off_outlined,
                            size: 65,
                            color: Colors.white38,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'No notifications available',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final item = notifications[index];
                        final bool isRead = item['read'] as bool;

                        return Card(
                          color: isRead
                              ? const Color(0xFF151515)
                              : const Color(0xFF202020),
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                            side: BorderSide(
                              color: isRead
                                  ? Colors.white10
                                  : const Color(0xFFE50914)
                                      .withValues(alpha: 0.4),
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(14),
                            leading: CircleAvatar(
                              backgroundColor:
                                  (item['color'] as Color)
                                      .withValues(alpha: 0.15),
                              child: Icon(
                                item['icon'] as IconData,
                                color: item['color'] as Color,
                              ),
                            ),
                            title: Text(
                              item['title'] as String,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['message'] as String,
                                    style: const TextStyle(
                                      color: Colors.white60,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['time'] as String,
                                    style: const TextStyle(
                                      color: Colors.white38,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            trailing: isRead
                                ? const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white24,
                                  )
                                : const Icon(
                                    Icons.circle,
                                    color: Color(0xFFE50914),
                                    size: 11,
                                  ),
                            onTap: () => markAsRead(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

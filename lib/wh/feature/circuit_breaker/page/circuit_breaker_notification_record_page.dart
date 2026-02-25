import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CircuitBreakerNotificationRecordPage extends StatefulWidget {
  const CircuitBreakerNotificationRecordPage({super.key});

  @override
  State<CircuitBreakerNotificationRecordPage> createState() => _CircuitBreakerNotificationRecordPageState();
}

class _CircuitBreakerNotificationRecordPageState extends State<CircuitBreakerNotificationRecordPage> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      type: '電流過載',
      message: '電流超過安全值，已自動斷電',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    NotificationItem(
      type: '溫度過高',
      message: '溫度超過設定值',
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.of(context).pop()),
            const SizedBox(height: 35.0),
            Expanded(
              child: _notifications.isEmpty
                  ? const Center(child: Text('尚無通知紀錄'))
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      itemCount: _notifications.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16.8),
                      itemBuilder: (context, index) {
                        return _NotificationCard(item: _notifications[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationItem {
  final String type;
  final String message;
  final DateTime dateTime;

  NotificationItem({
    required this.type,
    required this.message,
    required this.dateTime,
  });
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Image.asset(
            'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
            width: 56.0,
            height: 56.0,
            color: const Color(0xFFFB9B51),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              '通知紀錄',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF292929),
              ),
            ),
          ),
        ),
        const SizedBox(width: 56.0),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22.4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(5.6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.type,
            style: const TextStyle(
              fontSize: 22.4,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF5722),
            ),
          ),
          const SizedBox(height: 11.2),
          Text(
            item.message,
            style: const TextStyle(
              fontSize: 19.6,
              color: Color(0xFF292929),
            ),
          ),
          const SizedBox(height: 11.2),
          Text(
            DateFormat('yyyy/MM/dd HH:mm').format(item.dateTime),
            style: const TextStyle(
              fontSize: 16.8,
              color: Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }
}

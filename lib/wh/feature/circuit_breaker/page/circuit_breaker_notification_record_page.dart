import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/circuit_breaker/ui/first_background_card.dart';
import 'package:flutter/material.dart';

class CircuitBreakerNotificationRecordPage extends StatefulWidget {
  const CircuitBreakerNotificationRecordPage({super.key});

  @override
  State<CircuitBreakerNotificationRecordPage> createState() => _CircuitBreakerNotificationRecordPageState();
}

class _CircuitBreakerNotificationRecordPageState extends State<CircuitBreakerNotificationRecordPage> {
  String _selectedTab = '全部';

  final Map<String, List<NotificationRecord>> _allRecords = {
    '2024/01/27': [
      NotificationRecord(
        time: '14:32',
        content: '電流過載，已自動斷電',
        type: '警報',
      ),
      NotificationRecord(
        time: '09:15',
        content: '溫度超過設定值 60°C',
        type: '警報',
      ),
    ],
    '2024/01/26': [
      NotificationRecord(
        time: '18:20',
        content: '電壓異常，已自動斷電',
        type: '警報',
      ),
      NotificationRecord(
        time: '10:30',
        content: '裝置已開啟',
        type: '操作',
      ),
    ],
    '2024/01/25': [
      NotificationRecord(
        time: '16:45',
        content: '電流超過 15A',
        type: '警報',
      ),
    ],
  };

  Map<String, List<NotificationRecord>> get _filteredRecords {
    if (_selectedTab == '全部') {
      return _allRecords;
    }

    final filtered = <String, List<NotificationRecord>>{};
    _allRecords.forEach((date, records) {
      final filteredList = records.where((r) => r.type == _selectedTab).toList();
      if (filteredList.isNotEmpty) {
        filtered[date] = filteredList;
      }
    });
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.of(context).pop()),
            const SizedBox(height: 33.6),
            _TabBar(
              selectedTab: _selectedTab,
              onTabChanged: (tab) {
                setState(() => _selectedTab = tab);
              },
            ),
            const SizedBox(height: 33.6),
            Expanded(
              child: _filteredRecords.isEmpty ? const CustEmptyWidget() : _RecordList(records: _filteredRecords),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationRecord {
  final String time;
  final String content;
  final String type;

  NotificationRecord({
    required this.time,
    required this.content,
    required this.type,
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
            'lib/wh/parent/assets/images/common/arrow_left.png',
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

class _TabBar extends StatelessWidget {
  final String selectedTab;
  final Function(String) onTabChanged;

  const _TabBar({
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = ['全部', '警報', '操作'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 0.7,
          color: const Color(0xFFFB9B51),
        ),
        borderRadius: BorderRadius.circular(5.6),
      ),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++) ...[
            Expanded(
              child: _TabItem(
                title: tabs[i],
                isSelected: selectedTab == tabs[i],
                onTap: () => onTabChanged(tabs[i]),
              ),
            ),
            if (i < tabs.length - 1) const SizedBox(width: 33.6),
          ],
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFB9B51) : Colors.transparent,
          borderRadius: BorderRadius.circular(5.6),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 22.4,
            color: isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF666666),
          ),
        ),
      ),
    );
  }
}

class _RecordList extends StatelessWidget {
  final Map<String, List<NotificationRecord>> records;

  const _RecordList({required this.records});

  @override
  Widget build(BuildContext context) {
    final sortedDates = records.keys.toList();

    return ListView.builder(
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final dateKey = sortedDates[index];
        final dayRecords = records[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index > 0)
              Container(
                margin: const EdgeInsets.only(bottom: 22.4),
                height: 0.7,
                color: const Color(0xFF666666),
              ),
            Padding(
              padding: const EdgeInsets.only(
                left: 22.4,
                bottom: 11.2,
              ),
              child: Text(
                dateKey,
                style: const TextStyle(
                  fontSize: 22.4,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292929),
                ),
              ),
            ),
            ...dayRecords.map((record) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.4,
                  vertical: 5.6,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 119.0,
                      child: Text(
                        record.time,
                        style: const TextStyle(
                          fontSize: 22.4,
                          color: Color(0xFF292929),
                        ),
                      ),
                    ),
                    const SizedBox(width: 44.8),
                    Expanded(
                      child: Text(
                        record.content,
                        style: const TextStyle(
                          fontSize: 22.4,
                          color: Color(0xFF292929),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8.4),
          ],
        );
      },
    );
  }
}

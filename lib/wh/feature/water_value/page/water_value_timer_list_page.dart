import 'package:engo_terminal_app3/wh/feature/water_value/page/water_value_timer_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/ui/cust_toggle_switch.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/ui/first_background_card.dart';
import 'package:flutter/material.dart';

class WaterValueTimerListPage extends StatefulWidget {
  const WaterValueTimerListPage({super.key});

  @override
  State<WaterValueTimerListPage> createState() => _WaterValueTimerListPageState();
}

class _WaterValueTimerListPageState extends State<WaterValueTimerListPage> {
  bool _isEditMode = false;
  final List<TimerItem> _timerItems = [
    TimerItem(
      time: const TimeOfDay(hour: 8, minute: 30),
      isRepeat: true,
      repeatDays: {1, 2, 3, 4, 5},
      action: '開啟',
      isNotify: true,
      isEnable: true,
    ),
    TimerItem(
      time: const TimeOfDay(hour: 20, minute: 0),
      isRepeat: false,
      repeatDays: {},
      action: '關閉',
      isNotify: false,
      isEnable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(
              onBack: () => Navigator.of(context).pop(),
              onEdit: () {
                setState(() => _isEditMode = !_isEditMode);
              },
            ),
            const SizedBox(height: 33.6),
            Expanded(
              child: _timerItems.isEmpty
                  ? const Center(
                      child: CustEmptyWidget(),
                    )
                  : _TimerList(
                      items: _timerItems,
                      isEditMode: _isEditMode,
                      onToggle: (index) {
                        setState(() {
                          _timerItems[index].isEnable = !_timerItems[index].isEnable;
                        });
                      },
                      onDelete: (index) {
                        setState(() => _timerItems.removeAt(index));
                      },
                      onTap: (index) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WaterValueTimerSettingPage(
                              timerItem: _timerItems[index],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 22.4),
            _AddButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WaterValueTimerSettingPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 33.6),
          ],
        ),
      ),
    );
  }
}

class TimerItem {
  TimeOfDay? time;
  bool isRepeat;
  Set<int> repeatDays;
  String action;
  bool isNotify;
  bool isEnable;

  TimerItem({
    this.time,
    required this.isRepeat,
    required this.repeatDays,
    required this.action,
    required this.isNotify,
    required this.isEnable,
  });
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onEdit;

  const _TopBar({
    required this.onBack,
    required this.onEdit,
  });

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
              '定時列表',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF292929),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: Image.asset(
            'lib/wh/parent/assets/images/common/pencil_line.png',
            width: 43.4,
            height: 43.4,
            color: const Color(0xFF292929),
          ),
        ),
      ],
    );
  }
}

class _TimerList extends StatelessWidget {
  final List<TimerItem> items;
  final bool isEditMode;
  final Function(int) onToggle;
  final Function(int) onDelete;
  final Function(int) onTap;

  const _TimerList({
    required this.items,
    required this.isEditMode,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFE0E0E0),
      ),
      itemBuilder: (context, index) {
        return _TimerItemCell(
          item: items[index],
          isEditMode: isEditMode,
          onToggle: () => onToggle(index),
          onDelete: () => onDelete(index),
          onTap: () => onTap(index),
        );
      },
    );
  }
}

class _TimerItemCell extends StatelessWidget {
  final TimerItem item;
  final bool isEditMode;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const _TimerItemCell({
    required this.item,
    required this.isEditMode,
    required this.onToggle,
    required this.onDelete,
    required this.onTap,
  });

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '-';
    final hour = time.hour;
    final minute = time.minute;
    final period = hour < 12 ? '上午' : '下午';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$period ${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String _formatRepeatCycle() {
    if (!item.isRepeat) return '執行一次';

    final days = item.repeatDays;
    if (days.isEmpty) return '執行一次';

    if (days.length == 7) return '每天';
    if (days.length == 5 && days.containsAll([1, 2, 3, 4, 5])) {
      return '平日';
    }

    const dayNames = ['週一', '週二', '週三', '週四', '週五', '週六', '週日'];
    final sorted = days.toList()..sort();
    return sorted.map((day) => dayNames[day - 1]).join('、');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 16.8,
        horizontal: 22.4,
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              behavior: HitTestBehavior.opaque,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatTime(item.time),
                    style: const TextStyle(
                      fontSize: 19.6,
                      color: Color(0xFF292929),
                    ),
                  ),
                  const SizedBox(height: 8.4),
                  Text(
                    _formatRepeatCycle(),
                    style: const TextStyle(
                      fontSize: 16.8,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 8.4),
                  Row(
                    children: [
                      Text(
                        '狀態: ${item.action}',
                        style: const TextStyle(
                          fontSize: 16.8,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(width: 16.8),
                      Text(
                        '執行通知: ${item.isNotify ? "開啟" : "關閉"}',
                        style: const TextStyle(
                          fontSize: 16.8,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 11.2),
          if (isEditMode)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(14.0),
                child: Ink(
                  padding: const EdgeInsets.all(10.5),
                  child: Image.asset(
                    'lib/wh/parent/assets/images/common/trash.png',
                    width: 28.0,
                    height: 28.0,
                    color: const Color(0xFF666666),
                  ),
                ),
              ),
            )
          else
            CustToggleSwitch(
              value: item.isEnable,
              onTap: onToggle,
            ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 164.5,
          vertical: 16.8,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFFFB9B51),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(8.4),
          ),
        ),
        child: const Text(
          '新增定時',
          style: TextStyle(
            fontSize: 22.4,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

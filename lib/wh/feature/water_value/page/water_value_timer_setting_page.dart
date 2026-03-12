import 'package:engo_terminal_app3/wh/feature/water_value/page/water_value_timer_list_page.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/ui/cust_apm_timer.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/ui/cust_toggle_switch.dart';
import 'package:engo_terminal_app3/wh/feature/water_value/ui/first_background_card.dart';
import 'package:flutter/material.dart';

class WaterValueTimerSettingPage extends StatefulWidget {
  final TimerItem? timerItem;

  const WaterValueTimerSettingPage({super.key, this.timerItem});

  @override
  State<WaterValueTimerSettingPage> createState() =>
      _WaterValueTimerSettingPageState();
}

class _WaterValueTimerSettingPageState
    extends State<WaterValueTimerSettingPage> {
  String _selectedTab = '開啟';
  TimeOfDay _time = const TimeOfDay(hour: 8, minute: 0);
  bool _isRepeat = false;
  String _repeatType = '平日';
  Set<int> _selectedDays = {1, 2, 3, 4, 5};
  final TextEditingController _noteController = TextEditingController();
  bool _isNotify = true;

  @override
  void initState() {
    super.initState();
    if (widget.timerItem != null) {
      _selectedTab = widget.timerItem!.action;
      _time = widget.timerItem!.time ?? _time;
      _isRepeat = widget.timerItem!.isRepeat;
      _selectedDays = widget.timerItem!.repeatDays;
      _isNotify = widget.timerItem!.isNotify;

      if (_isRepeat) {
        if (_selectedDays.length == 7) {
          _repeatType = '每天';
        } else if (_selectedDays.length == 5 &&
            _selectedDays.containsAll([1, 2, 3, 4, 5])) {
          _repeatType = '平日';
        } else {
          _repeatType = '自訂';
        }
      }
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.of(context).pop()),
            const SizedBox(height: 33.6),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 140.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _TabBar(
                      selectedTab: _selectedTab,
                      onTabChanged: (tab) => setState(() => _selectedTab = tab),
                    ),
                    const SizedBox(height: 33.6),
                    _TimePickerSection(
                      time: _time,
                      onTimeChanged: (time) => setState(() => _time = time),
                    ),
                    const SizedBox(height: 33.6),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _RepeatAndWeekdaySection(
                              isRepeat: _isRepeat,
                              repeatType: _repeatType,
                              selectedDays: _selectedDays,
                              onRepeatToggle: () =>
                                  setState(() => _isRepeat = !_isRepeat),
                              onRepeatTypeChanged: (type) {
                                setState(() {
                                  _repeatType = type;
                                  if (type == '平日') {
                                    _selectedDays = {1, 2, 3, 4, 5};
                                  } else if (type == '每天') {
                                    _selectedDays = {1, 2, 3, 4, 5, 6, 7};
                                  }
                                });
                              },
                              onDayToggle: (day) {
                                setState(() {
                                  if (_selectedDays.contains(day)) {
                                    _selectedDays.remove(day);
                                  } else {
                                    _selectedDays.add(day);
                                  }
                                });
                              },
                            ),
                            const SizedBox(height: 22.4),
                            _NoteSection(controller: _noteController),
                            const SizedBox(height: 22.4),
                            _NotificationSection(
                              isNotify: _isNotify,
                              onToggle: () =>
                                  setState(() => _isNotify = !_isNotify),
                            ),
                            const SizedBox(height: 22.4),
                            _SaveButton(
                              onSave: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(height: 22.4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
              '定時設定',
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
    return Container(
      height: 47.6,
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFFB9B51),
          ),
          borderRadius: BorderRadius.circular(8.4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged('開啟'),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTab == '開啟'
                      ? const Color(0xFFFB9B51)
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.4),
                    bottomLeft: Radius.circular(8.4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '開啟',
                  style: TextStyle(
                    fontSize: 22.4,
                    color: selectedTab == '開啟'
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged('關閉'),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTab == '關閉'
                      ? const Color(0xFFFB9B51)
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.4),
                    bottomRight: Radius.circular(8.4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '關閉',
                  style: TextStyle(
                    fontSize: 22.4,
                    color: selectedTab == '關閉'
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TimePickerSection extends StatelessWidget {
  final TimeOfDay time;
  final Function(TimeOfDay) onTimeChanged;

  const _TimePickerSection({
    required this.time,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 415.1,
        height: 175.0,
        child: CustAPMTimer(
          time: time,
          onTimeChanged: (newTime) {
            if (newTime != null) {
              onTimeChanged(newTime);
            }
          },
        ),
      ),
    );
  }
}

class _RepeatAndWeekdaySection extends StatelessWidget {
  final bool isRepeat;
  final String repeatType;
  final Set<int> selectedDays;
  final VoidCallback onRepeatToggle;
  final Function(String) onRepeatTypeChanged;
  final Function(int) onDayToggle;

  const _RepeatAndWeekdaySection({
    required this.isRepeat,
    required this.repeatType,
    required this.selectedDays,
    required this.onRepeatToggle,
    required this.onRepeatTypeChanged,
    required this.onDayToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '重複',
              style: TextStyle(
                fontSize: 22.4,
                color: Color(0xFF292929),
              ),
            ),
            CustToggleSwitch(
              value: isRepeat,
              onTap: onRepeatToggle,
            ),
          ],
        ),
        if (isRepeat) ...[
          const SizedBox(height: 22.4),
          _RepeatTabbar(
            repeatType: repeatType,
            onTypeChanged: onRepeatTypeChanged,
          ),
          if (repeatType == '自訂') ...[
            const SizedBox(height: 22.4),
            _WeekdayList(
              selectedDays: selectedDays,
              onDayToggle: onDayToggle,
            ),
          ],
        ],
        const SizedBox(height: 22.4),
        const _Divider(),
      ],
    );
  }
}

class _RepeatTabbar extends StatelessWidget {
  final String repeatType;
  final Function(String) onTypeChanged;

  const _RepeatTabbar({
    required this.repeatType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.6,
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFFB9B51),
          ),
          borderRadius: BorderRadius.circular(8.4),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTypeChanged('平日'),
              child: Container(
                decoration: BoxDecoration(
                  color: repeatType == '平日'
                      ? const Color(0xFFFB9B51)
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.4),
                    bottomLeft: Radius.circular(8.4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '平日',
                  style: TextStyle(
                    fontSize: 22.4,
                    color: repeatType == '平日'
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTypeChanged('每天'),
              child: Container(
                color: repeatType == '每天'
                    ? const Color(0xFFFB9B51)
                    : Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  '每天',
                  style: TextStyle(
                    fontSize: 22.4,
                    color: repeatType == '每天'
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTypeChanged('自訂'),
              child: Container(
                decoration: BoxDecoration(
                  color: repeatType == '自訂'
                      ? const Color(0xFFFB9B51)
                      : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.4),
                    bottomRight: Radius.circular(8.4),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '自訂',
                  style: TextStyle(
                    fontSize: 22.4,
                    color: repeatType == '自訂'
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF666666),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekdayList extends StatelessWidget {
  final Set<int> selectedDays;
  final Function(int) onDayToggle;

  const _WeekdayList({
    required this.selectedDays,
    required this.onDayToggle,
  });

  @override
  Widget build(BuildContext context) {
    const weekdayLabels = ['週一', '週二', '週三', '週四', '週五', '週六', '週日'];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (index) {
        final day = index + 1;
        final isSelected = selectedDays.contains(day);
        return Padding(
          padding: EdgeInsets.only(right: index < 6 ? 33.6 : 0),
          child: GestureDetector(
            onTap: () => onDayToggle(day),
            child: Container(
              width: 70.0,
              height: 70.0,
              decoration: ShapeDecoration(
                color: isSelected
                    ? const Color(0xFFFB9B51)
                    : const Color(0xFFF5F5F5),
                shape: const OvalBorder(),
              ),
              child: Center(
                child: Text(
                  weekdayLabels[index],
                  style: TextStyle(
                    fontSize: 18.2,
                    color: isSelected
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF666666),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF666666),
      height: 1,
    );
  }
}

class _NoteSection extends StatelessWidget {
  final TextEditingController controller;

  const _NoteSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '備註',
                style: TextStyle(
                  fontSize: 22.4,
                  color: Color(0xFF292929),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 22.4),
                  child: TextField(
                    controller: controller,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 18.2,
                      color: Color(0xFF666666),
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      isDense: true,
                      hintText: '',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22.4),
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(0xFF666666),
        ),
      ],
    );
  }
}

class _NotificationSection extends StatelessWidget {
  final bool isNotify;
  final VoidCallback onToggle;

  const _NotificationSection({
    required this.isNotify,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '執行通知',
                style: TextStyle(
                  fontSize: 22.4,
                  color: Color(0xFF292929),
                ),
              ),
              CustToggleSwitch(
                value: isNotify,
                onTap: onToggle,
              ),
            ],
          ),
        ),
        const SizedBox(height: 22.4),
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(0xFF666666),
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onSave;

  const _SaveButton({required this.onSave});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSave,
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
          '儲存',
          style: TextStyle(
            fontSize: 22.4,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}

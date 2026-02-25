import 'package:engo_terminal_app3/wh/feature/air_conditioner/page/air_conditioner_main_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/cust_apm_timer.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/cust_grid_view.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/cust_toggle_switch.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/icon_button.dart';
import 'package:flutter/material.dart';

class AirConditionerTimerSettingPage extends StatefulWidget {
  const AirConditionerTimerSettingPage({super.key});

  @override
  State<AirConditionerTimerSettingPage> createState() => _AirConditionerTimerSettingPageState();
}

class _AirConditionerTimerSettingPageState extends State<AirConditionerTimerSettingPage> {
  // Hard code values
  bool isOpen = true; // 開啟, 關閉
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  bool isRepeat = false;
  String repeatDay = '工作日'; // 工作日, 每天, 自定義
  Set<int> selectedDays = {1, 2, 3, 4, 5}; // 1-7: 周一到周日，預設工作日
  String settingSummary = '自動';
  String label = '定時1';

  // 設定 bottom sheet 狀態
  String selectedMode = '自動'; // 自動, 冷氣, 乾燥, 暖氣, 送風
  int temperature = 26; // 溫度
  String windSpeed = '弱風'; // 微風, 弱風, 強風, 自動
  String specialMode = '睡眠曲線'; // 睡眠曲線, ECO

  @override
  Widget build(BuildContext context) {
    const spacing = 16.0;
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            const _TopBar(),
            const SizedBox(height: 24.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _TabBar(
                    selectedTab: isOpen ? '開啟' : '關閉',
                    onTabChanged: (tab) {
                      setState(() {
                        isOpen = (tab == '開啟');
                      });
                    },
                  ),
                  const SizedBox(height: 24.0),
                  _TimePickerSection(
                    time: isOpen ? openTime : closeTime,
                    onTimeChanged: (time) {
                      setState(() {
                        if (isOpen) {
                          openTime = time;
                        } else {
                          closeTime = time;
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 150),
                        child: Column(
                          children: [
                            _RepeatSection(
                              isRepeat: isRepeat,
                              onToggle: () {
                                setState(() {
                                  isRepeat = !isRepeat;
                                });
                              },
                            ),
                            if (isRepeat) ...[
                              const SizedBox(height: spacing),
                              _RepeatDaySection(
                                repeatDay: repeatDay,
                                onRepeatDayChanged: (day) {
                                  setState(() {
                                    repeatDay = day;
                                  });
                                },
                              ),
                              if (repeatDay == '自定義') ...[
                                const SizedBox(height: spacing),
                                _WeekdayList(
                                  selectedDays: selectedDays,
                                  onDayTapped: (int day) {
                                    setState(() {
                                      if (selectedDays.contains(day)) {
                                        selectedDays.remove(day);
                                      } else {
                                        selectedDays.add(day);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ],
                            const SizedBox(height: spacing),
                            const _Divider(),
                            const SizedBox(height: spacing),
                            _InfoRow(
                              title: '設定',
                              value: settingSummary,
                              onTap: () {
                                _showSettingBottomSheet(context);
                              },
                            ),
                            const SizedBox(height: spacing),
                            const _Divider(),
                            const SizedBox(height: spacing),
                            _InfoRow(
                              title: '標籤',
                              value: label,
                              onTap: () {
                                // Hard code: no action
                              },
                            ),
                            const SizedBox(height: spacing),
                            const _Divider(),
                            const SizedBox(height: 32),
                            const _SaveButton(),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      isScrollControlled: true,
      builder: (context) => _SettingBottomSheet(
        selectedMode: selectedMode,
        temperature: temperature,
        windSpeed: windSpeed,
        specialMode: specialMode,
        onModeChanged: (mode) {
          setState(() {
            selectedMode = mode;
            settingSummary = mode;
          });
        },
        onTemperatureChanged: (temp) {
          setState(() {
            temperature = temp;
          });
        },
        onWindSpeedChanged: (speed) {
          setState(() {
            windSpeed = speed;
          });
        },
        onSpecialModeChanged: (mode) {
          setState(() {
            specialMode = mode;
          });
        },
        onConfirm: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustIconButton(
          icon: Image.asset(
            'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
            width: 80.0,
            height: 80.0,
            color: const Color(0xFFFB9B51),
          ),
          size: 80.0,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const Expanded(
          child: Center(
            child: Text(
              '定時設定',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF292929),
                height: 1.4,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 80.0),
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
      width: 600.0,
      height: 58.0,
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFFB9B51),
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged('開啟'),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedTab == '開啟' ? const Color(0xFFFB9B51) : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '開啟',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: selectedTab == '開啟' ? const Color(0xFFFFFFFF) : const Color(0xFF7C7C7C),
                    height: 1.4,
                    letterSpacing: 0,
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
                  color: selectedTab == '關閉' ? const Color(0xFFFB9B51) : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '關閉',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: selectedTab == '關閉' ? const Color(0xFFFFFFFF) : const Color(0xFF7C7C7C),
                    height: 1.4,
                    letterSpacing: 0,
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
    return SizedBox(
      width: 593.0,
      height: 250.0,
      child: CustAPMTimer(
        textSize: 30.0,
        time: time,
        onTimeChanged: (data) {
          if (data is TimeOfDay) {
            onTimeChanged(data);
          }
        },
      ),
    );
  }
}

class _RepeatSection extends StatelessWidget {
  final bool isRepeat;
  final VoidCallback onToggle;

  const _RepeatSection({
    required this.isRepeat,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '重覆',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF292929),
            height: 1.4,
            letterSpacing: 0,
          ),
        ),
        CustToggleSwitch(
          value: isRepeat,
          onTap: onToggle,
        ),
      ],
    );
  }
}

class _RepeatDaySection extends StatelessWidget {
  final String repeatDay;
  final Function(String) onRepeatDayChanged;

  const _RepeatDaySection({
    required this.repeatDay,
    required this.onRepeatDayChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58.0,
      decoration: ShapeDecoration(
        color: const Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFFFB9B51),
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onRepeatDayChanged('工作日'),
              child: Container(
                decoration: BoxDecoration(
                  color: repeatDay == '工作日' ? const Color(0xFFFB9B51) : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    bottomLeft: Radius.circular(12.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '工作日',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: repeatDay == '工作日' ? const Color(0xFFFFFFFF) : const Color(0xFF7C7C7C),
                    height: 1.4,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onRepeatDayChanged('每天'),
              child: Container(
                decoration: BoxDecoration(
                  color: repeatDay == '每天' ? const Color(0xFFFB9B51) : Colors.transparent,
                  borderRadius: BorderRadius.zero,
                ),
                alignment: Alignment.center,
                child: Text(
                  '每天',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: repeatDay == '每天' ? const Color(0xFFFFFFFF) : const Color(0xFF7C7C7C),
                    height: 1.4,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onRepeatDayChanged('自定義'),
              child: Container(
                decoration: BoxDecoration(
                  color: repeatDay == '自定義' ? const Color(0xFFFB9B51) : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12.0),
                    bottomRight: Radius.circular(12.0),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  '自定義',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    color: repeatDay == '自定義' ? const Color(0xFFFFFFFF) : const Color(0xFF7C7C7C),
                    height: 1.4,
                    letterSpacing: 0,
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

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback onTap;

  const _InfoRow({
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF292929),
                height: 1.4,
                letterSpacing: 0,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF7C7C7C),
                    height: 1.4,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(width: 16.0),
                Image.asset(
                  'lib/wh/feature/warehouse/parent/assets/images/common/arrow_right.png',
                  width: 40.0,
                  height: 40.0,
                  color: const Color(0xFF292929),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? fontSize;

  const _SaveButton({
    this.text = '儲存',
    this.onTap,
    this.backgroundColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          alignment: Alignment.center,
          width: 432,
          padding: const EdgeInsets.all(16.0),
          decoration: ShapeDecoration(
            color: backgroundColor ?? const Color(0xFFFB9B51),
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize ?? 26.0,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF000000),
              height: 1.4,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class _WeekdayList extends StatelessWidget {
  final Set<int> selectedDays;
  final Function(int) onDayTapped;

  const _WeekdayList({
    required this.selectedDays,
    required this.onDayTapped,
  });

  @override
  Widget build(BuildContext context) {
    final weekdayLabels = [
      '一',
      '二',
      '三',
      '四',
      '五',
      '六',
      '日',
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(7, (index) {
        final day = index + 1; // 1-7: 周一到周日
        final isSelected = selectedDays.contains(day);
        return Padding(
          padding: EdgeInsets.only(right: index < 6 ? 48.0 : 0),
          child: GestureDetector(
            onTap: () {
              onDayTapped(day);
            },
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: ShapeDecoration(
                color: isSelected ? const Color(0xFFFB9B51) : const Color(0xFFEFEFEF),
                shape: const OvalBorder(),
              ),
              child: Center(
                child: Text(
                  weekdayLabels[index],
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                    color: isSelected ? const Color(0xFFFFFFFF) : const Color(0xFF7C7C7C),
                    height: 1.4,
                    letterSpacing: 0,
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

class _SettingBottomSheet extends StatefulWidget {
  final String selectedMode;
  final int temperature;
  final String windSpeed;
  final String specialMode;
  final Function(String) onModeChanged;
  final Function(int) onTemperatureChanged;
  final Function(String) onWindSpeedChanged;
  final Function(String) onSpecialModeChanged;
  final VoidCallback onConfirm;

  const _SettingBottomSheet({
    required this.selectedMode,
    required this.temperature,
    required this.windSpeed,
    required this.specialMode,
    required this.onModeChanged,
    required this.onTemperatureChanged,
    required this.onWindSpeedChanged,
    required this.onSpecialModeChanged,
    required this.onConfirm,
  });

  @override
  State<_SettingBottomSheet> createState() => _SettingBottomSheetState();
}

class _SettingBottomSheetState extends State<_SettingBottomSheet> {
  late String _currentMode;
  late double _currentTemperature;
  late String _currentWindSpeed;
  late String _currentSpecialMode;
  bool _isWindSpeedAuto = false;

  @override
  void initState() {
    super.initState();
    _currentMode = widget.selectedMode;
    _currentTemperature = widget.temperature.toDouble();
    _currentWindSpeed = widget.windSpeed;
    _currentSpecialMode = widget.specialMode;
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 24.0;
    return Container(
      height: 800.0,
      padding: const EdgeInsets.all(24),
      decoration: const ShapeDecoration(
        color: Color(0xFFEFEFEF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
      ),
      child: Column(
        children: [
          const _SettingTopBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: spacing),

                  // 模式選擇
                  _buildModeSection(),
                  const SizedBox(height: spacing),

                  // 溫度設定
                  _buildTemperatureSection(),
                  const SizedBox(height: spacing),

                  // 風速設定
                  _buildWindSpeedSection(),
                  const SizedBox(height: spacing),

                  // 特殊模式
                  const LowerSection(),
                  const SizedBox(height: spacing),

                  Center(
                    child: _SaveButton(
                      text: '確認',
                      onTap: widget.onConfirm,
                      backgroundColor: const Color(0xFFFDB874),
                      fontSize: 32.0,
                    ),
                  ),
                  const SizedBox(height: spacing),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeSection() {
    final modes = [
      {'name': '自動', 'image': 'lib/wh/feature/warehouse/parent/assets/images/common/reset.png'},
      {'name': '冷氣', 'image': 'lib/wh/feature/warehouse/parent/assets/images/common/snow_flake.png'},
      {'name': '乾燥', 'image': 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_dry2.png'},
      {'name': '暖氣', 'image': 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_heating.png'},
      {'name': '送風', 'image': 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_supply_wind.png'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '模式',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...modes.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final mode = entry.value;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index < modes.length - 1 ? 16.0 : 0,
                    ),
                    child: _ModeOption(
                      mode: mode['name']!,
                      imagePath: mode['image']!,
                      isSelected: _currentMode == mode['name'],
                      onTap: () {
                        setState(() {
                          _currentMode = mode['name']!;
                        });
                        widget.onModeChanged(mode['name']!);
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemperatureSection() {
    const double minTemperature = 18.0;
    const double maxTemperature = 32.0;
    final int temperatureDivisions = ((maxTemperature - minTemperature) / 0.5).round();

    void decreaseTemperature() {
      if (_currentTemperature > minTemperature) {
        setState(() {
          _currentTemperature = (_currentTemperature - 0.5).clamp(minTemperature, maxTemperature);
        });
        widget.onTemperatureChanged(_currentTemperature.round());
      }
    }

    void increaseTemperature() {
      if (_currentTemperature < maxTemperature) {
        setState(() {
          _currentTemperature = (_currentTemperature + 0.5).clamp(minTemperature, maxTemperature);
        });
        widget.onTemperatureChanged(_currentTemperature.round());
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          '溫度',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '溫度設定: ${_currentTemperature.toStringAsFixed(1)}度C',
              style: const TextStyle(
                color: Color(0xFF292929),
                fontSize: 26,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: SizedBox(
                height: 114.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TemperatureDecreaseButton(onTap: decreaseTemperature),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 5,
                            top: 16.0,
                            right: 5,
                            child: SizedBox(
                              height: 34.0,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 17.0,
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 17.0),
                                  activeTrackColor: const Color(0xFF366FB6),
                                  inactiveTrackColor: const Color(0xFF7C7C7C).withOpacity(0.3),
                                  thumbColor: Colors.white,
                                ),
                                child: Slider(
                                  value: _currentTemperature,
                                  min: minTemperature,
                                  max: maxTemperature,
                                  divisions: temperatureDivisions,
                                  onChanged: (value) {
                                    setState(() {
                                      _currentTemperature = value;
                                    });
                                    widget.onTemperatureChanged(_currentTemperature.round());
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 60.0,
                            right: 0,
                            child: SizedBox(
                              height: 54.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _TemperatureSliderLabel(value: minTemperature.toStringAsFixed(1)),
                                  _TemperatureSliderLabel(value: _currentTemperature.toStringAsFixed(1)),
                                  _TemperatureSliderLabel(value: maxTemperature.toStringAsFixed(1)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _TemperatureIncreaseButton(onTap: increaseTemperature),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWindSpeedSection() {
    final speeds = ['微風', '弱風', '強風'];
    const double minSpeed = 0.0;
    final double maxSpeed = (speeds.length - 1).toDouble();
    final int currentSpeedIndex = speeds.indexOf(_currentWindSpeed);

    void decreaseWindSpeed() {
      final currentIndex = speeds.indexOf(_currentWindSpeed);
      if (currentIndex > 0) {
        setState(() {
          _currentWindSpeed = speeds[currentIndex - 1];
        });
        widget.onWindSpeedChanged(_currentWindSpeed);
      }
    }

    void increaseWindSpeed() {
      final currentIndex = speeds.indexOf(_currentWindSpeed);
      if (currentIndex < speeds.length - 1) {
        setState(() {
          _currentWindSpeed = speeds[currentIndex + 1];
        });
        widget.onWindSpeedChanged(_currentWindSpeed);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '風速設定',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '風速設定: $_currentWindSpeed',
              style: const TextStyle(
                color: Color(0xFF292929),
                fontSize: 26,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
            const SizedBox(width: 32),
            Expanded(
              child: SizedBox(
                height: 114.0,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TemperatureDecreaseButton(onTap: decreaseWindSpeed),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 5,
                            top: 16.0,
                            right: 5,
                            child: SizedBox(
                              height: 34.0,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 17.0,
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 17.0),
                                  activeTrackColor: const Color(0xFF366FB6),
                                  inactiveTrackColor: const Color(0xFF7C7C7C).withOpacity(0.3),
                                  thumbColor: Colors.white,
                                ),
                                child: Slider(
                                  value: currentSpeedIndex.toDouble(),
                                  min: minSpeed,
                                  max: maxSpeed,
                                  divisions: speeds.length - 1,
                                  onChanged: (value) {
                                    final index = value.round();
                                    setState(() {
                                      _currentWindSpeed = speeds[index];
                                    });
                                    widget.onWindSpeedChanged(_currentWindSpeed);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 60.0,
                            right: 0,
                            child: SizedBox(
                              height: 54.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _WindSpeedSliderLabel(value: speeds[0]),
                                  _WindSpeedSliderLabel(value: _currentWindSpeed),
                                  _WindSpeedSliderLabel(value: speeds[speeds.length - 1]),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _TemperatureIncreaseButton(onTap: increaseWindSpeed),
                    const SizedBox(width: 32),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustToggleSwitch(
                          value: _isWindSpeedAuto,
                          onTap: () {
                            setState(() {
                              _isWindSpeedAuto = !_isWindSpeedAuto;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '自動',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF7C7C7C),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecialModeSection() {
    final modes = ['睡眠曲線', 'ECO'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '模式',
          style: TextStyle(
            color: Color(0xFF7C7C7C),
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        CustGridView(
          itemCount: modes.length,
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final mode = modes[index];
            return _SpecialModeGridItem(
              mode: mode,
              isSelected: _currentSpecialMode == mode,
              onTap: () {
                setState(() {
                  _currentSpecialMode = mode;
                });
                widget.onSpecialModeChanged(mode);
              },
            );
          },
        ),
      ],
    );
  }
}

class _SettingTopBar extends StatelessWidget {
  const _SettingTopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox.shrink(),
        const Text(
          '設定',
          style: TextStyle(
            color: Color(0xFF292929),
            fontSize: 32.0,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 52.0,
            height: 52.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Image.asset(
              'lib/wh/feature/warehouse/parent/assets/images/common/close.png',
              color: const Color(0xFF292929),
            ),
          ),
        ),
      ],
    );
  }
}

class _ModeOption extends StatelessWidget {
  final String mode;
  final String? imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModeOption({
    required this.mode,
    this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70.0,
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFFB9B51) : const Color(0xFFFDB874),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
          color: isSelected ? const Color(0xFFFB9B51).withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (imagePath != null) ...[
              Image.asset(
                imagePath!,
                width: 40.0,
                height: 40.0,
                color: const Color(0xFF292929),
              ),
              const SizedBox(width: 16.0),
            ],
            Text(
              mode,
              style: const TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
                color: Color(0xFF292929),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TemperatureDecreaseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _TemperatureDecreaseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const OvalBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const OvalBorder(),
        child: Container(
          width: 65.0,
          height: 65.0,
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Image.asset(
              'lib/wh/feature/warehouse/parent/assets/images/common/minus.png',
              color: const Color(0xFF96B7E3),
            ),
          ),
        ),
      ),
    );
  }
}

class _TemperatureIncreaseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _TemperatureIncreaseButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const OvalBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const OvalBorder(),
        child: Container(
          width: 65.0,
          height: 65.0,
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Image.asset(
              'lib/wh/feature/warehouse/parent/assets/images/common/plus.png',
              color: const Color(0xFF96B7E3),
            ),
          ),
        ),
      ),
    );
  }
}

class _TemperatureSliderLabel extends StatelessWidget {
  final String value;

  const _TemperatureSliderLabel({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$value°C',
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF7C7C7C),
        height: 1.4,
        letterSpacing: 0,
      ),
    );
  }
}

class _WindSpeedSliderLabel extends StatelessWidget {
  final String value;

  const _WindSpeedSliderLabel({required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF7C7C7C),
        height: 1.4,
        letterSpacing: 0,
      ),
    );
  }
}

class _SpecialModeGridItem extends StatelessWidget {
  final String mode;
  final bool isSelected;
  final VoidCallback onTap;

  const _SpecialModeGridItem({
    required this.mode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? const Color(0xFFFB9B51) : const Color(0xFF7C7C7C),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
            color: isSelected ? const Color(0xFFFB9B51).withOpacity(0.1) : Colors.transparent,
          ),
          child: Center(
            child: Text(
              mode,
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w400,
                color: isSelected ? const Color(0xFFFB9B51) : const Color(0xFF7C7C7C),
                height: 1.4,
                letterSpacing: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF7C7C7C),
      height: 1,
    );
  }
}

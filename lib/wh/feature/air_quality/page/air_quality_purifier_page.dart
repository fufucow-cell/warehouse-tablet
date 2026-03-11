import 'package:engo_terminal_app3/wh/feature/air_quality/page/air_quality_filter_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/page/air_quality_record_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/fan_speed_popup.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/mode_popup.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/sensor_data_bar.dart';
import 'package:engo_terminal_app3/wh/feature/air_quality/ui/timer_popup.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/ui/air_background_card.dart';
import 'package:flutter/material.dart';

class AirQualityPurifierPage extends StatefulWidget {
  const AirQualityPurifierPage({super.key});

  @override
  State<AirQualityPurifierPage> createState() => _AirQualityPurifierPageState();
}

class _AirQualityPurifierPageState extends State<AirQualityPurifierPage> {
  bool _isPowerOn = true;
  String _currentMode = '自動';
  String _currentFanSpeed = '中';
  int _timerHours = 0;
  bool _showModePopup = false;
  bool _showFanSpeedPopup = false;
  bool _showTimerPopup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AirBackgroundCard(
        isPurifier: true,
        child: Column(
          children: [
            _TopBar(
              title: '空氣清淨機',
              onBack: () {},
              onEdit: () {},
              onSettings: () {},
            ),
            const SizedBox(height: 8),
            const Text(
              '客廳',
              style: TextStyle(fontSize: 26, color: Colors.black),
            ),
            const SizedBox(height: 16),
            const SensorDataBar(
              datas: [
                {'溫度': 24.5},
                {'濕度': 55.0},
                {'HCHO': 0.05},
                {'VOC': 250.0},
                {'CO2': 650.0},
              ],
            ),
            const SizedBox(height: 48),
            Expanded(
              child: Stack(
                children: [
                  Row(
                    children: [
                      _LeftControlButtons(
                        currentMode: _currentMode,
                        currentFanSpeed: _currentFanSpeed,
                        timerHours: _timerHours,
                        onModeButtonTap: () {
                          setState(() {
                            _showModePopup = true;
                            _showFanSpeedPopup = false;
                            _showTimerPopup = false;
                          });
                        },
                        onFanSpeedButtonTap: () {
                          setState(() {
                            _showModePopup = false;
                            _showFanSpeedPopup = true;
                            _showTimerPopup = false;
                          });
                        },
                        onTimerButtonTap: () {
                          setState(() {
                            _showModePopup = false;
                            _showFanSpeedPopup = false;
                            _showTimerPopup = true;
                          });
                        },
                        onDataButtonTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AirQualityRecordPage()),
                          );
                        },
                        onFilterLifeTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const AirQualityFilterPage()),
                          );
                        },
                      ),
                      Expanded(
                        child: Stack(
                          fit: StackFit.expand,
                          clipBehavior: Clip.none,
                          children: [
                            const Positioned.fill(child: _MainDisplay()),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: _showModePopup
                                    ? ModePopup(
                                        currentMode: _currentMode,
                                        onModeSelected: (mode) {
                                          setState(() {
                                            _currentMode = mode;
                                            _showModePopup = false;
                                          });
                                        },
                                        onClose: () {
                                          setState(() => _showModePopup = false);
                                        },
                                      )
                                    : _showFanSpeedPopup
                                        ? FanSpeedPopup(
                                            currentSpeed: _currentFanSpeed,
                                            onSpeedSelected: (speed) {
                                              setState(() {
                                                _currentFanSpeed = speed;
                                                _showFanSpeedPopup = false;
                                              });
                                            },
                                            onClose: () {
                                              setState(() => _showFanSpeedPopup = false);
                                            },
                                          )
                                        : _showTimerPopup
                                            ? TimerPopup(
                                                currentHour: _timerHours,
                                                onConfirm: (hours) {
                                                  setState(() {
                                                    _timerHours = hours;
                                                    _showTimerPopup = false;
                                                  });
                                                },
                                                onClose: () {
                                                  setState(() => _showTimerPopup = false);
                                                },
                                              )
                                            : const SizedBox.shrink(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 50,
                    bottom: 50,
                    child: _PowerButton(
                      isOn: _isPowerOn,
                      onTap: () {
                        setState(() {
                          _isPowerOn = !_isPowerOn;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final VoidCallback onSettings;

  const _TopBar({
    required this.title,
    required this.onBack,
    required this.onEdit,
    required this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onBack,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'lib/wh/parent/assets/images/common/arrow_left.png',
                width: 40,
                height: 40,
                color: const Color(0xFFFDB874),
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 16),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onEdit,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'lib/wh/parent/assets/images/common/pencil_line.png',
                      width: 30,
                      height: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 12),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onSettings,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'lib/wh/parent/assets/images/common/setting.png',
                    width: 30,
                    height: 30,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LeftControlButtons extends StatelessWidget {
  final String currentMode;
  final String currentFanSpeed;
  final int timerHours;
  final VoidCallback onModeButtonTap;
  final VoidCallback onFanSpeedButtonTap;
  final VoidCallback onTimerButtonTap;
  final VoidCallback onDataButtonTap;
  final VoidCallback onFilterLifeTap;

  const _LeftControlButtons({
    required this.currentMode,
    required this.currentFanSpeed,
    required this.timerHours,
    required this.onModeButtonTap,
    required this.onFanSpeedButtonTap,
    required this.onTimerButtonTap,
    required this.onDataButtonTap,
    required this.onFilterLifeTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 493,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _LeftControlButton(
            text: currentMode,
            isFocused: currentMode != '關閉',
            iconPath: 'lib/wh/parent/assets/images/common/menu.png',
            onTap: onModeButtonTap,
          ),
          const SizedBox(height: 24),
          _LeftControlButton(
            text: currentFanSpeed,
            isFocused: currentFanSpeed != '關閉',
            iconPath: 'lib/wh/parent/assets/images/common/wind.png',
            onTap: onFanSpeedButtonTap,
          ),
          const SizedBox(height: 24),
          _LeftControlButton(
            text: timerHours > 0 ? '$timerHours 小時' : '定時',
            isFocused: timerHours > 0,
            iconPath: 'lib/wh/parent/assets/images/common/clock.png',
            onTap: onTimerButtonTap,
          ),
          const SizedBox(height: 24),
          _LeftControlButton(
            text: '數據',
            iconPath: 'lib/wh/parent/assets/images/common/chart.png',
            onTap: onDataButtonTap,
          ),
          const SizedBox(height: 24),
          _LeftControlButton(
            text: '濾網壽命: 80%',
            iconPath: 'lib/wh/parent/assets/images/common/purifier_fliter.png',
            onTap: onFilterLifeTap,
          ),
        ],
      ),
    );
  }
}

class _LeftControlButton extends StatelessWidget {
  final String text;
  final bool isFocused;
  final VoidCallback onTap;
  final String iconPath;

  const _LeftControlButton({
    required this.text,
    this.isFocused = false,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFFDB874).withOpacity(0.1),
          border: Border.all(
            width: 1,
            color: const Color(0xFFFDB874),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 40,
              height: 40,
              color: isFocused ? const Color(0xFFFDB874) : Colors.black,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 26,
                color: isFocused ? const Color(0xFFFDB874) : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MainDisplay extends StatelessWidget {
  const _MainDisplay();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 600,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/wh/parent/assets/images/common/pm25.png',
                width: 50,
                height: 50,
                color: const Color(0xFF4CAF50),
              ),
              const SizedBox(width: 20),
              const Text(
                'PM2.5',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '12.5',
                style: TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5DADE2),
                ),
              ),
              SizedBox(width: 14),
              Text(
                '良好',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xFF5DADE2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PowerButton extends StatelessWidget {
  final bool isOn;
  final VoidCallback onTap;

  const _PowerButton({required this.isOn, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final imagePath = isOn ? 'lib/wh/parent/assets/images/common/gateway_status_on.png' : 'lib/wh/parent/assets/images/common/gateway_status_off.png';
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        imagePath,
        width: 70,
        height: 70,
      ),
    );
  }
}

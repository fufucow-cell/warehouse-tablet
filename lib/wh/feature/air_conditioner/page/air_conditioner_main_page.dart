import 'package:engo_terminal_app3/wh/feature/air_conditioner/page/air_conditioner_energy_monitoring_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/page/air_conditioner_filter_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/page/air_conditioner_timer_reminder_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/cust_grid_view.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/icon_button.dart';
import 'package:flutter/material.dart';

class AirConditionerMainPage extends StatelessWidget {
  const AirConditionerMainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(),
            SizedBox(height: 24.0),
            _LocationAndEnvironment(),
            SizedBox(height: 24.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _UpperSection(),
                  SizedBox(height: 24.0),
                  Expanded(child: LowerSection()),
                ],
              ),
            ),
            SizedBox(height: 32.0),
          ],
        ),
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
        const SizedBox(width: 80.0),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EAP-T01 空調設備',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF292929),
                  height: 1.4,
                  letterSpacing: 0,
                ),
              ),
              const SizedBox(width: 16.0),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO: Implement edit title action
                  },
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'lib/wh/feature/warehouse/parent/assets/images/common/pencil_line.png',
                      width: 50.0,
                      height: 50.0,
                      color: const Color(0xFF292929),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustIconButton(
          icon: Image.asset(
            'lib/wh/feature/warehouse/parent/assets/images/common/setting.png',
            width: 62.0,
            height: 62.0,
            color: const Color(0xFF292929),
          ),
          size: 62.0,
          onTap: () {
            // TODO: Implement setting button action
          },
        ),
      ],
    );
  }
}

class _LocationAndEnvironment extends StatelessWidget {
  const _LocationAndEnvironment();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          '中山區-臥室1',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF292929),
            height: 1.4,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(width: 48.0),
        Image.asset(
          'lib/wh/feature/warehouse/parent/assets/images/common/temperature.png',
          width: 60.0,
          height: 60.0,
          color: const Color(0xFF292929),
        ),
        const Text(
          '25.5°C',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF366FB6),
            height: 1.4,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(width: 48.0),
        Image.asset(
          'lib/wh/feature/warehouse/parent/assets/images/common/humidity.png',
          width: 60.0,
          height: 60.0,
          color: const Color(0xFF292929),
        ),
        const SizedBox(width: 8.0),
        const Text(
          '60%',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFF366FB6),
            height: 1.4,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}

class _UpperSection extends StatelessWidget {
  const _UpperSection();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 390.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _UpLeftSection(),
          ),
          SizedBox(width: 65.0),
          Expanded(
            child: _UpRightSection(),
          ),
        ],
      ),
    );
  }
}

class LowerSection extends StatelessWidget {
  const LowerSection({super.key});

  static const int _itemCount = 9;
  static const int _crossAxisCount = 3;

  @override
  Widget build(BuildContext context) {
    return CustGridView(
      itemCount: _itemCount,
      crossAxisCount: _crossAxisCount,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _GridItem(index: index);
      },
    );
  }
}

// MARK: - Up Left Section

class _UpLeftSection extends StatelessWidget {
  const _UpLeftSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _AirConditionerCard(),
        SizedBox(height: 14.0),
        _FilterReplacementInfo(),
        SizedBox(height: 14.0),
        _TemperatureSlider(),
        SizedBox(height: 14.0),
        _ModeControlRow(),
      ],
    );
  }
}

class _ModeControlRow extends StatelessWidget {
  const _ModeControlRow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _ControlButton(
              imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/menu.png',
              text: '模式',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  builder: (context) => const _ModeBottomSheet(),
                );
              },
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: _ControlButton(
              imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/wind.png',
              text: '風量',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  backgroundColor: Colors.transparent,
                  builder: (context) => const _FanSpeedBottomSheet(),
                );
              },
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: _ControlButton(
              imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_wind_direction.png',
              text: '風向',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  backgroundColor: Colors.transparent,
                  builder: (context) => const _WindDirectionBottomSheet(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AirConditionerCard extends StatefulWidget {
  const _AirConditionerCard();

  @override
  State<_AirConditionerCard> createState() => _AirConditionerCardState();
}

class _AirConditionerCardState extends State<_AirConditionerCard> {
  bool _isPowerOn = true; // Hard code: initial power state

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: 125.0,
            child: Stack(
              children: [
                Image.asset(
                  'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner.png',
                ),
                Positioned(
                  right: 20.0,
                  top: 30.0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPowerOn = !_isPowerOn;
                      });
                    },
                    child: Image.asset(
                      _isPowerOn
                          ? 'lib/wh/feature/warehouse/parent/assets/images/common/gateway_status_on.png'
                          : 'lib/wh/feature/warehouse/parent/assets/images/common/gateway_status_off.png',
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '26.0',
                style: TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 65.0,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                  letterSpacing: 0,
                ),
              ),
              TextSpan(
                text: '°C',
                style: TextStyle(
                  color: Color(0xFF7C7C7C),
                  fontSize: 45.0,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _FilterReplacementInfo extends StatelessWidget {
  const _FilterReplacementInfo();

  @override
  Widget build(BuildContext context) {
    // Hard code: 25天12時
    const remainingTimeText = '25天12時';

    return const SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '濾芯剩餘時間 ',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w400,
              color: Color(0xFF7C7C7C),
              height: 1.4,
              letterSpacing: 0,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: remainingTimeText,
                  style: TextStyle(
                    color: Color(0xFF366FB6),
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    height: 1.20,
                  ),
                ),
                TextSpan(
                  text: ' (偵測正常)',
                  style: TextStyle(
                    color: Color(0xFF7C7C7C),
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                    height: 1.20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TemperatureSlider extends StatefulWidget {
  const _TemperatureSlider();

  @override
  State<_TemperatureSlider> createState() => _TemperatureSliderState();
}

class _TemperatureSliderState extends State<_TemperatureSlider> {
  double minTemperature = 18.0;
  double maxTemperature = 32.0;
  double currentTemperature = 26.0;
  int get temperatureDivisions => ((maxTemperature - minTemperature) / 0.5).round();

  void _decreaseTemperature() {
    if (currentTemperature > minTemperature) {
      setState(() {
        currentTemperature = (currentTemperature - 0.5).clamp(minTemperature, maxTemperature);
      });
      // TODO: Implement temperature change action
    }
  }

  void _increaseTemperature() {
    if (currentTemperature < maxTemperature) {
      setState(() {
        currentTemperature = (currentTemperature + 0.5).clamp(minTemperature, maxTemperature);
      });
      // TODO: Implement temperature change action
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DecreaseButton(onTap: _decreaseTemperature),
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
                        value: currentTemperature,
                        min: minTemperature,
                        max: maxTemperature,
                        divisions: temperatureDivisions,
                        onChanged: (value) {
                          setState(() {
                            currentTemperature = value;
                          });
                          // TODO: Implement temperature change action
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
                        _SliderLabel(value: minTemperature.toStringAsFixed(1)),
                        _SliderLabel(value: currentTemperature.toStringAsFixed(1)),
                        _SliderLabel(value: maxTemperature.toStringAsFixed(1)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _IncreaseButton(onTap: _increaseTemperature),
        ],
      ),
    );
  }
}

class _DecreaseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DecreaseButton({required this.onTap});

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

class _IncreaseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _IncreaseButton({required this.onTap});

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

class _SliderLabel extends StatelessWidget {
  final String value;

  const _SliderLabel({required this.value});

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

class _ControlButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;

  const _ControlButton({
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x66FFFFFF), Color(0x00FBBB84)],
            ),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color(0xFFFB9B51),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                imagePath,
                width: 40.0,
                height: 40.0,
                color: const Color(0xFF292929),
              ),
              const SizedBox(width: 16.0),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF292929),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MARK: - Up Right Section

class _UpRightSection extends StatelessWidget {
  const _UpRightSection();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ScrollRowItem(
            iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_timing.png',
            title: '定時設定',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AirConditionerTimerReminderPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 14.0),
          _ScrollRowItem(
            iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/chart.png',
            title: '能源監測',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AirConditionerEnergyMonitoringPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 14.0),
          _ScrollRowItem(
            iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/purifier_fliter.png',
            title: '濾網設定',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AirConditionerFilterSettingPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ScrollRowItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback? onTap;

  const _ScrollRowItem({
    required this.iconPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFFB9B51),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Image.asset(
                iconPath,
                width: 58.0,
                height: 58.0,
                color: const Color(0xFF292929),
              ),
              const SizedBox(width: 24.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF292929),
                    height: 1.4,
                    letterSpacing: 0,
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/arrow_right.png',
                width: 50.0,
                height: 50.0,
                color: const Color(0xFF292929),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridItem extends StatefulWidget {
  final int index;

  const _GridItem({required this.index});

  @override
  State<_GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<_GridItem> {
  late bool _isEnabled;

  @override
  void initState() {
    super.initState();
    final item = _GridItemData.byIndex(widget.index);
    _isEnabled = item.enabled;
  }

  @override
  Widget build(BuildContext context) {
    final item = _GridItemData.byIndex(widget.index);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _isEnabled = !_isEnabled;
          });
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isEnabled ? const Color(0xFFFB9B51) : const Color(0xFF7C7C7C),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
            color: _isEnabled ? const Color(0xFFFB9B51).withOpacity(0.1) : Colors.transparent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                item.iconPath,
                width: 50.0,
                height: 50.0,
                color: _isEnabled ? const Color(0xFFFB9B51) : const Color(0xFF7C7C7C),
              ),
              const SizedBox(width: 8.0),
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w400,
                  color: _isEnabled ? const Color(0xFFFB9B51) : const Color(0xFF7C7C7C),
                  height: 1.4,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridItemData {
  final String key;
  final String iconPath;
  final String title;
  final bool enabled; // Hard code enabled state

  const _GridItemData({
    required this.key,
    required this.iconPath,
    required this.title,
    required this.enabled,
  });

  static _GridItemData byIndex(int index) {
    final items = [
      const _GridItemData(
        key: 'eco',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_eco.png',
        title: 'ECO(節能)',
        enabled: true, // Hard code
      ),
      const _GridItemData(
        key: 'rapid',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_rapidly.png',
        title: '急速',
        enabled: false, // Hard code
      ),
      const _GridItemData(
        key: 'gear',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_gear.png',
        title: '檔位',
        enabled: false, // Hard code
      ),
      const _GridItemData(
        key: 'selfCleaning',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_self_cleaning.png',
        title: '自清洗',
        enabled: false, // Hard code
      ),
      const _GridItemData(
        key: 'antiDirectWind',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_anti_hairdryer.png',
        title: '防直接吹風',
        enabled: false, // Hard code
      ),
      const _GridItemData(
        key: 'leftRightWind',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_left_and_right.png',
        title: '左右風',
        enabled: false, // Hard code
      ),
      const _GridItemData(
        key: 'upDownWind',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_up_and_down.png',
        title: '上下風',
        enabled: false, // Hard code
      ),
      const _GridItemData(
        key: 'led',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_led.png',
        title: 'LED',
        enabled: false, // Hard code
      ),
      const _GridItemData(
        key: 'strongCool',
        iconPath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_strong_cold.png',
        title: '強冷',
        enabled: true, // Hard code: only strongCool is enabled
      ),
    ];
    return items[index];
  }
}

class _ModeBottomSheet extends StatelessWidget {
  const _ModeBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFEFEF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              const Text(
                '模式篩選',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292929),
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
          ),
          const SizedBox(height: 20.0),
          // Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/reset.png',
                  text: '自動',
                  onTap: () {
                    // TODO: Implement mode selection
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/snow_flake.png',
                  text: '冷氣',
                  onTap: () {
                    // TODO: Implement mode selection
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_dry2.png',
                  text: '乾燥',
                  onTap: () {
                    // TODO: Implement mode selection
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_heating.png',
                  text: '暖氣',
                  onTap: () {
                    // TODO: Implement mode selection
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_supply_wind.png',
                  text: '送風',
                  onTap: () {
                    // TODO: Implement mode selection
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          // Complete button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFDB874),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: const Color(0xFF000000),
                  width: 1.0,
                ),
              ),
              child: const Text(
                '完成',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF292929),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheetOptionItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback onTap;
  final bool isRenderColor;

  const _BottomSheetOptionItem({
    required this.imagePath,
    required this.text,
    required this.onTap,
    this.isRenderColor = true,
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
            color: const Color(0xFFFDB874),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              imagePath,
              width: 40.0,
              height: 40.0,
              color: isRenderColor ? const Color(0xFF292929) : null,
            ),
            const SizedBox(width: 16.0),
            Text(
              text,
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

class _FanSpeedBottomSheet extends StatelessWidget {
  const _FanSpeedBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300.0,
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFEFEF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              const Text(
                '風量篩選',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292929),
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
          ),
          const SizedBox(height: 20.0),
          // Options
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_wind_quiet.png',
                  text: '微風',
                  onTap: () {
                    // TODO: Implement fan speed selection
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_wind_low.png',
                  text: '弱風',
                  onTap: () {
                    // TODO: Implement fan speed selection
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_wind_high.png',
                  text: '強風',
                  onTap: () {
                    // TODO: Implement fan speed selection
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _BottomSheetOptionItem(
                  imagePath: 'lib/wh/feature/warehouse/parent/assets/images/common/reset.png',
                  text: '自動',
                  onTap: () {
                    // TODO: Implement fan speed selection
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          // Complete button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFDB874),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: const Color(0xFF000000),
                  width: 1.0,
                ),
              ),
              child: const Text(
                '完成',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF292929),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WindDirectionBottomSheet extends StatelessWidget {
  const _WindDirectionBottomSheet();

  static const String _imageBase = 'lib/wh/feature/warehouse/parent/assets/images/light/air_conditioner_wind_direction';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400.0,
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEFEFEF),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox.shrink(),
              const Text(
                '風向篩選',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292929),
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
          ),
          const SizedBox(height: 20.0),
          // Row[左右風 1~5]
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 1; i <= 5; i++) ...[
                if (i > 1) const SizedBox(width: 16.0),
                Expanded(
                  child: _BottomSheetOptionItem(
                    imagePath: '$_imageBase$i.png',
                    text: '左右風$i',
                    isRenderColor: false,
                    onTap: () {
                      // TODO: Implement wind direction selection
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16.0),
          // Row[上下風 1~5]
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 1; i <= 5; i++) ...[
                if (i > 1) const SizedBox(width: 16.0),
                Expanded(
                  child: _BottomSheetOptionItem(
                    imagePath: '$_imageBase${i + 5}.png',
                    text: '上下風$i',
                    isRenderColor: false,
                    onTap: () {
                      // TODO: Implement wind direction selection
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 20.0),
          // Complete button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFDB874),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: const Color(0xFF000000),
                  width: 1.0,
                ),
              ),
              child: const Text(
                '完成',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF292929),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

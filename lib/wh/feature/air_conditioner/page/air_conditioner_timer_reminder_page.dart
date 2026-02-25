import 'package:engo_terminal_app3/wh/feature/air_conditioner/page/air_conditioner_timer_setting_page.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/first_background_card.dart';
import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/icon_button.dart';
import 'package:flutter/material.dart';

class AirConditionerTimerReminderPage extends StatelessWidget {
  const AirConditionerTimerReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          children: [
            _TopBar(),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '設定一個時間表有助於降低能源消耗，維持舒適',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF292929),
                        height: 1.4,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 48.0),
                    Text(
                      '制定一個適合你的生活方式，\n並提供最佳舒適度的時間表',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF292929),
                        height: 1.4,
                        letterSpacing: 0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 48.0),
                    _AddWeeklyTimerButton(),
                  ],
                ),
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
        const SizedBox(width: 62.0),
      ],
    );
  }
}

class _AddWeeklyTimerButton extends StatelessWidget {
  const _AddWeeklyTimerButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AirConditionerTimerSettingPage(),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x66FFFFFF), Color(0x00FBBB84)],
            ),
            border: Border.all(
              color: const Color(0xFFFB9B51),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/air_conditioner_timing.png',
                width: 50.0,
                height: 50.0,
                color: const Color(0xFF292929),
              ),
              const SizedBox(width: 17.0),
              const Text(
                '新增定時',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF292929),
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

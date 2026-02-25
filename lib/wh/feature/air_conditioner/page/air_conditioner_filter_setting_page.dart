import 'package:engo_terminal_app3/wh/feature/air_conditioner/ui/first_background_card.dart';
import 'package:flutter/material.dart';

class AirConditionerFilterSettingPage extends StatelessWidget {
  const AirConditionerFilterSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstBackgroundCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _TopBar(),
            const SizedBox(height: 48),
            _FilterCard(),
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
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'lib/wh/feature/warehouse/parent/assets/images/common/arrow_left.png',
                color: const Color(0xFFFB9B51),
              ),
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text(
              '濾網管理',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF292929),
                fontSize: 40,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 80),
      ],
    );
  }
}

class _FilterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            color: Color(0xFF292929),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FilterRow(
            title: '歸零計數器',
            titleColor: const Color(0xFF292929),
            trailing: _ResetButton(),
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: const Color(0xFF7C7C7C),
          ),
          const SizedBox(height: 24),
          const _FilterRow(
            title: '倒數濾心更換時間(天)',
            titleColor: Color(0xFFFB9B51),
            trailing: _DaysCounter(days: 180),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String title;
  final Color titleColor;
  final Widget trailing;

  const _FilterRow({
    required this.title,
    required this.titleColor,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontSize: 24,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
        trailing,
      ],
    );
  }
}

class _ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          // TODO: Implement reset counter action
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 2,
                color: Color(0xFFFDB874),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            '重置',
            style: TextStyle(
              color: Color(0xFF292929),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

class _DaysCounter extends StatelessWidget {
  final int days;

  const _DaysCounter({required this.days});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            // TODO: Implement days counter action
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              color: const Color(0xFFD9D9D9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              '$days',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text(
          '天',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

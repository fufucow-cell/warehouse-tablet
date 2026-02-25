import 'package:flutter/material.dart';

class ModePopup extends StatelessWidget {
  final String currentMode;
  final Function(String) onModeSelected;
  final VoidCallback onClose;

  const ModePopup({
    super.key,
    required this.currentMode,
    required this.onModeSelected,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: 16.0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 400.0,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xF0EEEEEE), Color(0xF0FBBB84)],
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: const Color(0xFFFB9B51),
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ModeOption(
                        title: '手動模式',
                        onTap: () => onModeSelected('手動模式'),
                      ),
                      const _Divider(),
                      ModeOption(
                        title: '自動模式',
                        onTap: () => onModeSelected('自動模式'),
                      ),
                      const _Divider(),
                      ModeOption(
                        title: '睡眠模式',
                        onTap: () => onModeSelected('睡眠模式 '),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModeOption extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ModeOption({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
        padding: const EdgeInsets.all(
          24.0,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            color: Color(0xFF292929),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Divider(
        height: 1.0,
        thickness: 1.0,
        color: Color(0xFF292929),
      ),
    );
  }
}

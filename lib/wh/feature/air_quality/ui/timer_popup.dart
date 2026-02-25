import 'package:engo_terminal_app3/wh/feature/air_quality/ui/cust_hour_timer.dart';
import 'package:flutter/material.dart';

class TimerPopup extends StatefulWidget {
  final int currentHour;
  final Function(int) onConfirm;
  final VoidCallback onClose;

  const TimerPopup({
    super.key,
    required this.currentHour,
    required this.onConfirm,
    required this.onClose,
  });

  @override
  State<TimerPopup> createState() => _TimerPopupState();
}

class _TimerPopupState extends State<TimerPopup> {
  late int selectedHour;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.currentHour > 0 ? widget.currentHour : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onClose,
          ),
        ),
        Positioned(
          left: 16.0,
          top: 196.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 150,
                      child: CustHourTimer(
                        initialHour: selectedHour,
                        onTimeChanged: (hour) {
                          if (hour != null) {
                            setState(() {
                              selectedHour = hour;
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      '小時',
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Color(0xFFFB9B51),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16.0),
                IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TimerButton(
                        text: '確認',
                        onTap: () => widget.onConfirm(selectedHour),
                      ),
                      const SizedBox(height: 16.0),
                      TimerButton(
                        text: '取消',
                        onTap: widget.onClose,
                      ),
                      const SizedBox(height: 16.0),
                      TimerButton(
                        text: '清除',
                        onTap: () => widget.onConfirm(0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimerButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const TimerButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8.0);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFB9B51),
            borderRadius: borderRadius,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 32.0,
              color: Color(0xFF292929),
            ),
          ),
        ),
      ),
    );
  }
}

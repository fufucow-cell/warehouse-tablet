import 'package:engo_terminal_app3/wh/feature/air_quality/ui/air_background_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AirQualityFilterPage extends StatefulWidget {
  const AirQualityFilterPage({super.key});

  @override
  State<AirQualityFilterPage> createState() => _AirQualityFilterPageState();
}

class _AirQualityFilterPageState extends State<AirQualityFilterPage> {
  int _filterLifePercent = 80;
  int _filterLifeDays = 180;
  bool _isEditing = false;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _filterLifeDays.toString());
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AirBackgroundCard(
        child: Column(
          children: [
            _TopBar(onBack: () => Navigator.pop(context)),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _LeftInfoSection(
                      filterLifePercent: _filterLifePercent,
                      filterLifeDays: _filterLifeDays,
                      isEditing: _isEditing,
                      textController: _textController,
                      onReset: () {
                        setState(() {
                          _filterLifePercent = 100;
                        });
                      },
                      onEdit: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      onConfirm: () {
                        final newDays = int.tryParse(_textController.text);
                        if (newDays != null && newDays > 0) {
                          setState(() {
                            _filterLifeDays = newDays;
                            _isEditing = false;
                          });
                        }
                      },
                      onCancel: () {
                        setState(() {
                          _textController.text = _filterLifeDays.toString();
                          _isEditing = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: _CircularProgress(percent: _filterLifePercent),
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
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

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
        const Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '濾網設定',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 80),
      ],
    );
  }
}

class _CircularProgress extends StatelessWidget {
  final int percent;

  const _CircularProgress({required this.percent});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: 700,
        height: 700,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF3A3A3A),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _CircularProgressPainter(percent: percent),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/wh/parent/assets/images/common/air_filter.png'),
                      fit: BoxFit.cover,
                    ),
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

class _CircularProgressPainter extends CustomPainter {
  final int percent;

  _CircularProgressPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    const strokeWidth = 30.0;
    final paint = Paint()
      ..color = const Color(0xFF5DADE2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    const radius = 350 - strokeWidth / 2;

    final progressAngle = (percent / 100) * 2 * 3.14159;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(
      rect,
      -1.57,
      progressAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}

class _LeftInfoSection extends StatelessWidget {
  final int filterLifePercent;
  final int filterLifeDays;
  final bool isEditing;
  final TextEditingController textController;
  final VoidCallback onReset;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _LeftInfoSection({
    required this.filterLifePercent,
    required this.filterLifeDays,
    required this.isEditing,
    required this.textController,
    required this.onReset,
    required this.onEdit,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '濾網壽命:$filterLifePercent%',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        _ResetButton(onTap: onReset),
        const SizedBox(height: 24),
        _FilterLifeDaysInput(
          textController: textController,
          isEditing: isEditing,
          onEdit: onEdit,
          onConfirm: onConfirm,
          onCancel: onCancel,
        ),
      ],
    );
  }
}

class _PositiveIntegerFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (!RegExp(r'^\d+$').hasMatch(newValue.text)) {
      return oldValue;
    }

    final intValue = int.tryParse(newValue.text);
    if (intValue == null) {
      return oldValue;
    }

    if (intValue <= 0) {
      return oldValue;
    }

    return newValue;
  }
}

class _FilterLifeDaysInput extends StatelessWidget {
  final TextEditingController textController;
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const _FilterLifeDaysInput({
    required this.textController,
    required this.isEditing,
    required this.onEdit,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          child: TextField(
            controller: textController,
            textAlign: TextAlign.center,
            readOnly: !isEditing,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _PositiveIntegerFormatter(),
            ],
            style: const TextStyle(fontSize: 32, color: Colors.black),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFFDB874)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFFDB874)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFFDB874)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          '日',
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
        const SizedBox(width: 32),
        _EditButton(
          isEditing: isEditing,
          onEdit: onEdit,
          onConfirm: onConfirm,
        ),
        if (isEditing) ...[
          const SizedBox(width: 8),
          _CancelButton(onCancel: onCancel),
        ],
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onEdit;
  final VoidCallback onConfirm;

  const _EditButton({
    required this.isEditing,
    required this.onEdit,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFFFDB874),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: isEditing ? onConfirm : onEdit,
          borderRadius: borderRadius,
          child: Container(
            alignment: Alignment.center,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              isEditing ? '確認' : '編輯',
              style: const TextStyle(
                fontSize: 26,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onCancel;

  const _CancelButton({required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(8);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFFFDB874),
          ),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: onCancel,
          borderRadius: borderRadius,
          child: Container(
            alignment: Alignment.center,
            height: 90,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const Text(
              '取消',
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFFFDB874),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ResetButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0x99FFFFFF), Color(0x00FBBB84)],
          ),
          border: Border.all(
            width: 1,
            color: const Color(0xFFFDB874),
          ),
          borderRadius: borderRadius,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Container(
            width: 340,
            padding: const EdgeInsets.all(
              16,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/wh/parent/assets/images/common/reset.png',
                  width: 70,
                  height: 70,
                  color: Colors.black,
                ),
                const SizedBox(width: 16),
                const Text(
                  '重置濾網',
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

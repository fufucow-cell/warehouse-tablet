import 'package:flutter/material.dart';

class DeviceManagementBottomSheet extends StatelessWidget {
  const DeviceManagementBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.8,
        right: 16.8,
        top: 16.8,
        bottom: 22.4,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.8),
          topRight: Radius.circular(16.8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '裝置管理',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 22.4),
          _OptionItem(
            text: '掃描 QR Code 新增',
            onTap: () {
              Navigator.pop(context);
              // Handle scan QR code
            },
          ),
          const SizedBox(height: 11.2),
          const Divider(
            height: 0.7,
            thickness: 0.7,
            color: Color(0xFF999999),
          ),
          const SizedBox(height: 11.2),
          _OptionItem(
            text: '快速新增',
            onTap: () {
              Navigator.pop(context);
              // Handle quick add
            },
          ),
          const SizedBox(height: 11.2),
          const Divider(
            height: 0.7,
            thickness: 0.7,
            color: Color(0xFF999999),
          ),
          const SizedBox(height: 22.4),
          Material(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.4),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              borderRadius: BorderRadius.circular(8.4),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 164.5,
                  vertical: 16.8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.7,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(8.4),
                ),
                child: const Center(
                  child: Text(
                    '取消',
                    style: TextStyle(
                      fontSize: 22.4,
                      fontWeight: FontWeight.normal,
                      color: Color(0xFF333333),
                    ),
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

class _OptionItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _OptionItem({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.6),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 22.4,
              fontWeight: FontWeight.normal,
              color: Color(0xFF333333),
            ),
          ),
        ),
      ),
    );
  }
}

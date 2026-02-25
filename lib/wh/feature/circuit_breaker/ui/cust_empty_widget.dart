import 'package:flutter/material.dart';

class CustEmptyWidget extends StatelessWidget {
  const CustEmptyWidget({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'lib/wh/feature/warehouse/parent/assets/images/common/empty.png',
            width: 295.4,
            height: 208.6,
          ),
          const SizedBox(height: 16.8),
          const Text(
            '尚無資料',
            style: TextStyle(
              fontSize: 19.6,
              color: Color(0xFFBDBDBD),
            ),
          ),
        ],
      ),
    );
  }
}

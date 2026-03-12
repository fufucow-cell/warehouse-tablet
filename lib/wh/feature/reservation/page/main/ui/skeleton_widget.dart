import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_shimmer_widget.dart';
import 'package:flutter/material.dart';

class SkeletonWidget extends StatelessWidget {
  const SkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(24.0.scale),
      itemCount: 6,
      separatorBuilder: (_, __) => SizedBox(height: 16.0.scale),
      itemBuilder: (context, index) {
        return ShimmerWidget(
          height: 112.0.scale,
          child: Container(
            height: 112.0.scale,
            padding: EdgeInsets.symmetric(
              horizontal: 24.0.scale,
              vertical: 16.0.scale,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0.scale),
            ),
            child: Row(
              children: [
                Container(
                  width: 10.0.scale,
                  height: 52.0.scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100.0.scale),
                  ),
                ),
                SizedBox(width: 16.0.scale),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShimmerWidget(
                        height: 26.0.scale,
                        width: 240.0.scale,
                      ),
                      SizedBox(height: 12.0.scale),
                      ShimmerWidget(
                        height: 20.0.scale,
                        width: 360.0.scale,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16.0.scale),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShimmerWidget(
                      height: 20.0.scale,
                      width: 120.0.scale,
                    ),
                    SizedBox(height: 12.0.scale),
                    ShimmerWidget(
                      height: 20.0.scale,
                      width: 80.0.scale,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_empty_image.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/ui/cust_shimmer_widget.dart';

class CustNetworkImage extends StatelessWidget {
  const CustNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    final loadingSize = height ?? width ?? double.infinity;
    Widget imageWidget = Image.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox(
          width: loadingSize,
          height: loadingSize,
          child: ShimmerWidget(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey[300],
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => CustEmptyImage(
        width: width,
        height: height,
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0.scale),
      child: imageWidget,
    );
  }
}

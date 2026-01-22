import 'package:engo_terminal_app3/wh/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/api_service/api_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_empty_image.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/ui/cust_shimmer_widget.dart';
import 'package:flutter/material.dart';

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
    final apiService = ApiService.instance;
    final headers = {
      'Authorization': apiService.getAccessToken,
      'App-Code': 'APP_MEMBER',
    };
    final loadingSize = height ?? width ?? double.infinity;
    Widget imageWidget = Image.network(
      url,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      headers: headers,
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
        width: width ?? loadingSize,
        height: height ?? loadingSize,
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0.scale),
      child: imageWidget,
    );
  }
}

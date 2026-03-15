import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const ImageViewer({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(16.0.scale),
      backgroundColor: Colors.black,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final url = widget.images[index];
                  return Center(
                    child: InteractiveViewer(
                      minScale: 1,
                      maxScale: 4,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: url.isEmpty
                            ? Container(
                                color: EnumColor.backgroundSecondary.color,
                                child: Icon(
                                  Icons.image_outlined,
                                  size: 40.0.scale,
                                  color: EnumColor.iconSecondary.color,
                                ),
                              )
                            : CustNetworkImage(
                                url: url,
                                fit: BoxFit.contain,
                              ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                top: 18.0.scale,
                right: 18.0.scale,
                child: IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 64.0.scale,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              if (widget.images.length > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 24.0.scale,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.images.length,
                      (index) => Container(
                        width: 18.0.scale,
                        height: 18.0.scale,
                        margin: EdgeInsets.symmetric(horizontal: 4.0.scale),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/inherit/base_page_controller.dart';
import 'package:get/get.dart';

part 'smart_home_room_page_controller.dart';
part 'smart_home_room_page_interactive.dart';
part 'smart_home_room_page_model.dart';
part 'smart_home_room_page_route.dart';

class SmartHomeRoomPage extends GetView<SmartHomeRoomPageController> {
  const SmartHomeRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeRoomPageController>(
      init: SmartHomeRoomPageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('房間'),
          ),
          body: _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<SmartHomeRoomPageController>();

    return Container();
  }
}

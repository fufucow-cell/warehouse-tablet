import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/reservable/reservation_reservable_page_controller.dart';

class ReservationReservablePage
    extends GetView<ReservationReservablePageController> {
  const ReservationReservablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationReservablePageController>(
      init: ReservationReservablePageController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Title'),
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
    // final controller = Get.find<ReservationReservablePageController>();

    return Container();
  }
}

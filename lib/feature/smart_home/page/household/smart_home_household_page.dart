import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/service/smart_home_service.dart';
import 'package:flutter_smart_home_tablet/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/model/request_model/home_household_request_model.dart';
import 'package:flutter_smart_home_tablet/model/response_model/home_household_response_model.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:flutter_smart_home_tablet/util/api_util.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'smart_home_household_page_controller.dart';
part 'smart_home_household_page_interactive.dart';
part 'smart_home_household_page_model.dart';
part 'smart_home_household_page_route.dart';

class SmartHomeHouseholdPage
    extends GetView<SmartHomeHouseholdPageController> {
  const SmartHomeHouseholdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeHouseholdPageController>(
      init: SmartHomeHouseholdPageController(),
      builder: (controller) {
        return CustScaffold(
          title: '家庭',
          showBackButton: false,
          child: Obx(
            () {
              return Skeletonizer(
                enabled: controller.isLoadingRx.value,
                child: _Body(),
              );
            },
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<SmartHomeHouseholdPageController>();

    if (controller.hasHousehold) {
      return _HouseholdContent();
    } else {
      return _EmptyHouseholdContent();
    }
  }
}

class _HouseholdContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<SmartHomeHouseholdPageController>();
    final householdData = controller.householdData;

    if (householdData == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 家庭名称
          Text(
            '家庭名称: ${householdData.homeName ?? '未命名'}',
            style:
                Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          // 房间列表
          if (householdData.rooms != null &&
              householdData.rooms!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '房间列表:',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge,
                ),
                const SizedBox(height: 12),
                ...householdData.rooms!.map(
                  (room) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      child: ListTile(
                        title:
                            Text(room.roomName ?? '未命名房间'),
                        subtitle:
                            Text('房间 ID: ${room.roomId}'),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Text(
              '暂无房间',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant,
                  ),
            ),
        ],
      ),
    );
  }
}

class _EmptyHouseholdContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller =
        Get.find<SmartHomeHouseholdPageController>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_outlined,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),
            const SizedBox(height: 24),
            Text(
              '目前尚未建立家庭',
              style:
                  Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            // 家庭名称输入框
            TextField(
              controller: controller.homeNameController,
              decoration: const InputDecoration(
                labelText: '家庭名称',
                hintText: '请输入家庭名称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            // 建立家庭按钮
            ElevatedButton(
              onPressed: controller.isLoading
                  ? null
                  : () => controller.createHome(),
              child: controller.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('建立家庭'),
            ),
          ],
        ),
      ),
    );
  }
}

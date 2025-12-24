import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/smart_home/service/smart_home_service.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/api_constant.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/base_page_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/request_model/home_household_request_model/home_household_request_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/home_household_response_model/home_household_response_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/user_login_response_model/household.dart';
import 'package:flutter_smart_home_tablet/ui/cust_scaffold.dart';
import 'package:flutter_smart_home_tablet/util/api_util.dart';
import 'package:get/get.dart';

part 'smart_home_household_page_controller.dart';
part 'smart_home_household_page_interactive.dart';
part 'smart_home_household_page_model.dart';
part 'smart_home_household_page_route.dart';

class SmartHomeHouseholdPage extends GetView<SmartHomeHouseholdPageController> {
  const SmartHomeHouseholdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeHouseholdPageController>(
      init: SmartHomeHouseholdPageController(),
      builder: (controller) {
        return CustScaffold(
          title: EnumLocale.smartHomeTabHousehold.tr,
          showBackButton: false,
          child: _Body(),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeHouseholdPageController>(
      builder: (controller) {
        if (controller.hasHousehold) {
          return _HouseholdContent();
        } else {
          return _EmptyHouseholdContent();
        }
      },
    );
  }
}

class _HouseholdContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SmartHomeHouseholdPageController>(
      builder: (controller) {
        final householdData = controller.householdData;

        if (householdData == null) {
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 家庭切换下拉菜单
              if (controller.householdList != null && controller.householdList!.length > 1)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                EnumLocale.smartHomeSwitchHousehold.tr,
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                              ),
                              const SizedBox(height: 8),
                              GetBuilder<SmartHomeHouseholdPageController>(
                                builder: (controller) => DropdownButton<Household>(
                                  value: controller.currentHousehold,
                                  isExpanded: true,
                                  underline: Container(),
                                  items: controller.householdList!.map((household) {
                                    return DropdownMenuItem<Household>(
                                      value: household,
                                      child: Text(
                                        household.homeName ?? EnumLocale.smartHomeUnnamedHousehold.tr,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (
                                    Household? newHousehold,
                                  ) {
                                    if (newHousehold != null) {
                                      controller.interactive(
                                        EnumSmartHomeHouseholdPageInteractive.tapHomeItem,
                                        data: newHousehold,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (controller.householdList != null && controller.householdList!.length > 1) const SizedBox(height: 16),
              // 家庭名称
              Text(
                '${EnumLocale.smartHomeHouseholdName.tr}: ${householdData.homeName ?? EnumLocale.smartHomeUnnamed.tr}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 24),
              // 房间列表
              if (householdData.rooms != null && householdData.rooms!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${EnumLocale.smartHomeRoomList.tr}：',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 12),
                    ...householdData.rooms!.map(
                      (room) => Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8.0,
                        ),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              room.roomName ?? EnumLocale.smartHomeUnnamedRoom.tr,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  EnumLocale.smartHomeNoRoom.tr,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyHouseholdContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SmartHomeHouseholdPageController>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 24),
            Text(
              EnumLocale.smartHomeNoHouseholdYet.tr,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 32),
            // 家庭名称输入框
            TextField(
              controller: controller.homeNameController,
              decoration: InputDecoration(
                labelText: EnumLocale.smartHomeHouseholdName.tr,
                hintText: EnumLocale.smartHomeHouseholdNameHint.tr,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            // 建立家庭按钮
            ElevatedButton(
              onPressed: controller.isLoading ? null : () => controller.createHome(),
              child: controller.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      EnumLocale.smartHomeCreateHousehold.tr,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

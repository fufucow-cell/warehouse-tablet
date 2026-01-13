import 'package:engo_terminal_app3/ui/cust_scaffold.dart';
import 'package:engo_terminal_app3/feature/smart_home/service/smart_home_service.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/home_household_response_model/home_household_response_model.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/model/response_model/home_household_response_model/room.dart';
import 'package:engo_terminal_app3/wh/feature/warehouse/parent/service/locale_service/locale/locale_map.dart';
import 'package:flutter/material.dart';
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
        final householdData = controller.householdData;

        if (householdData == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Home Info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Home Info',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      _InfoRow(
                        label: 'Household ID',
                        value: householdData.householdId ?? '-',
                      ),
                      _InfoRow(
                        label: 'Home Name',
                        value: householdData.homeName ?? EnumLocale.smartHomeUnnamed.tr,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Room List Info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Room List Info',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      if (householdData.rooms != null && householdData.rooms!.isNotEmpty)
                        ...householdData.rooms!.asMap().entries.map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: _RoomInfoCard(room: entry.value, index: entry.key),
                              ),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomInfoCard extends StatelessWidget {
  final Room room;
  final int index;

  const _RoomInfoCard({
    required this.room,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Room ${index + 1}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          _InfoRow(
            label: 'Room ID',
            value: room.id?.toString() ?? '-',
          ),
          _InfoRow(
            label: 'Room Name',
            value: room.roomName ?? EnumLocale.smartHomeUnnamedRoom.tr,
          ),
        ],
      ),
    );
  }
}

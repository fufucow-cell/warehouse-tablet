import 'package:engo_terminal_app3/wh/feature/reservation/page/record/reservation_record_page_controller.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabContentSection extends StatelessWidget {
  const TabContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationRecordPageController>();

    return Obx(() {
      final selectedIndex = controller.selectedTabIndexRx.value;
      return selectedIndex == 0 ? const CustomerInfoTable() : const ItemsTable();
    });
  }
}

class CustomerInfoTable extends StatelessWidget {
  const CustomerInfoTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationRecordPageController>();
    final item = controller.getRecordItem;
    final user = item.userInfo;
    final community = item.communityInfo;

    return Column(
      children: [
        _InfoRow(
          title: '社區',
          value: community.communityName,
        ),
        spaceH,
        _InfoRow(
          title: '房號',
          value: community.householdName,
        ),
        spaceH,
        _InfoRow(
          title: '地址',
          value: community.address,
        ),
        spaceH,
        _InfoRow(
          title: '手機',
          value: user.phone,
        ),
        spaceH,
        _InfoRow(
          title: '郵箱',
          value: user.email,
        ),
      ],
    );
  }
}

class ItemsTable extends StatelessWidget {
  const ItemsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationRecordPageController>();
    final item = controller.getRecordItem;
    final reservable = item.itemReservableInfo;

    return Container(
      margin: EdgeInsets.only(top: 12.0.scale),
      decoration: BoxDecoration(
        border: Border.all(color: EnumColor.lineBorder.color, width: 1.0.scale),
      ),
      child: Column(
        children: [
          const _TableHeader(
            columns: ['品項名稱', '預約時段', '金額', '狀態'],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _TableRow(
                values: [
                  reservable.name,
                  // '${controller.formatDateTime(item.bookingStartAt)} ~ ${controller.formatDateTime(item.bookingEndAt)}',
                  '\$${item.totalAmount}',
                  item.orderType.localeTitle,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final List<String> columns;

  const _TableHeader({required this.columns});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: EnumColor.backgroundSecondary.color,
      padding: EdgeInsets.symmetric(vertical: 12.0.scale),
      child: Row(
        children: columns
            .map(
              (col) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.scale),
                  child: CustTextWidget(
                    col,
                    size: 14.0.scale,
                    weightType: EnumFontWeightType.semibold,
                    color: EnumColor.textPrimary.color,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TableRow extends StatelessWidget {
  final List<String> values;

  const _TableRow({required this.values});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0.scale),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: EnumColor.lineBorder.color, width: 1.0.scale),
        ),
      ),
      child: Row(
        children: values
            .map(
              (val) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.scale),
                  child: CustTextWidget(
                    val,
                    size: 14.0.scale,
                    color: EnumColor.textPrimary.color,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustTextWidget(
          title,
          size: 36.0.scale,
          color: EnumColor.textPrimary.color,
          weightType: EnumFontWeightType.bold,
        ),
        spaceW,
        CustTextWidget(
          value,
          size: 28.0.scale,
          color: EnumColor.textPrimary.color,
        ),
      ],
    );
  }
}

Widget get spaceH => SizedBox(height: 12.0.scale);
Widget get spaceW => SizedBox(width: 12.0.scale);

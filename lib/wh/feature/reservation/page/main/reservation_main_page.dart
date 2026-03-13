import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_controller.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/main/reservation_main_page_model.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/main/ui/record_cell.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/main/ui/reservable_cell.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/page/main/ui/skeleton_widget.dart';
import 'package:engo_terminal_app3/wh/feature/reservation/service/reservation_service.dart';
import 'package:engo_terminal_app3/wh/parent/constant/widget_constant.dart';
import 'package:engo_terminal_app3/wh/parent/inherit/extension_double.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/color_map.dart';
import 'package:engo_terminal_app3/wh/parent/service/theme_service/theme/image_map.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_empty_widget.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_grid_view.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_tab_bar.dart';
import 'package:engo_terminal_app3/wh/parent/ui/cust_text_widget.dart';
import 'package:engo_terminal_app3/wh/parent/ui/first_background_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReservationMainPage extends StatelessWidget {
  const ReservationMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReservationMainPageController>(
      init: ReservationMainPageController(),
      builder: (controller) {
        controller.setContext(context);
        return Scaffold(
          body: FirstBackgroundCard(
            child: Column(
              children: [
                _TopBar(),
                _FilterSection(),
                Expanded(
                  child: _Body(controller: controller),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationMainPageController>();
    return Row(
      children: [
        Expanded(
          child: CustTextWidget(
            '預約',
            size: 40.0.scale,
            weightType: EnumFontWeightType.bold,
            align: TextAlign.center,
            color: EnumColor.engoTextPrimary.color,
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              controller.interactive(EnumReservationMainPageInteractive.tapRefresh);
            },
            child: EnumImage.cRefresh2.image(
              size: Size.square(48.0.scale),
              color: EnumColor.engoTextPrimary.color,
            ),
          ),
        ),
      ],
    );
  }
}

class _FilterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservationMainPageController>();
    return Obx(
      () {
        final mainTabIndex = controller.selectedTabIndexRx.value;

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0.scale),
          child: Column(
            children: [
              SizedBox(
                height: 100.0.scale,
                child: CustTabBar(
                  titles: controller.getTabTitles,
                  selectedIndex: controller.selectedTabIndexRx.value.index,
                  onChanged: (index) {
                    controller.interactive(EnumReservationMainPageInteractive.switchTabItem, data: index);
                  },
                ),
              ),
              if (mainTabIndex == EnumMainPageTabIndex.record)
                Container(
                  margin: EdgeInsets.only(top: 20.0.scale),
                  height: 70.0.scale,
                  child: CustTabBar(
                    titles: controller.getRecordTypeTitles,
                    selectedIndex: controller.selectedRecordTypeRx.value.index,
                    onChanged: (index) {
                      controller.interactive(EnumReservationMainPageInteractive.switchRecordTypeItem, data: index);
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _Body extends StatelessWidget {
  final ReservationMainPageController controller;

  const _Body({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedTab = controller.selectedTabIndexRx.value;
      final status = controller.dataLoadStatus;

      if (status == EnumDataLoadStatus.loading) {
        return const SkeletonWidget();
      }

      if (status == EnumDataLoadStatus.empty) {
        return const CustEmptyWidget();
      }

      if (selectedTab == EnumMainPageTabIndex.reservable) {
        final items = controller.reservableItemsRx.value ?? <ReservableItemModel>[];
        return CustGridView(
          itemCount: items.length,
          crossAxisCount: 2,
          padding: EdgeInsets.only(bottom: 20.0.scale),
          mainAxisSpacing: 16.0.scale,
          crossAxisSpacing: 16.0.scale,
          itemBuilder: (context, index) {
            final item = items[index];
            return ReservableCell(
              item: item,
            );
          },
        );
      } else if (selectedTab == EnumMainPageTabIndex.record) {
        final items = controller.recordFilterItemsRx.value ?? <RecordItemModel>[];
        return CustGridView(
          itemCount: items.length,
          crossAxisCount: 2,
          padding: EdgeInsets.only(bottom: 20.0.scale),
          mainAxisSpacing: 16.0.scale,
          crossAxisSpacing: 16.0.scale,
          itemBuilder: (context, index) {
            final item = items[index];
            return RecordCell(
              item: item,
            );
          },
        );
      }

      return Container();
    });
  }
}

// class _ContentLeftPanel extends StatelessWidget {
//   final ReservationMainPageController controller;
//   final ReservationItemModel item;

//   const _ContentLeftPanel({
//     required this.controller,
//     required this.item,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _GallerySection(item: item),
//         const SizedBox(height: 12),
//         Row(
//           children: [
//             Expanded(
//               child: Text(
//                 item.name,
//                 style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                       fontWeight: FontWeight.w700,
//                     ),
//               ),
//             ),
//             IconButton(
//               onPressed: () {},
//               icon: const Icon(Icons.favorite_border),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text('位置：${item.categoryText.isEmpty ? '-' : item.categoryText}'),
//         Text('開放時段：${_formatOpening(item)}'),
//         Text('招待限制：${item.dateRuleLabel}'),
//         Text('容納人數限制：${item.totalPeopleLimit <= 0 ? '無限制' : item.totalPeopleLimit}'),
//         const SizedBox(height: 14),
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(6),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: Row(
//                   children: [
//                     _TabButton(
//                       title: '說明',
//                       icon: Icons.home_outlined,
//                       selected: controller.selectedInfoTabIndex == 0,
//                       onTap: () {
//                         controller.setInfoTabIndex(0);
//                       },
//                     ),
//                     const SizedBox(width: 6),
//                     _TabButton(
//                       title: '規格',
//                       icon: Icons.inventory_2_outlined,
//                       selected: controller.selectedInfoTabIndex == 1,
//                       onTap: () {
//                         controller.setInfoTabIndex(1);
//                       },
//                     ),
//                     const SizedBox(width: 6),
//                     _TabButton(
//                       title: '注意事項',
//                       icon: Icons.error_outline,
//                       selected: controller.selectedInfoTabIndex == 2,
//                       onTap: () {
//                         controller.setInfoTabIndex(2);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               const Divider(height: 1),
//               SizedBox(
//                 height: 240,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.all(12),
//                   child: Text(
//                     _tabContentText(item, controller.selectedInfoTabIndex),
//                     style: Theme.of(context).textTheme.bodyMedium,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   String _tabContentText(ReservationItemModel item, int index) {
//     switch (index) {
//       case 0:
//         return item.descriptionText.isEmpty ? '尚無說明內容' : item.descriptionText;
//       case 1:
//         return item.specificationText.isEmpty ? '尚無規格內容' : item.specificationText;
//       case 2:
//         return item.noticeText.isEmpty ? '尚無注意事項' : item.noticeText;
//       default:
//         return '';
//     }
//   }

//   String _formatOpening(ReservationItemModel item) {
//     final String openAt = item.bookingOpenAt.replaceFirst('T', ' ');
//     final String closeAt = item.bookingCloseAt.replaceFirst('T', ' ');
//     if (openAt.trim().isEmpty && closeAt.trim().isEmpty) {
//       return '未設定';
//     }
//     return '$openAt ~ $closeAt';
//   }
// }

// class _GallerySection extends StatelessWidget {
//   final ReservationItemModel item;

//   const _GallerySection({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     final List<String> images = item.imageUrls;

//     Widget imageAt(int index) {
//       final String? url = index < images.length ? images[index] : null;
//       if (url != null && url.isNotEmpty) {
//         return ClipRRect(
//           borderRadius: BorderRadius.circular(6),
//           child: Image.network(
//             url,
//             fit: BoxFit.cover,
//             errorBuilder: (_, __, ___) {
//               return _ImagePlaceholder();
//             },
//           ),
//         );
//       }
//       return _ImagePlaceholder();
//     }

//     return Row(
//       children: [
//         Expanded(
//           flex: 4,
//           child: AspectRatio(
//             aspectRatio: 16 / 9,
//             child: imageAt(0),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Expanded(
//           flex: 2,
//           child: Column(
//             children: [
//               AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: imageAt(1),
//               ),
//               const SizedBox(height: 8),
//               AspectRatio(
//                 aspectRatio: 16 / 9,
//                 child: imageAt(2),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ImagePlaceholder extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: const Center(
//         child: Icon(Icons.image_outlined, color: Colors.grey),
//       ),
//     );
//   }
// }

// class _TabButton extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   final bool selected;
//   final VoidCallback onTap;

//   const _TabButton({
//     required this.title,
//     required this.icon,
//     required this.selected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final Color selectedColor = Theme.of(context).colorScheme.primary;
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(6),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         decoration: BoxDecoration(
//           color: selected ? selectedColor.withOpacity(0.12) : Colors.transparent,
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               size: 18,
//               color: selected ? selectedColor : Colors.black54,
//             ),
//             const SizedBox(width: 6),
//             Text(
//               title,
//               style: TextStyle(
//                 color: selected ? selectedColor : Colors.black87,
//                 fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _BookingPanel extends StatelessWidget {
//   final ReservationMainPageController controller;
//   final ReservationItemModel item;

//   const _BookingPanel({
//     required this.controller,
//     required this.item,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(6),
//         color: Colors.white,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             '\$${item.unitPrice} / 小時',
//             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                   fontWeight: FontWeight.w700,
//                 ),
//           ),
//           const SizedBox(height: 8),
//           _DropdownField(
//             value: controller.selectedDateOption,
//             items: controller.dateOptions,
//             onChanged: (String value) {
//               controller.setDateOption(value);
//             },
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Expanded(
//                 child: _DropdownField(
//                   value: controller.selectedStartTime,
//                   items: controller.timeOptions,
//                   onChanged: (String value) {
//                     controller.setStartTime(value);
//                   },
//                 ),
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: _DropdownField(
//                   value: controller.selectedEndTime,
//                   items: controller.timeOptions,
//                   onChanged: (String value) {
//                     controller.setEndTime(value);
//                   },
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           _DropdownField(
//             value: controller.selectedPeople,
//             items: controller.peopleOptions,
//             onChanged: (String value) {
//               controller.setPeopleOption(value);
//             },
//           ),
//           const SizedBox(height: 12),
//           FilledButton(
//             onPressed: () {
//               controller.reserveItem(item);
//             },
//             child: const Text('預約'),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             '共 ${controller.totalHours} 小時',
//             textAlign: TextAlign.right,
//             style: const TextStyle(
//               color: Colors.redAccent,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Text(
//             '總計 \$ ${controller.totalPrice}',
//             textAlign: TextAlign.right,
//             style: const TextStyle(
//               color: Colors.redAccent,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DropdownField extends StatelessWidget {
//   final String value;
//   final List<String> items;
//   final ValueChanged<String> onChanged;

//   const _DropdownField({
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: items.contains(value) ? value : null,
//       isExpanded: true,
//       decoration: const InputDecoration(
//         isDense: true,
//         border: OutlineInputBorder(),
//         contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       ),
//       items: items.map((String item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           child: Text(item),
//         );
//       }).toList(),
//       onChanged: (String? value) {
//         if (value != null) {
//           onChanged(value);
//         }
//       },
//     );
//   }
// }

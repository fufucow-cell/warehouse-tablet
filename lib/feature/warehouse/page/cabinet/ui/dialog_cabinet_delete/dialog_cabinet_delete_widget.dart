import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_delete/dialog_cabinet_delete_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/cabinet/ui/dialog_cabinet_delete/dialog_cabinet_delete_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_item_response_model/cabinet.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogCabinetDeleteWidget extends StatelessWidget {
  final Future<bool> Function(DialogCabinetDeleteOutputModel) onConfirm;
  final Cabinet cabinet;

  const DialogCabinetDeleteWidget({
    super.key,
    required this.onConfirm,
    required this.cabinet,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogCabinetDeleteWidgetController>(
      init: DialogCabinetDeleteWidgetController(cabinet),
      builder: (controller) {
        return DialogFrame(
          width: 720.0.scale,
          minHeight: 385.0.scale,
          header: DialogHeader(title: EnumLocale.deleteCabinetTitle.tr),
          footer: Obx(
            () {
              final isLoading = controller.isLoadingRx.value;
              return DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                isLoading: isLoading,
                onCancel: () {
                  controller.interactive(
                    EnumDialogCabinetDeleteWidgetInteractive.tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  final outputModel = await controller.checkOutputModel();

                  if (outputModel == null) {
                    return;
                  }

                  controller.interactive(
                    EnumDialogCabinetDeleteWidgetInteractive.tapDialogConfirmButton,
                    data: true,
                  );
                  final isSuccess = await onConfirm(outputModel);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogCabinetDeleteWidgetInteractive.tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogCabinetDeleteWidgetInteractive.tapDialogConfirmButton,
                    data: false,
                  );
                },
              );
            },
          ),
          child: SizedBox(
            width: double.infinity,
            child: WidgetUtil.textWidget(
              controller.getMessage(),
              size: 28.0.scale,
              color: EnumColor.textPrimary.color,
              align: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}

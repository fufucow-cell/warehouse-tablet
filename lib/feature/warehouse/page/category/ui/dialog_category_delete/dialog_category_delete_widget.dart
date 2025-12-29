import 'package:flutter/material.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_delete/dialog_category_delete_widget_controller.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/category/ui/dialog_category_delete/dialog_category_delete_widget_model.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/footer.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/frame.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/page/ui/dialog/ui/header.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/locales/locale_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/constant/theme/color_map.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/inherit/extension_double.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/model/response_model/warehouse_category_response_model/category.dart';
import 'package:flutter_smart_home_tablet/feature/warehouse/parent/util/widget_util.dart';
import 'package:get/get.dart';

class DialogCategoryDeleteWidget extends StatelessWidget {
  final Future<bool> Function(DialogCategoryDeleteOutputModel) onConfirm;
  final Category category;

  const DialogCategoryDeleteWidget({
    super.key,
    required this.onConfirm,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogCategoryDeleteWidgetController>(
      init: DialogCategoryDeleteWidgetController(category),
      builder: (controller) {
        return DialogFrame(
          width: 720.0.scale,
          minHeight: 385.0.scale,
          header: DialogHeader(title: EnumLocale.deleteCategoryTitle.tr),
          footer: Obx(
            () {
              final isLoading = controller.isLoadingRx.value;
              return DialogFooter(
                type: DialogFooterType.cancelAndConfirm,
                isLoading: isLoading,
                onCancel: () {
                  controller.interactive(
                    EnumDialogCategoryDeleteWidgetInteractive
                        .tapDialogCancelButton,
                    data: context,
                  );
                },
                onConfirm: () async {
                  final outputModel = await controller.checkOutputModel();

                  if (outputModel == null) {
                    return;
                  }

                  controller.interactive(
                    EnumDialogCategoryDeleteWidgetInteractive
                        .tapDialogConfirmButton,
                    data: true,
                  );
                  final isSuccess = await onConfirm(outputModel);

                  if (isSuccess) {
                    controller.interactive(
                      EnumDialogCategoryDeleteWidgetInteractive
                          .tapDialogConfirmButton,
                      data: context,
                    );
                  }

                  controller.interactive(
                    EnumDialogCategoryDeleteWidgetInteractive
                        .tapDialogConfirmButton,
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

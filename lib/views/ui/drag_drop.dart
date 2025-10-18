import 'package:flatten/controllers/ui/drag_and_drop_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class DragDropPage extends StatefulWidget {
  const DragDropPage({super.key});

  @override
  State<DragDropPage> createState() => _DragDropPageState();
}

class _DragDropPageState extends State<DragDropPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late DragDropController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DragDropController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "${"drag".tr()} & ${"drop".tr()}",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'ui'.tr()),
                        MyBreadcrumbItem(
                            name: "${"drag".tr()} & ${"drop".tr()}",
                            active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: MyContainer.bordered(
                    width: MediaQuery.of(context).size.width,
                    padding: MySpacing.xy(20, 20),
                    child: ReorderableListView(
                      proxyDecorator: (child, index, animation) {
                        return Material(
                          child: MyCard(
                            shadow: MyShadow(elevation: 0.5),
                            paddingAll: 0,
                            child: child,
                          ),
                        );
                      },
                      buildDefaultDragHandles: false,
                      shrinkWrap: true,
                      onReorder: controller.onReorder,
                      children: controller.customers
                          .mapIndexed((index, element) => ListTile(
                                key: Key('${index}'),
                                leading: ReorderableDragStartListener(
                                    index: index,
                                    child: MouseRegion(
                                        cursor: SystemMouseCursors.grabbing,
                                        child: Icon(
                                          LucideIcons.grip_vertical,
                                          size: 20,
                                        ))),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: MyText.labelMedium(
                                        ' ${element.fullName}',
                                      ),
                                    ),
                                    Expanded(
                                      child: MyText.labelMedium(
                                          ' ${element.phoneNumber}',
                                          textAlign: TextAlign.start),
                                    ),
                                    Expanded(
                                      child: MyText.labelMedium(
                                          ' ${element.balance}'),
                                    ),
                                    Container(
                                      constraints:
                                          BoxConstraints(maxWidth: 100),
                                      child: Icon(
                                        LucideIcons.trash_2,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flatten/controllers/other/basic_table_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';

class BasicTablesPage extends StatefulWidget {
  const BasicTablesPage({super.key});

  @override
  _BasicTablesPageState createState() => _BasicTablesPageState();
}

class _BasicTablesPageState extends State<BasicTablesPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late BasicTableController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BasicTableController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<BasicTableController>(
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
                          "basic_tables".tr().capitalizeWords,
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'ui'.tr()),
                            MyBreadcrumbItem(
                                name: 'basic_table'.tr().capitalizeWords,
                                active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  MyContainer.bordered(
                    margin: MySpacing.x(flexSpacing),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: MyContainer.none(
                        borderRadiusAll: 4,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: DataTable(
                            sortAscending: true,
                            onSelectAll: (_) => {},
                            headingRowColor: WidgetStatePropertyAll(
                                contentTheme.primary.withAlpha(40)),
                            // dataRowHeight: 60,
                            dataRowMaxHeight: 60,
                            showBottomBorder: false,
                            columns: [
                              DataColumn(
                                  label: MyText.labelLarge(
                                'id'.tr(),
                                color: contentTheme.primary,
                              )),
                              DataColumn(
                                  label: MyText.labelLarge(
                                'name'.tr(),
                                color: contentTheme.primary,
                              )),
                              DataColumn(
                                  label: MyText.labelLarge(
                                'code'.tr(),
                                color: contentTheme.primary,
                              )),
                              DataColumn(
                                  label: MyText.labelLarge(
                                'price'.tr(),
                                color: contentTheme.primary,
                              )),
                              DataColumn(
                                  label: MyText.labelLarge(
                                'qty'.tr(),
                                color: contentTheme.primary,
                              )),
                              DataColumn(
                                  label: MyText.labelLarge(
                                'action'.tr(),
                                color: contentTheme.primary,
                              )),
                            ],
                            rows: controller.datas
                                .mapIndexed((index, data) => DataRow(cells: [
                                      DataCell(
                                          MyText.bodyMedium('#${data.id}')),
                                      DataCell(SizedBox(
                                        width: 300,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            MyContainer.none(
                                                borderRadiusAll: 20,
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: Image.asset(
                                                    Images.squareImages[index %
                                                        Images.squareImages
                                                            .length],
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                    width: 40)),
                                            MySpacing.width(16),
                                            MyText.labelLarge(
                                                data.name.toString()),
                                          ],
                                        ),
                                      )),
                                      DataCell(MyText.bodyMedium(
                                          '${data.code.capitalize!}')),
                                      DataCell(MyText.bodyMedium(
                                          '\$${data.amount}')),
                                      DataCell(
                                          MyText.bodyMedium('${data.qty}')),
                                      DataCell(Align(
                                        alignment: Alignment.center,
                                        child: MyContainer.bordered(
                                          onTap: () => {},
                                          padding: MySpacing.xy(6, 6),
                                          borderColor: contentTheme.primary
                                              .withAlpha(40),
                                          child: Icon(
                                            Icons.edit_outlined,
                                            size: 14,
                                            color: contentTheme.primary,
                                          ),
                                        ),
                                      )),
                                      // DataCell(MyText.bodyMedium('${DateTime.tryParse('2022-11-26T15:56:14Z')}')),
                                    ]))
                                .toList()),
                      ),
                    ),
                  )
                ],
              );
            }));
  }
}

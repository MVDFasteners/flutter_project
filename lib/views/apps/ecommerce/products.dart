import 'package:flatten/controllers/apps/ecommerce/products_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class EcommerceProductsPage extends StatefulWidget {
  const EcommerceProductsPage({super.key});

  @override
  _EcommerceProductsPageState createState() => _EcommerceProductsPageState();
}

class _EcommerceProductsPageState extends State<EcommerceProductsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late EcommerceProductsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EcommerceProductsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<EcommerceProductsController>(
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
                          "products".tr(),
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'ecommerce'.tr()),
                            MyBreadcrumbItem(
                                name: 'products'.tr(), active: true),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(flexSpacing),
                  MyCard(
                      shadow: MyShadow(
                          elevation: 0.5, position: MyShadowPosition.bottom),
                      margin: MySpacing.x(flexSpacing),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          MyButton(
                            onPressed: controller.goToCreateProduct,
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.plus,
                                  size: 20,
                                  color: contentTheme.onPrimary,
                                ),
                                MySpacing.width(8),
                                MyText.labelMedium(
                                  'create_product'.tr().capitalizeWords,
                                  color: contentTheme.onPrimary,
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(16),
                          SingleChildScrollView(
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
                                      'price'.tr(),
                                      color: contentTheme.primary,
                                    )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                      'rating'.tr(),
                                      color: contentTheme.primary,
                                    )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                      'sku'.tr(),
                                      color: contentTheme.primary,
                                    )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                      'stock'.tr(),
                                      color: contentTheme.primary,
                                    )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                      'orders'.tr(),
                                      color: contentTheme.primary,
                                    )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                      'created_at'.tr().capitalizeWords,
                                      color: contentTheme.primary,
                                    )),
                                    DataColumn(
                                        label: MyText.labelLarge(
                                      'action'.tr(),
                                      color: contentTheme.primary,
                                    )),
                                  ],
                                  rows: controller.products
                                      .mapIndexed((index, data) =>
                                          DataRow(cells: [
                                            DataCell(MyText.bodyMedium(
                                                '#${data.id}')),
                                            DataCell(SizedBox(
                                              width: 300,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  MyContainer.none(
                                                      borderRadiusAll: 20,
                                                      clipBehavior: Clip
                                                          .antiAliasWithSaveLayer,
                                                      child: Image.asset(
                                                        Images.squareImages[
                                                            index %
                                                                Images
                                                                    .squareImages
                                                                    .length],
                                                        height: 40,
                                                        width: 40,
                                                        fit: BoxFit.cover,
                                                      )),
                                                  MySpacing.width(16),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      MyText.labelLarge(
                                                          data.name.toString()),
                                                      MyText.labelSmall(
                                                        data.category
                                                            .toString(),
                                                        muted: true,
                                                        letterSpacing: 0,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )),
                                            DataCell(MyText.bodyMedium(
                                                '\$${data.price}')),
                                            DataCell(Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  LucideIcons.star,
                                                  color:
                                                      AppColors.ratingStarColor,
                                                  size: 20,
                                                ),
                                                MySpacing.width(4),
                                                MyText.bodySmall(
                                                    '${data.rating} (${data.ratingCount})')
                                              ],
                                            )),
                                            DataCell(MyText.bodyMedium(
                                                '${data.sku}')),
                                            DataCell(MyText.bodyMedium(
                                                '${data.stock}')),
                                            DataCell(MyText.bodyMedium(
                                                '${data.ordersCount}')),
                                            DataCell(Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                MyText.labelLarge(
                                                    '${Utils.getDateStringFromDateTime(data.createdAt, showMonthShort: true)}'),
                                                MySpacing.width(4),
                                                MyText.bodySmall(
                                                  '${Utils.getTimeStringFromDateTime(data.createdAt, showSecond: false)}',
                                                  muted: true,
                                                  fontWeight: 600,
                                                )
                                              ],
                                            )),
                                            DataCell(Align(
                                              alignment: Alignment.center,
                                              child: MyContainer.bordered(
                                                onTap: () => {},
                                                padding: MySpacing.xy(6, 6),
                                                borderColor: contentTheme
                                                    .primary
                                                    .withAlpha(40),
                                                child: Icon(
                                                  LucideIcons.pencil,
                                                  size: 12,
                                                  color: contentTheme.primary,
                                                ),
                                              ),
                                            )),
                                            // DataCell(MyText.bodyMedium('${DateTime.tryParse('2022-11-26T15:56:14Z')}')),
                                          ]))
                                      .toList()),
                            ),
                          ),
                        ],
                      )),
                ],
              );
            }));
  }
}

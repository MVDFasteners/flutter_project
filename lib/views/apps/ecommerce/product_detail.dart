import 'package:flatten/controllers/apps/ecommerce/product_detail_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_dotted_line.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> with SingleTickerProviderStateMixin, UIMixin {
  late ProductDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductDetailController(this));
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
                    MyText.titleMedium("Product Detail", fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "Product Detail", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    MyFlexItem(
                      sizes: "lg-4 md-12",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MyContainer(
                            borderRadiusAll: 8,
                            paddingAll: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image.asset(controller.selectedImage, fit: BoxFit.cover, height: 450),
                          ),
                          MySpacing.height(8),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 12,
                            spacing: 12,
                            children: controller.images
                                .mapIndexed(
                                  (index, image) => MyContainer.bordered(
                                    onTap: () {
                                      controller.onChangeImage(image);
                                    },
                                    height: 100,
                                    bordered: image == controller.selectedImage,
                                    border: Border.all(color: contentTheme.primary, width: 2),
                                    borderRadiusAll: 8,
                                    paddingAll: 0,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.asset(image, fit: BoxFit.fill),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-8 md-12",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium("Electricity", fontSize: 12, color: contentTheme.primary),
                          MySpacing.height(8),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: MyText("Night Lamp  (Yellow)", fontWeight: 600, fontSize: 28, maxLines: 2, overflow: TextOverflow.ellipsis),
                              ),
                              MySpacing.width(8),
                              MyButton(
                                onPressed: () {},
                                elevation: 0,
                                padding: MySpacing.xy(8, 6),
                                borderColor: contentTheme.primary,
                                backgroundColor: contentTheme.primary.withValues(alpha: 0.12),
                                splashColor: contentTheme.primary.withValues(alpha: 0.2),
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: MyText.bodySmall('Add To Wishlist', color: contentTheme.primary),
                              ),
                            ],
                          ),
                          MySpacing.height(8),
                          Row(
                            children: [
                              Icon(LucideIcons.star, size: 16, color: AppColors.star),
                              Icon(LucideIcons.star, size: 16, color: AppColors.star),
                              Icon(LucideIcons.star, size: 16, color: AppColors.star),
                              Icon(LucideIcons.star, size: 16, color: AppColors.star),
                              Icon(LucideIcons.star, size: 16, color: contentTheme.onBackground.withAlpha(64)),
                              MySpacing.width(8),
                              MyText("(485 Customer Reviews)", color: contentTheme.title),
                            ],
                          ),
                          MySpacing.height(24),
                          MyFlex(
                            wrapCrossAlignment: WrapCrossAlignment.start,
                            runSpacing: 20,
                            contentPadding: false,
                            children: [
                              MyFlexItem(sizes: "xl-3 md-6 sm-12", child: buildProductDetail("Price:", "\$69.99", LucideIcons.dollar_sign)),
                              MyFlexItem(sizes: "xl-3 md-6 sm-12", child: buildProductDetail("Delivery Charge:", "\$9.99", LucideIcons.bike)),
                              MyFlexItem(sizes: "xl-3 md-6 sm-12", child: buildProductDetail("Available Stock:", "1,230", LucideIcons.layers)),
                              MyFlexItem(sizes: "xl-3 md-6 sm-12", child: buildProductDetail("Warranty:", "2 Year", LucideIcons.history)),
                            ],
                          ),
                          MySpacing.height(20),
                          Row(
                            children: [
                              MyText.titleSmall("Quantity", fontWeight: 600),
                              MySpacing.width(16),
                              PopupMenuButton(
                                onSelected: controller.onSelectedQty,
                                itemBuilder: (BuildContext context) {
                                  return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((behavior) {
                                    return PopupMenuItem(
                                      value: behavior,
                                      height: 32,
                                      child: MyText.bodySmall(behavior.toString(), color: theme.colorScheme.onSurface, fontWeight: 600),
                                    );
                                  }).toList();
                                },
                                color: theme.cardTheme.color,
                                child: MyContainer.bordered(
                                  padding: MySpacing.xy(12, 8),
                                  child: Row(
                                    children: <Widget>[
                                      MyText.labelMedium(controller.selectedQuntity.toString(), color: theme.colorScheme.onSurface),
                                      Container(
                                        margin: EdgeInsets.only(left: 4),
                                        child: Icon(LucideIcons.chevron_down, size: 22, color: theme.colorScheme.onSurface),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              MySpacing.width(24),
                              MyText.titleSmall("Sizes", fontWeight: 600),
                              MySpacing.width(16),
                              PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return ["Small", "Medium", "Large", "XL"].map((behavior) {
                                    return PopupMenuItem(
                                      value: behavior,
                                      height: 32,
                                      child: MyText.bodySmall(behavior.toString(), color: theme.colorScheme.onSurface, fontWeight: 600),
                                    );
                                  }).toList();
                                },
                                onSelected: controller.onSelectedSize,
                                color: theme.cardTheme.color,
                                child: MyContainer.bordered(
                                  padding: MySpacing.xy(12, 8),
                                  child: Row(
                                    children: <Widget>[
                                      MyText.labelMedium(controller.selectSize.toString(), color: theme.colorScheme.onSurface),
                                      Container(
                                        margin: EdgeInsets.only(left: 4),
                                        child: Icon(LucideIcons.chevron_down, size: 22, color: theme.colorScheme.onSurface),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          MySpacing.height(24),
                          Row(
                            children: [
                              MyButton.outlined(
                                onPressed: () {},
                                elevation: 0,
                                padding: MySpacing.xy(20, 16),
                                borderColor: contentTheme.primary,
                                splashColor: contentTheme.primary.withValues(alpha: 0.1),
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: MyText.bodySmall('ADD TO CART', color: contentTheme.primary),
                              ),
                              MySpacing.width(16),
                              MyButton(
                                onPressed: () {},
                                elevation: 0,
                                padding: MySpacing.xy(20, 16),
                                backgroundColor: contentTheme.primary,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: MyText.bodySmall('BUY NOW', color: contentTheme.onPrimary),
                              ),
                            ],
                          ),
                          MySpacing.height(24),
                          MyText.titleSmall("Description :", fontWeight: 600),
                          MySpacing.height(8),
                          MyText.bodySmall(controller.dummyTexts[0], maxLines: 2, overflow: TextOverflow.ellipsis, muted: true),
                          MySpacing.height(24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.titleSmall("Features :", fontWeight: 600),
                                    MySpacing.height(8),
                                    buildFeature("HDR Lights"),
                                    MySpacing.height(4),
                                    buildFeature("Remote controlled"),
                                    MySpacing.height(4),
                                    buildFeature("5+ Colors available"),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleSmall("Services :", fontWeight: 600),
                                  MySpacing.height(8),
                                  MyText.titleMedium("14 Days Replacement", fontSize: 13),
                                  MySpacing.height(4),
                                  MyText.titleMedium("2 Year warranty", fontSize: 13),
                                ],
                              ),
                            ],
                          ),
                          MySpacing.height(24),
                          MyText.titleSmall("Product Description :", fontWeight: 600),
                          MySpacing.height(8),
                          MyContainer.bordered(
                            padding: MySpacing.x(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TabBar(
                                  controller: controller.defaultTabController,
                                  isScrollable: true,
                                  tabs: [
                                    Tab(
                                      icon: MyText.bodyMedium(
                                        "Specification",
                                        fontWeight: controller.defaultIndex == 0 ? 600 : 500,
                                        color: controller.defaultIndex == 0 ? contentTheme.primary : null,
                                      ),
                                    ),
                                    Tab(
                                      icon: MyText.bodyMedium(
                                        "Details",
                                        fontWeight: controller.defaultIndex == 1 ? 600 : 500,
                                        color: controller.defaultIndex == 1 ? contentTheme.primary : null,
                                      ),
                                    ),
                                  ],
                                  // controller: _tabController,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                ),
                                MySpacing.height(8),
                                SizedBox(
                                  height: 260,
                                  child: TabBarView(
                                    controller: controller.defaultTabController,
                                    children: [
                                      DataTable(
                                        sortAscending: true,
                                        onSelectAll: (value) {},
                                        headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                                        // dataRowHeight: 50,
                                        dataRowMaxHeight: 50,
                                        columns: [
                                          DataColumn(label: MyText.labelLarge("Attributes", fontWeight: 600, color: contentTheme.primary)),
                                          DataColumn(label: MyText.labelLarge("Details", color: contentTheme.primary)),
                                        ],
                                        rows: [
                                          buildDataRows("Category", "Electric"),
                                          buildDataRows("Brand", "High Energy"),
                                          buildDataRows("Light Color", "Yellow"),
                                          buildDataRows("Weight", "1.5 KG"),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          MyText.titleSmall("Night Lamp (Yellow)", fontWeight: 600, fontSize: 18),
                                          MySpacing.height(12),
                                          MyText.bodySmall(controller.dummyTexts[1]),
                                          MySpacing.height(8),
                                          buildFeature("HDR Lights"),
                                          MySpacing.height(4),
                                          buildFeature("Remote controlled"),
                                          MySpacing.height(4),
                                          buildFeature("5+ Colors available"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  MyDottedLine buildProductDetail(String name, String value, IconData icon) {
    return MyDottedLine(
      strokeWidth: 0.2,
      corner: MyDottedLineCorner(leftBottomCorner: 2, leftTopCorner: 2, rightBottomCorner: 2, rightTopCorner: 2),
      child: Padding(
        padding: MySpacing.xy(16, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: contentTheme.success),
            MySpacing.width(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [MyText.bodyMedium(name, fontWeight: 600), MyText.bodySmall(value)],
            ),
          ],
        ),
      ),
    );
  }

  Row buildFeature(String feature) {
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(color: contentTheme.title, shape: BoxShape.circle),
        ),
        MySpacing.width(12),
        Expanded(child: MyText.titleSmall(feature, fontSize: 13, maxLines: 2, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  DataRow buildDataRows(String attributes, String details) {
    return DataRow(
      cells: [
        DataCell(MyText.bodySmall(attributes, fontWeight: 600)),
        DataCell(SizedBox(width: 500, child: MyText.bodySmall(details))),
      ],
    );
  }
}

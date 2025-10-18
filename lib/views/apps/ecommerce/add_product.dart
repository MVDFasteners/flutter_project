import 'package:flatten/controllers/apps/ecommerce/edit_products_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late AddProductsController controller;

  String? categories;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AddProductsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "add_product".tr().capitalizeWords,
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'ecommerce'.tr()),
                        MyBreadcrumbItem(
                          name: 'add_product'.tr().capitalizeWords,
                          active: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      sizes: "lg-8 md-12",
                      child: MyCard(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shadow: MyShadow(
                            elevation: 0.5, position: MyShadowPosition.bottom),
                        paddingAll: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              // width: double.infinity,
                              color: colorScheme.primary.withValues(alpha: 0.08),
                              padding: MySpacing.xy(16, 12),
                              child: Row(
                                children: [
                                  Icon(
                                    LucideIcons.server,
                                    color: contentTheme.primary,
                                    size: 16,
                                  ),
                                  MySpacing.width(12),
                                  MyText.titleMedium(
                                    "general".tr(),
                                    fontWeight: 600,
                                    color: colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: MySpacing.xy(flexSpacing, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium(
                                    "product_name".tr().capitalizeWords,
                                  ),
                                  MySpacing.height(8),
                                  TextFormField(
                                    validator: controller.basicValidator
                                        .getValidation('product_name'),
                                    controller: controller.basicValidator
                                        .getController('product_name'),
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "eg: Tomatoes",
                                      hintStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                  ),
                                  MySpacing.height(25),
                                  MyText.labelMedium(
                                    "shop_name".tr().capitalizeWords,
                                  ),
                                  MySpacing.height(8),
                                  TextFormField(
                                    validator: controller.basicValidator
                                        .getValidation('shop_name'),
                                    controller: controller.basicValidator
                                        .getController('shop_name'),
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      hintText: "eg: Fruits",
                                      hintStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                  ),
                                  MySpacing.height(25),
                                  MyText.labelMedium(
                                    "description".tr(),
                                  ),
                                  MySpacing.height(8),
                                  TextFormField(
                                    validator: controller.basicValidator
                                        .getValidation('description'),
                                    controller: controller.basicValidator
                                        .getController('description'),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      hintText:
                                          "It's contains blah blah things",
                                      hintStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: focusedInputBorder,
                                      contentPadding: MySpacing.all(16),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                    ),
                                  ),
                                  MySpacing.height(25),
                                  MyFlex(contentPadding: false, children: [
                                    MyFlexItem(
                                        sizes: 'lg-6 md-12',
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.labelMedium(
                                              "category".tr(),
                                            ),
                                            MySpacing.height(8),
                                            DropdownButtonFormField<Category>(
                                              dropdownColor:
                                                  colorScheme.surface,
                                              menuMaxHeight: 200,
                                              isDense: true,

                                              // itemHeight: 40,
                                              items: Category.values
                                                  .map(
                                                    (category) =>
                                                        DropdownMenuItem<
                                                            Category>(
                                                      value: category,
                                                      child: MyText.labelMedium(
                                                        category
                                                            .name.capitalize!,
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              icon: Icon(
                                                LucideIcons.chevron_down,
                                                size: 20,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: "Select category",
                                                hintStyle:
                                                    MyTextStyle.bodySmall(
                                                        xMuted: true),
                                                border: outlineInputBorder,
                                                enabledBorder:
                                                    outlineInputBorder,
                                                focusedBorder:
                                                    focusedInputBorder,
                                                contentPadding:
                                                    MySpacing.all(14),
                                                isCollapsed: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                              ),
                                              onChanged: controller
                                                  .basicValidator
                                                  .onChanged<Object?>(
                                                'category',
                                              ),
                                            )
                                          ],
                                        )),
                                    MyFlexItem(
                                        sizes: 'lg-6 md-12',
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.labelMedium(
                                              "price".tr(),
                                            ),
                                            MySpacing.height(8),
                                            TextFormField(
                                              validator: controller
                                                  .basicValidator
                                                  .getValidation('price'),
                                              controller: controller
                                                  .basicValidator
                                                  .getController('price'),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              decoration: InputDecoration(
                                                hintText: "19.99",
                                                hintStyle:
                                                    MyTextStyle.bodySmall(
                                                        xMuted: true),
                                                border: outlineInputBorder,
                                                enabledBorder:
                                                    outlineInputBorder,
                                                focusedBorder:
                                                    focusedInputBorder,
                                                prefixIcon: MyContainer.none(
                                                    margin: MySpacing.right(12),
                                                    alignment: Alignment.center,
                                                    color: contentTheme.primary
                                                        .withAlpha(40),
                                                    child: MyText.labelLarge(
                                                      "\$",
                                                      color:
                                                          contentTheme.primary,
                                                    )),
                                                prefixIconConstraints:
                                                    BoxConstraints(
                                                        maxHeight: 42,
                                                        minWidth: 50,
                                                        maxWidth: 50),
                                                contentPadding:
                                                    MySpacing.all(16),
                                                isCollapsed: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ]),
                                  MySpacing.height(25),
                                  MyText.labelMedium(
                                    "status".tr(),
                                  ),
                                  MySpacing.height(4),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                            spacing: 16,
                                            children: Status.values
                                                .map(
                                                  (gender) => InkWell(
                                                    onTap: () => controller
                                                        .onChangeGender(gender),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Radio<Status>(
                                                          value: gender,
                                                          activeColor: theme
                                                              .colorScheme
                                                              .primary,
                                                          groupValue: controller
                                                              .selectedGender,
                                                          onChanged: controller
                                                              .onChangeGender,
                                                          visualDensity:
                                                              getCompactDensity,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                        ),
                                                        MySpacing.width(8),
                                                        MyText.labelMedium(
                                                          gender
                                                              .name.capitalize!,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                .toList()),
                                      )
                                    ],
                                  ),
                                  MySpacing.height(25),
                                  MyText.labelMedium(
                                    "tags".tr(),
                                  ),
                                  MySpacing.height(8),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: TextFormField(
                                      maxLines: 3,
                                      validator: controller.basicValidator
                                          .getValidation('tags'),
                                      controller: controller.basicValidator
                                          .getController('tags'),
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        hintText:
                                            "fruits, vegetables, grocery, healthy, etc",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                      ),
                                    ),
                                  ),
                                  MySpacing.height(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton.text(
                                        onPressed: () {},
                                        padding: MySpacing.xy(20, 16),
                                        splashColor: contentTheme.secondary
                                            .withValues(alpha: 0.1),
                                        child: MyText.bodySmall(
                                          'cancel'.tr(),
                                        ),
                                      ),
                                      MySpacing.width(12),
                                      MyButton(
                                        onPressed: () {},
                                        elevation: 0,
                                        padding: MySpacing.xy(20, 16),
                                        backgroundColor: contentTheme.primary,
                                        borderRadiusAll:
                                            AppStyle.buttonRadius.medium,
                                        child: MyText.bodySmall(
                                          'save'.tr(),
                                          color: contentTheme.onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
}

import 'package:flatten/controllers/ui/cards_controller.dart';
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
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({super.key});

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late CardsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CardsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<CardsController>(
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
                      "cards".tr(),
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'ui'.tr().toUpperCase()),
                        MyBreadcrumbItem(name: 'cards'.tr(), active: true),
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
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard(
                        padding: MySpacing.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              Images.squareImages[0],
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    'card_title'.tr().capitalizeWords,
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(8),
                                  MyText.bodySmall(
                                    controller.dummyTexts[0],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  MySpacing.height(20),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.small,
                                      child: MyText.bodySmall(
                                        'click_me'.tr().capitalizeWords,
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard(
                        padding: MySpacing.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              Images.landscapeImages[2],
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    'text_actions'.tr().capitalizeWords,
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(8),
                                  MyText.bodySmall(
                                    controller.dummyTexts[1],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  MySpacing.height(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton.text(
                                        onPressed: () {},
                                        splashColor: Colors.transparent,
                                        padding: MySpacing.y(16),
                                        child: MyText.bodySmall(
                                          'ok'.tr(),
                                          color: contentTheme.primary,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      // MySpacing.width(0),
                                      MyButton.text(
                                        onPressed: () {},
                                        splashColor: Colors.transparent,
                                        padding: MySpacing.y(16),
                                        child: MyText.bodySmall(
                                          'cancel'.tr(),
                                          color: contentTheme.danger,
                                          fontWeight: 600,
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
                    MyFlexItem(
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard(
                        padding: MySpacing.zero,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.asset(
                              Images.landscapeImages[1],
                              height: 318,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.bodySmall(
                                    controller.dummyTexts[2],
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard(
                        padding: MySpacing.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    'card_title'.tr().capitalizeWords,
                                    fontWeight: 600,
                                  ),
                                  MySpacing.height(4),
                                  MyText.bodySmall(
                                    'subtitle_is_more_useful'.tr(),
                                    muted: true,
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              Images.squareImages[8],
                              height: 202,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.bodySmall(
                                    controller.dummyTexts[3],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  MySpacing.height(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton.text(
                                        onPressed: () {},
                                        splashColor: Colors.transparent,
                                        padding: MySpacing.y(16),
                                        child: MyText.bodySmall(
                                          'oK'.tr(),
                                          color: contentTheme.primary,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      // MySpacing.width(0),
                                      MyButton.text(
                                        onPressed: () {},
                                        splashColor: Colors.transparent,
                                        padding: MySpacing.y(16),
                                        child: MyText.bodySmall(
                                          'cancel'.tr(),
                                          color: contentTheme.danger,
                                          fontWeight: 600,
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
                    MyFlexItem(
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard(
                        padding: MySpacing.zero,
                        shadow: MyShadow.none(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    'no_shadow'.tr().capitalizeWords,
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              Images.squareImages[3],
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: MyText.bodySmall(
                                controller.dummyTexts[4],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard.bordered(
                        padding: MySpacing.zero,
                        shadow: MyShadow.none(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    'bordered'.tr(),
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              Images.squareImages[8],
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: MyText.bodySmall(
                                controller.dummyTexts[5],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard(
                        padding: MySpacing.zero,
                        shadow: MyShadow(elevation: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    '${'shadow'.tr()}: 1',
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              Images.squareImages[9],
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: MyText.bodySmall(
                                controller.dummyTexts[6],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "xl-3 md-6 sm-12",
                      child: MyCard(
                        padding: MySpacing.zero,
                        shadow: MyShadow(elevation: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: MySpacing.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    'very_high'.tr().capitalizeWords,
                                    fontWeight: 600,
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              Images.squareImages[12],
                              height: 220,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: MySpacing.all(16),
                              child: MyText.bodySmall(
                                controller.dummyTexts[7],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing * 2),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  children: [
                    MyFlexItem(
                      sizes: "xl-6 sm-12",
                      child: MyContainer.bordered(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        paddingAll: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              color: colorScheme.primary.withValues(
                                alpha: 0.08,
                              ),
                              padding: MySpacing.xy(flexSpacing, 12),
                              child: MyText.titleMedium(
                                "card_customizer".tr().capitalizeWords,
                                fontWeight: 600,
                                color: colorScheme.primary,
                              ),
                            ),
                            Padding(
                              padding: MySpacing.xy(flexSpacing, 16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 140,
                                        child: MyText.bodyMedium(
                                          "shadow_position"
                                              .tr()
                                              .capitalizeWords,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      MySpacing.width(16),
                                      PopupMenuButton(
                                        key: controller.shadowPositionKey,
                                        onSelected: controller.onChangePosition,
                                        itemBuilder: (BuildContext context) {
                                          return MyShadowPosition.values.map((
                                            position,
                                          ) {
                                            return PopupMenuItem(
                                              value: position,
                                              height: 32,
                                              child: MyText.bodySmall(
                                                position.humanReadable,
                                                color:
                                                    theme.colorScheme.onSurface,
                                                fontWeight: 600,
                                              ),
                                            );
                                          }).toList();
                                        },
                                        color: theme.cardTheme.color,
                                        child: MyContainer.bordered(
                                          padding: MySpacing.xy(12, 8),
                                          child: Row(
                                            children: <Widget>[
                                              MyText.labelMedium(
                                                controller
                                                    .shadowPosition
                                                    .humanReadable,
                                                color:
                                                    theme.colorScheme.onSurface,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                  left: 4,
                                                ),
                                                child: Icon(
                                                  LucideIcons.chevron_down,
                                                  size: 22,
                                                  color: theme
                                                      .colorScheme
                                                      .onSurface,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(8),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: MyText.bodyMedium(
                                          "shadow_size".tr().capitalizeWords,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      MySpacing.width(16),
                                      Slider(
                                        value: controller.shadowElevation,
                                        min: 0,
                                        max: 40,
                                        divisions: 40,
                                        label: controller.shadowElevation
                                            .floor()
                                            .toString(),
                                        onChanged: controller.onChangeElevation,
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: MyText.bodyMedium(
                                          "shadow_color".tr().capitalizeWords,
                                          fontWeight: 600,
                                        ),
                                      ),
                                      MySpacing.width(16),
                                      BlockPicker(
                                        pickerColor: controller.shadowColor,
                                        onColorChanged:
                                            controller.onChangeColor,
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
                    MyFlexItem(
                      sizes: "xl-4 md-6 sm-12",
                      child: Padding(
                        padding: MySpacing.x(40),
                        child: MyCard(
                          padding: MySpacing.zero,
                          shadow: MyShadow(
                            elevation: controller.shadowElevation,
                            position: controller.shadowPosition,
                            color: controller.shadowColor.withAlpha(100),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: MySpacing.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText.titleMedium(
                                      'result'.tr(),
                                      fontWeight: 600,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                Images.squareImages[12],
                                height: 220,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: MySpacing.all(16),
                                child: MyText.bodySmall(
                                  controller.dummyTexts[7],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing * 2),
            ],
          );
        },
      ),
    );
  }
}

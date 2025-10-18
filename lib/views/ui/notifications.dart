import 'package:flatten/controllers/ui/notifications_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/admin_theme.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late NotificationsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NotificationsController(this));
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        child: GetBuilder<NotificationsController>(
            init: controller,
            builder: (controller) {
              return Column(
                children: [
                  Padding(
                    padding: MySpacing.x(flexSpacing),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium(
                          "notifications".tr(),
                          fontSize: 18,
                          fontWeight: 600,
                        ),
                        MyBreadcrumb(
                          children: [
                            MyBreadcrumbItem(name: 'ui'.tr().toUpperCase()),
                            MyBreadcrumbItem(
                                name: 'notifications'.tr(), active: true),
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
                            child: MyContainer.bordered(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              paddingAll: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    color:
                                        colorScheme.primary.withValues(alpha: 0.08),
                                    padding: MySpacing.xy(flexSpacing, 12),
                                    child: MyText.titleMedium(
                                      "${controller.showBanner ? "${"banner".tr()}" : "${"toast".tr()}"} Customizer",
                                      fontWeight: 600,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                  Padding(
                                      padding: MySpacing.xy(flexSpacing, 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelLarge(
                                            "type".tr(),
                                          ),
                                          MySpacing.height(8),
                                          Wrap(
                                            spacing: 16,
                                            runSpacing: 4,
                                            children: [
                                              InkWell(
                                                onTap: () => controller
                                                    .setBannerType(false),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Radio<bool>(
                                                      value: false,
                                                      activeColor:
                                                          contentTheme.primary,
                                                      groupValue:
                                                          controller.showBanner,
                                                      onChanged: (_) =>
                                                          controller
                                                              .setBannerType(
                                                                  false),
                                                      visualDensity:
                                                          getCompactDensity,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                    ),
                                                    MySpacing.width(8),
                                                    MyText.labelMedium(
                                                        "toast".tr())
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => controller
                                                    .setBannerType(true),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Radio<bool>(
                                                      value: true,
                                                      activeColor:
                                                          contentTheme.primary,
                                                      groupValue:
                                                          controller.showBanner,
                                                      onChanged: (_) =>
                                                          controller
                                                              .setBannerType(
                                                                  true),
                                                      visualDensity:
                                                          getCompactDensity,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                    ),
                                                    MySpacing.width(8),
                                                    MyText.labelMedium(
                                                        "banner".tr())
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          MySpacing.height(20),
                                          MyText.labelLarge(
                                            "title_text".tr().capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          TextFormField(
                                            controller:
                                                controller.toastTitleController,
                                            decoration: InputDecoration(
                                                labelText: "toast_text"
                                                    .tr()
                                                    .capitalizeWords,

                                                // border: outlineInputBorder,
                                                // enabledBorder: outlineInputBorder,

                                                contentPadding:
                                                    MySpacing.all(16),
                                                isCollapsed: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior
                                                        .never),
                                          ),
                                          MySpacing.height(20),
                                          MyText.labelLarge(
                                            "color_variant"
                                                .tr()
                                                .capitalizeWords,
                                          ),
                                          MySpacing.height(8),
                                          Wrap(
                                              spacing: 16,
                                              runSpacing: 4,
                                              children: ContentThemeColor.values
                                                  .map(
                                                    (color) => InkWell(
                                                      onTap: () => controller
                                                          .onChangeColor(color),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Radio<
                                                              ContentThemeColor>(
                                                            value: color,
                                                            activeColor:
                                                                controller
                                                                    .selectedColor
                                                                    .color,
                                                            groupValue: controller
                                                                .selectedColor,
                                                            onChanged: controller
                                                                .onChangeColor,
                                                            visualDensity:
                                                                getCompactDensity,
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .shrinkWrap,
                                                          ),
                                                          MySpacing.width(8),
                                                          MyText.labelMedium(
                                                              color.name
                                                                  .capitalize!)
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                  .toList()),
                                          MySpacing.height(20),
                                          if (!controller.showBanner) ...[
                                            MyText.labelLarge(
                                              "floating_type"
                                                  .tr()
                                                  .capitalizeWords,
                                            ),
                                            MySpacing.height(8),
                                            Wrap(
                                                spacing: 16,
                                                children: SnackBarBehavior
                                                    .values
                                                    .map(
                                                      (behavior) => InkWell(
                                                        onTap: () => controller
                                                            .onChangeBehavior(
                                                                behavior),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Radio<
                                                                SnackBarBehavior>(
                                                              value: behavior,
                                                              activeColor: theme
                                                                  .colorScheme
                                                                  .primary,
                                                              groupValue: controller
                                                                  .selectedBehavior,
                                                              onChanged: controller
                                                                  .onChangeBehavior,
                                                              visualDensity:
                                                                  getCompactDensity,
                                                              materialTapTargetSize:
                                                                  MaterialTapTargetSize
                                                                      .shrinkWrap,
                                                            ),
                                                            MySpacing.width(8),
                                                            MyText.labelMedium(
                                                                behavior.name
                                                                    .capitalize!)
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList()),
                                            MySpacing.height(20),
                                          ],
                                          MyText.labelLarge(
                                            "actions".tr(),
                                          ),
                                          MySpacing.height(8),
                                          CheckboxListTile(
                                              value: controller.showCloseIcon,
                                              onChanged: controller
                                                  .onChangeShowCloseIcon,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              visualDensity: getCompactDensity,
                                              contentPadding: MySpacing.zero,
                                              dense: true,
                                              title: MyText.bodyMedium(
                                                  "show_close_icon"
                                                      .tr()
                                                      .capitalizeWords)),
                                          if (!controller.showBanner)
                                            CheckboxListTile(
                                                value: controller.showOkAction,
                                                onChanged: controller
                                                    .onChangeShowOkAction,
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                visualDensity:
                                                    getCompactDensity,
                                                contentPadding: MySpacing.zero,
                                                dense: true,
                                                title: MyText.bodyMedium(
                                                    "show_ok_action"
                                                        .tr()
                                                        .capitalizeWords)),
                                          if (controller.showBanner)
                                            CheckboxListTile(
                                                value:
                                                    controller.showLeadingIcon,
                                                onChanged: controller
                                                    .onChangeShowLeadingIcon,
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                visualDensity:
                                                    getCompactDensity,
                                                contentPadding: MySpacing.zero,
                                                dense: true,
                                                title: MyText.bodyMedium(
                                                    "show_leading_icon"
                                                        .tr()
                                                        .capitalizeWords)),
                                          MySpacing.height(20),
                                          MyText.labelLarge(
                                            "timeout".tr(),
                                          ),
                                          MySpacing.height(8),
                                          SwitchListTile(
                                              value: controller.sticky,
                                              onChanged:
                                                  controller.onChangeSticky,
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              visualDensity: getCompactDensity,
                                              contentPadding: MySpacing.zero,
                                              dense: true,
                                              title: MyText.bodyMedium(
                                                  "${"infinite".tr()} (∞)")),
                                          MySpacing.height(20),
                                          Center(
                                            child: MyButton(
                                              onPressed: controller.show,
                                              elevation: 0,
                                              padding: MySpacing.xy(20, 16),
                                              backgroundColor:
                                                  contentTheme.primary,
                                              borderRadiusAll:
                                                  AppStyle.buttonRadius.medium,
                                              child: MyText.bodySmall(
                                                'show'.tr(),
                                                color: contentTheme.onPrimary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }
}

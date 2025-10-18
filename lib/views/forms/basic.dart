import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/forms/basic_controller.dart';
import 'package:flatten/helpers/extensions/date_time_extension.dart';
import 'package:flatten/helpers/extensions/string.dart';
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
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class BasicFormsPage extends StatefulWidget {
  const BasicFormsPage({super.key});

  @override
  _BasicFormsPageState createState() => _BasicFormsPageState();
}

class _BasicFormsPageState extends State<BasicFormsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late BasicFormsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(BasicFormsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<BasicFormsController>(
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
                        "basic_forms".tr().capitalizeWords,
                        fontSize: 18,
                        fontWeight: 600,
                      ),
                      MyBreadcrumb(
                        children: [
                          MyBreadcrumbItem(name: 'forms'.tr()),
                          MyBreadcrumbItem(name: 'Basic'.tr(), active: true),
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
                          sizes: "lg-6 md-12",
                          child: MyContainer.bordered(
                            paddingAll: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  color: colorScheme.primary.withValues(alpha: 0.08),
                                  padding: MySpacing.xy(flexSpacing, 12),
                                  child: Row(
                                    children: [
                                      Icon(
                                        LucideIcons.toggle_right,
                                        color: colorScheme.primary,
                                        size: 16,
                                      ),
                                      MySpacing.width(12),
                                      MyText.titleMedium(
                                        "basic_input".tr().capitalizeWords,
                                        fontWeight: 600,
                                        color: colorScheme.primary,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: MySpacing.all(flexSpacing),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText.labelMedium(
                                                  "first_name"
                                                      .tr()
                                                      .capitalizeWords,
                                                ),
                                                MySpacing.height(8),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      hintText: "First Name",
                                                      hintStyle:
                                                          MyTextStyle.bodySmall(
                                                              xMuted: true),
                                                      border:
                                                          outlineInputBorder,
                                                      enabledBorder:
                                                          outlineInputBorder,
                                                      focusedBorder:
                                                          focusedInputBorder,
                                                      contentPadding:
                                                          MySpacing.all(16),
                                                      isCollapsed: true,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never),
                                                ),
                                              ],
                                            ),
                                          ),
                                          MySpacing.width(16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                MyText.labelMedium(
                                                  "last_name"
                                                      .tr()
                                                      .capitalizeWords,
                                                ),
                                                MySpacing.height(8),
                                                TextFormField(
                                                  decoration: InputDecoration(
                                                      hintText: "Last Name",
                                                      hintStyle:
                                                          MyTextStyle.bodySmall(
                                                              xMuted: true),
                                                      border:
                                                          outlineInputBorder,
                                                      enabledBorder:
                                                          outlineInputBorder,
                                                      focusedBorder:
                                                          focusedInputBorder,
                                                      contentPadding:
                                                          MySpacing.all(16),
                                                      isCollapsed: true,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .never),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      MySpacing.height(20),
                                      MyText.labelMedium(
                                        "email_address".tr().capitalizeWords,
                                      ),
                                      MySpacing.height(8),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "demo@getappui.com",
                                            hintStyle: MyTextStyle.bodySmall(
                                                xMuted: true),
                                            border: outlineInputBorder,
                                            enabledBorder: outlineInputBorder,
                                            focusedBorder: focusedInputBorder,
                                            prefixIcon: Icon(
                                              LucideIcons.mail,
                                              size: 20,
                                            ),
                                            contentPadding: MySpacing.all(16),
                                            isCollapsed: true,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never),
                                      ),
                                      MySpacing.height(16),
                                      MyText.labelMedium(
                                        "password".tr(),
                                      ),
                                      MySpacing.height(8),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        obscureText: !controller.showPassword,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle: MyTextStyle.bodySmall(
                                                xMuted: true),
                                            border: outlineInputBorder,
                                            enabledBorder: outlineInputBorder,
                                            focusedBorder: focusedInputBorder,
                                            prefixIcon: Icon(
                                              LucideIcons.lock,
                                              size: 20,
                                            ),
                                            suffixIcon: InkWell(
                                              onTap: controller
                                                  .onChangeShowPassword,
                                              child: Icon(
                                                controller.showPassword
                                                    ? LucideIcons.eye
                                                    : LucideIcons.eye_off,
                                                size: 20,
                                              ),
                                            ),
                                            contentPadding: MySpacing.all(16),
                                            isCollapsed: true,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never),
                                      ),
                                      MySpacing.height(20),
                                      Row(
                                        children: [
                                          MyText.labelLarge("gender".tr()),
                                          MySpacing.width(16),
                                          Expanded(
                                            child: Wrap(
                                                spacing: 16,
                                                children: Gender.values
                                                    .map(
                                                      (gender) => InkWell(
                                                        onTap: () => controller
                                                            .onChangeGender(
                                                                gender),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Radio<Gender>(
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
                                                                gender.name
                                                                    .capitalize!)
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList()),
                                          )
                                        ],
                                      ),
                                      MySpacing.height(20),
                                      MyText.labelLarge("other_settings:"
                                          .tr()
                                          .capitalizeWords),
                                      MySpacing.height(4),
                                      SwitchListTile(
                                          value: controller.publicStatus,
                                          onChanged:
                                              controller.changeAccountStatus,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          visualDensity: getCompactDensity,
                                          contentPadding: MySpacing.zero,
                                          title: MyText.bodyMedium(
                                              "set_profile_to_private".tr())),
                                      SwitchListTile(
                                          value: controller.newsletter,
                                          onChanged:
                                              controller.changeNewsletterStatus,
                                          visualDensity: getCompactDensity,
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          contentPadding: MySpacing.zero,
                                          title: MyText.bodyMedium(
                                              "opt-in_daily_newsletter_at_the_email"
                                                  .tr())),
                                      MySpacing.height(16),
                                      InkWell(
                                        onTap: () =>
                                            controller.onChangedChecked(
                                                !controller.checked),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              onChanged:
                                                  controller.onChangedChecked,
                                              value: controller.checked,
                                              activeColor:
                                                  theme.colorScheme.primary,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity: getCompactDensity,
                                            ),
                                            MySpacing.width(16),
                                            RichText(
                                              text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "i_agree_with".tr(),
                                                    ),
                                                    TextSpan(text: " "),
                                                    TextSpan(
                                                        text:
                                                            "terms_&_conditions"
                                                                .tr(),
                                                        style: MyTextStyle
                                                            .bodyMedium(
                                                                color:
                                                                    contentTheme
                                                                        .success,
                                                                fontWeight:
                                                                    600)),
                                                  ],
                                                  style: MyTextStyle.bodyMedium(
                                                      fontWeight: 600)),
                                            )
                                          ],
                                        ),
                                      ),
                                      MySpacing.height(8),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: MyButton(
                                          onPressed: () {},
                                          elevation: 0,
                                          padding: MySpacing.xy(20, 16),
                                          backgroundColor: contentTheme.primary,
                                          borderRadiusAll:
                                              AppStyle.buttonRadius.medium,
                                          child: MyText.bodySmall(
                                            'submit'.tr(),
                                            color: contentTheme.onPrimary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                      MyFlexItem(
                          sizes: "lg-6 md-12",
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyContainer.bordered(
                                paddingAll: 0,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      color:
                                          colorScheme.primary.withValues(alpha: 0.08),
                                      padding: MySpacing.xy(flexSpacing, 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LucideIcons.layers,
                                            color: colorScheme.primary,
                                            size: 16,
                                          ),
                                          MySpacing.width(12),
                                          MyText.titleMedium(
                                            "more_inputs".tr().capitalizeWords,
                                            fontWeight: 600,
                                            color: colorScheme.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: MySpacing.all(flexSpacing),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyText.labelLarge("date_time_pickers"
                                              .tr()
                                              .capitalizeWords),
                                          MySpacing.height(12),
                                          Wrap(
                                            spacing: 16,
                                            runSpacing: 16,
                                            children: [
                                              MyButton.outlined(
                                                onPressed: () {
                                                  controller.pickDate();
                                                },
                                                borderColor:
                                                    colorScheme.primary,
                                                padding: MySpacing.xy(16, 16),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      LucideIcons.calendar,
                                                      color:
                                                          colorScheme.primary,
                                                      size: 16,
                                                    ),
                                                    MySpacing.width(10),
                                                    MyText.labelMedium(
                                                        controller.selectedDate !=
                                                                null
                                                            ? dateFormatter
                                                                .format(controller
                                                                    .selectedDate!)
                                                            : "select_date"
                                                                .tr()
                                                                .capitalizeWords,
                                                        fontWeight: 600,
                                                        color: colorScheme
                                                            .primary),
                                                  ],
                                                ),
                                              ),
                                              MyButton.outlined(
                                                onPressed: () {
                                                  controller.pickTime();
                                                },
                                                borderColor:
                                                    colorScheme.primary,
                                                padding: MySpacing.xy(16, 16),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      LucideIcons.clock_3,
                                                      color:
                                                          colorScheme.primary,
                                                      size: 16,
                                                    ),
                                                    MySpacing.width(10),
                                                    MyText.labelMedium(
                                                        controller.selectedTime !=
                                                                null
                                                            ? timeFormatter
                                                                .format(DateTime
                                                                        .now()
                                                                    .applied(
                                                                        controller
                                                                            .selectedTime!))
                                                            : "select_time"
                                                                .tr()
                                                                .capitalizeWords,
                                                        fontWeight: 600,
                                                        color: colorScheme
                                                            .primary),
                                                  ],
                                                ),
                                              ),
                                              MyButton.outlined(
                                                onPressed: () {
                                                  controller.pickDateRange();
                                                },
                                                borderColor:
                                                    colorScheme.primary,
                                                padding: MySpacing.xy(16, 16),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      LucideIcons.calendar,
                                                      color:
                                                          colorScheme.primary,
                                                      size: 16,
                                                    ),
                                                    MySpacing.width(10),
                                                    MyText.labelMedium(
                                                        controller.selectedDateTimeRange !=
                                                                null
                                                            ? "${dateFormatter.format(controller.selectedDateTimeRange!.start)} - ${dateFormatter.format(controller.selectedDateTimeRange!.end)}"
                                                            : "select_range"
                                                                .tr()
                                                                .capitalizeWords,
                                                        fontWeight: 600,
                                                        color: colorScheme
                                                            .primary),
                                                  ],
                                                ),
                                              ),
                                              MyButton.outlined(
                                                onPressed: () {
                                                  controller.pickDateTime();
                                                },
                                                borderColor:
                                                    colorScheme.primary,
                                                padding: MySpacing.xy(16, 16),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      LucideIcons
                                                          .calendar_check,
                                                      color:
                                                          colorScheme.primary,
                                                      size: 16,
                                                    ),
                                                    MySpacing.width(10),
                                                    MyText.labelMedium(
                                                        controller.selectedDateTime !=
                                                                null
                                                            ? "${dateFormatter.format(controller.selectedDateTime!)} ${timeFormatter.format(controller.selectedDateTime!)}"
                                                            : "select_date_&_time"
                                                                .tr()
                                                                .capitalizeWords,
                                                        fontWeight: 600,
                                                        color: colorScheme
                                                            .primary),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          MySpacing.height(20),
                                          MyText.labelLarge("sliders".tr()),
                                          MySpacing.height(8),
                                          Slider(
                                            value: controller.slider1,
                                            onChanged:
                                                controller.onChangeSlider1,
                                            min: 0,
                                            max: 50,
                                          ),
                                          Slider(
                                            value: controller.slider2,
                                            min: 0,
                                            max: 50,
                                            divisions: 50,
                                            label: controller.slider2
                                                .floor()
                                                .toString(),
                                            onChanged:
                                                controller.onChangeSlider2,
                                          ),
                                          RangeSlider(
                                            values: controller.rangeSlider,
                                            min: 0,
                                            max: 50,
                                            divisions: 100,
                                            labels: RangeLabels(
                                                controller.rangeSlider.start
                                                    .floor()
                                                    .toString(),
                                                controller.rangeSlider.end
                                                    .floor()
                                                    .toString()),
                                            onChanged:
                                                controller.onChangeRangeSlider,
                                            activeColor: theme
                                                .sliderTheme.activeTrackColor,
                                            inactiveColor: theme
                                                .sliderTheme.inactiveTrackColor,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              MySpacing.height(16),
                              MyContainer.bordered(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                paddingAll: 0,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      color:
                                          colorScheme.primary.withValues(alpha: 0.08),
                                      padding: MySpacing.xy(flexSpacing, 12),
                                      child: Row(
                                        children: [
                                          Icon(
                                            LucideIcons.settings,
                                            color: colorScheme.primary,
                                            size: 16,
                                          ),
                                          MySpacing.width(12),
                                          MyText.titleMedium(
                                            "builder".tr(),
                                            fontWeight: 600,
                                            color: colorScheme.primary,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: MySpacing.all(flexSpacing),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 180,
                                                  child: MyText.labelLarge(
                                                      "floating_label_type"
                                                          .tr()
                                                          .capitalizeWords)),
                                              PopupMenuButton(
                                                  onSelected: controller
                                                      .onChangeLabelType,
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return FloatingLabelBehavior
                                                        .values
                                                        .map((behavior) {
                                                      return PopupMenuItem(
                                                        value: behavior,
                                                        height: 32,
                                                        child: MyText.bodySmall(
                                                          behavior
                                                              .name.capitalize!,
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                          fontWeight: 600,
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  color: theme.cardTheme.color,
                                                  child: MyContainer.bordered(
                                                    padding:
                                                        MySpacing.xy(12, 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        MyText.labelMedium(
                                                          controller
                                                              .floatingLabelBehavior
                                                              .name
                                                              .capitalize!,
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          child: Icon(
                                                            LucideIcons
                                                                .chevron_down,
                                                            size: 22,
                                                            color: theme
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          MySpacing.height(8),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 180,
                                                  child: MyText.labelLarge(
                                                      "border_type"
                                                          .tr()
                                                          .capitalizeWords)),
                                              PopupMenuButton(
                                                  onSelected: controller
                                                      .onChangeBorderType,
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return TextFieldBorderType
                                                        .values
                                                        .map((borderType) {
                                                      return PopupMenuItem(
                                                        value: borderType,
                                                        height: 32,
                                                        child: MyText.bodySmall(
                                                          borderType
                                                              .name.capitalize!,
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                          fontWeight: 600,
                                                        ),
                                                      );
                                                    }).toList();
                                                  },
                                                  color: theme.cardTheme.color,
                                                  child: MyContainer.bordered(
                                                    padding:
                                                        MySpacing.xy(12, 8),
                                                    child: Row(
                                                      children: <Widget>[
                                                        MyText.labelMedium(
                                                          controller.borderType
                                                              .name.capitalize!,
                                                          color: theme
                                                              .colorScheme
                                                              .onSurface,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 4),
                                                          child: Icon(
                                                            LucideIcons
                                                                .chevron_down,
                                                            size: 22,
                                                            color: theme
                                                                .colorScheme
                                                                .onSurface,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          MySpacing.height(12),
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: 180,
                                                  child: MyText.labelLarge(
                                                      "filled".tr())),
                                              Switch(
                                                onChanged: controller
                                                    .onChangedFilledChecked,
                                                value: controller.filled,
                                                activeColor:
                                                    theme.colorScheme.primary,
                                                materialTapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                // visualDensity: getCompactDensity,
                                              ),
                                            ],
                                          ),
                                          MySpacing.height(20),
                                          MyText.labelLarge("output".tr()),
                                          MySpacing.height(20),
                                          TextFormField(
                                            decoration: InputDecoration(
                                                labelText: "Sample Text Field",
                                                border: controller.inputBorder,
                                                focusedBorder:
                                                    controller.inputBorder,
                                                filled: controller.filled,
                                                enabledBorder:
                                                    controller.inputBorder,
                                                floatingLabelBehavior:
                                                    controller
                                                        .floatingLabelBehavior),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                MySpacing.height(24)
              ],
            );
          }),
    );
  }
}

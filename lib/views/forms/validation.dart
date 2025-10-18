import 'package:flatten/controllers/forms/basic_controller.dart';
import 'package:flatten/controllers/forms/validation_controller.dart';
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

class ValidationFormsPage extends StatefulWidget {
  const ValidationFormsPage({super.key});

  @override
  _ValidationFormsPageState createState() => _ValidationFormsPageState();
}

class _ValidationFormsPageState extends State<ValidationFormsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ValidationFormsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ValidationFormsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder<ValidationFormsController>(
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
                        "validation_forms".tr().capitalizeWords,
                        fontSize: 18,
                        fontWeight: 600,
                      ),
                      MyBreadcrumb(
                        children: [
                          MyBreadcrumbItem(name: 'forms'.tr()),
                          MyBreadcrumbItem(
                              name: 'validation'.tr(), active: true),
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
                            paddingAll: flexSpacing,
                            child: Form(
                              key: controller.basicValidator.formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText.labelMedium(
                                    "full_name".tr().capitalizeWords,
                                  ),
                                  MySpacing.height(8),
                                  TextFormField(
                                    validator: controller.basicValidator
                                        .getValidation('full_name'),
                                    controller: controller.basicValidator
                                        .getController('full_name'),
                                    decoration: InputDecoration(
                                        hintText: "Denish Navadiya",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never),
                                  ),
                                  MySpacing.height(16),
                                  MyText.labelMedium(
                                    "email_address".tr().capitalizeWords,
                                  ),
                                  MySpacing.height(8),
                                  TextFormField(
                                    validator: controller.basicValidator
                                        .getValidation('email'),
                                    controller: controller.basicValidator
                                        .getController('email'),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: "demo@getappui.com",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
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
                                    validator: controller.basicValidator
                                        .getValidation('password'),
                                    controller: controller.basicValidator
                                        .getController('password'),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        hintText: "****",
                                        hintStyle:
                                            MyTextStyle.bodySmall(xMuted: true),
                                        border: outlineInputBorder,
                                        enabledBorder: outlineInputBorder,
                                        focusedBorder: focusedInputBorder,
                                        prefixIcon: Icon(
                                          LucideIcons.lock,
                                          size: 20,
                                        ),
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never),
                                  ),
                                  MySpacing.height(20),
                                  MyText.labelMedium(
                                    "gender".tr(),
                                  ),
                                  MySpacing.height(8),
                                  DropdownButtonFormField<Gender>(
                                      dropdownColor: colorScheme.surface,
                                      menuMaxHeight: 200,
                                      items: Gender.values
                                          .map((gender) =>
                                              DropdownMenuItem<Gender>(
                                                  value: gender,
                                                  child: MyText.labelMedium(
                                                    gender.name.capitalize!,
                                                  )))
                                          .toList(),
                                      icon: Icon(
                                        LucideIcons.chevron_down,
                                        size: 20,
                                      ),
                                      decoration: InputDecoration(
                                          hintText: "Select gender",
                                          hintStyle: MyTextStyle.bodySmall(
                                              xMuted: true),
                                          border: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          focusedBorder: focusedInputBorder,
                                          contentPadding: MySpacing.all(16),
                                          isCollapsed: true,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never),
                                      onChanged: controller.basicValidator
                                          .onChanged<Object?>('gender'),
                                      validator: controller.basicValidator
                                          .getValidation<Gender?>('gender')),
                                  MySpacing.height(20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MyButton(
                                        onPressed: controller.onResetBasicForm,
                                        elevation: 0,
                                        padding: MySpacing.xy(20, 16),
                                        backgroundColor: contentTheme.secondary,
                                        borderRadiusAll:
                                            AppStyle.buttonRadius.medium,
                                        child: MyText.bodySmall(
                                          'clear'.tr(),
                                          color: contentTheme.onSecondary,
                                        ),
                                      ),
                                      MySpacing.width(16),
                                      MyButton(
                                        onPressed: controller.onSubmitBasicForm,
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
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

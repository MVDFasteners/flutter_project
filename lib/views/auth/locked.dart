import 'package:flatten/controllers/auth/locked_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/auth_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class LockedPage extends StatefulWidget {
  const LockedPage({super.key});

  @override
  State<LockedPage> createState() => _LockedPageState();
}

class _LockedPageState extends State<LockedPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late LockedController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LockedController());
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Padding(
            padding: MySpacing.all(flexSpacing),
            child: Form(
              key: controller.basicValidator.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      Images.logoIcon,
                      height: 28,
                    ),
                  ),
                  MySpacing.height(16),
                  Center(
                    child: MyText.titleLarge(
                      "locked".tr(),
                      fontWeight: 700,
                    ),
                  ),
                  MySpacing.height(8),
                  Center(
                    child: MyText(
                      "hello_den,_enter_your_password_to_unlock_the_screen!"
                          .tr(),
                    ),
                  ),
                  MySpacing.height(16),
                  Center(
                    child: MyContainer.none(
                      borderRadiusAll: 26,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                        Images.avatars[0],
                        height: 44,
                        width: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  MySpacing.height(8),
                  Center(
                    child: MyText(
                      "den".tr(),
                      fontWeight: 700,
                    ),
                  ),
                  MySpacing.height(16),
                  MyText.labelMedium(
                    "password".tr(),
                    fontWeight: 600,
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    controller:
                        controller.basicValidator.getController('password'),
                    validator:
                        controller.basicValidator.getValidation('password'),
                    obscureText: !controller.showPassword,
                    decoration: InputDecoration(
                        suffixIcon: InkWell(
                          onTap: controller.onShowPassword,
                          child: Icon(
                            controller.showPassword
                                ? LucideIcons.eye
                                : LucideIcons.eye_off,
                            size: 20,
                          ),
                        ),
                        prefixIcon: Icon(LucideIcons.lock, size: 18),
                        hintText: "Password",
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder,
                        contentPadding: MySpacing.all(12),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                  MySpacing.height(16),
                  Center(
                    child: MyButton.rounded(
                      onPressed: controller.onLock,
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: contentTheme.primary,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          controller.loading
                              ? SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    color: colorScheme.onPrimary,
                                    strokeWidth: 1.2,
                                  ),
                                )
                              : Container(),
                          if (controller.loading) MySpacing.width(16),
                          MyText.bodySmall(
                            'unlock'.tr(),
                            color: contentTheme.onPrimary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MySpacing.height(16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

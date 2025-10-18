import 'package:flatten/controllers/faqs_controller.dart';
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
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FAQsPage extends StatefulWidget {
  const FAQsPage({super.key});

  @override
  State<FAQsPage> createState() => _FAQsPageState();
}

class _FAQsPageState extends State<FAQsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late FAQsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FAQsController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "faqs".tr(),
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(
                            name: 'extra_pages'.tr().capitalizeWords),
                        MyBreadcrumbItem(name: 'faqs'.tr(), active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(40),
              Column(
                children: [
                  Icon(
                    LucideIcons.circle_help,
                    size: 36,
                  ),
                  MySpacing.height(12),
                  MyText.labelLarge(
                    "frequently_asked_questions".tr().capitalizeWords,
                    fontSize: 20,
                  ),
                  MySpacing.height(12),
                  SizedBox(
                    width: 400,
                    child: MyText.bodySmall(
                      controller.dummyTexts[7],
                      maxLines: 2,
                    ),
                  ),
                  MySpacing.height(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        onPressed: () {},
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: contentTheme.success,
                        borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.phone,
                              size: 14,
                              color: contentTheme.onSuccess,
                            ),
                            MySpacing.width(10),
                            MyText.bodySmall(
                              'contact_us'.tr().capitalizeWords,
                              color: contentTheme.onSuccess,
                            ),
                          ],
                        ),
                      ),
                      MySpacing.width(16),
                      MyButton(
                        onPressed: () {},
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: contentTheme.primary,
                        borderRadiusAll: AppStyle.buttonRadius.medium,
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.mail,
                              size: 14,
                              color: contentTheme.onPrimary,
                            ),
                            MySpacing.width(12),
                            MyText.bodySmall(
                              'email_us_your_question'.tr(),
                              color: contentTheme.onSuccess,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(48),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyFlex(
                      wrapAlignment: WrapAlignment.center,
                      wrapCrossAlignment: WrapCrossAlignment.center,
                      children: [
                        MyFlexItem(
                            sizes: "lg-5 md-12",
                            child: Column(
                              children: [
                                buildFAQItem("what_is_lorem_ipsum?".tr(),
                                    controller.dummyTexts[1]),
                                MySpacing.height(28),
                                buildFAQItem("why_use_lorem_ipsum?".tr(),
                                    controller.dummyTexts[1]),
                                MySpacing.height(28),
                                buildFAQItem("how_many_variations_exist?".tr(),
                                    controller.dummyTexts[1]),
                                MySpacing.height(28),
                                buildFAQItem("What_is_lorem_ipsum?".tr(),
                                    controller.dummyTexts[1]),
                              ],
                            )),
                        MyFlexItem(
                            sizes: "lg-5 md-12",
                            child: Column(
                              children: [
                                buildFAQItem("is_safe_use_lorem_ipsum?".tr(),
                                    controller.dummyTexts[1]),
                                MySpacing.height(28),
                                buildFAQItem("when_can_be_used?".tr(),
                                    controller.dummyTexts[1]),
                                MySpacing.height(28),
                                buildFAQItem(
                                    "license_&_copyright".tr().capitalizeWords,
                                    controller.dummyTexts[1]),
                                MySpacing.height(28),
                                buildFAQItem("is_safe_use_lorem_ipsum?".tr(),
                                    controller.dummyTexts[1]),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget buildFAQItem(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyContainer.rounded(
          height: 30,
          width: 30,
          paddingAll: 0,
          color: contentTheme.primary.withValues(alpha: 0.12),
          child: Center(
            child: MyText(
              'Q',
              color: contentTheme.primary,
              fontWeight: 600,
            ),
          ),
        ),
        MySpacing.width(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.labelLarge(
                title,
              ),
              MySpacing.height(4),
              MyText.bodySmall(
                description,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

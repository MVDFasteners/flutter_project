import 'package:flatten/controllers/pages/success_controller.dart';
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
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late SuccessController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SuccessController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
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
                      "Success",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "Success", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyFlex(contentPadding: false, children: [
                      MyFlexItem(
                        sizes: "lg-4",
                        child: MyContainer(
                          child: Column(
                            children: [
                              MyContainer(
                                child: MyText.titleLarge(
                                  "Success!",
                                  fontWeight: 600,
                                ),
                              ),
                              SizedBox(
                                width: 400,
                                child: MyText.bodySmall(
                                  controller.dummyTexts[7],
                                  maxLines: 1,
                                ),
                              ),
                              Image.asset(
                                Images.success[0],
                                // height: 600,
                              ),
                              MyFlex(
                                contentPadding: true,
                                children: [
                                  MyFlexItem(
                                    sizes: "lg-6 md-5 ",
                                    child: MyButton.outlined(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      borderColor: contentTheme.primary,
                                      splashColor:
                                          contentTheme.primary.withValues(alpha: 0.1),
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: MyText.bodySmall(
                                              'Report For Skipped Items',
                                              overflow: TextOverflow.ellipsis,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                          MySpacing.width(8),
                                          MyContainer.rounded(
                                            paddingAll: 6,
                                            color: contentTheme.primary
                                                .withAlpha(50),
                                            child: MyText.bodyMedium("6"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  MyFlexItem(
                                    sizes: "lg-6 md-5",
                                    child: MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: MyText.bodySmall(
                                              'Go to imported items',
                                              color: contentTheme.onPrimary,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          MySpacing.width(8),
                                          MyContainer.rounded(
                                            paddingAll: 6,
                                            color: contentTheme.secondary
                                                .withAlpha(100),
                                            child: MyText.bodyMedium(
                                              "145",
                                              color: contentTheme.onPrimary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  MySpacing.width(16),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])
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

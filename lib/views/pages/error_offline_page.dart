import 'package:flatten/controllers/pages/error_offline_controller.dart';
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

class ErrorOfflinePage extends StatefulWidget {
  const ErrorOfflinePage({super.key});

  @override
  State<ErrorOfflinePage> createState() => _ErrorOfflinePageState();
}

class _ErrorOfflinePageState extends State<ErrorOfflinePage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ErrorOfflineController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ErrorOfflineController());
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
                      "ERROR",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "Offline", active: true),
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
                                  "We're currently offline",
                                  textAlign: TextAlign.center,
                                  fontWeight: 600,
                                ),
                              ),
                              MySpacing.height(16),
                              MyText.bodyMedium(
                                "We can't show you this images because you aren't connected to the internet. When you’re back online refresh the page or hit the button below",
                                textAlign: TextAlign.center,
                                muted: true,
                              ),
                              Image.asset(
                                Images.error[4],
                                // height: 600,
                              ),
                              MyFlex(
                                contentPadding: true,
                                children: [
                                  MyFlexItem(
                                    sizes: "lg-5 md-5",
                                    child: MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: MyText.bodySmall(
                                        'Refresh',
                                        color: contentTheme.onPrimary,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
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

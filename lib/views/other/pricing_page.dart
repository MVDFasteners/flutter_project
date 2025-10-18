import 'package:flatten/controllers/other/pricing_controller.dart';
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
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class PricingPage extends StatefulWidget {
  const PricingPage({super.key});

  @override
  State<PricingPage> createState() => _PricingPageState();
}

class _PricingPageState extends State<PricingPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late PricingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PricingController());
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
                      "Pricing",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Extra Pages'),
                        MyBreadcrumbItem(name: 'Pricing', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(22),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Our ',
                      style: MyTextStyle.getStyle(
                        fontSize: 32,
                      ),
                      children: [
                        TextSpan(
                          text: 'Plans',
                          style: MyTextStyle.getStyle(
                              fontSize: 32, fontWeight: 600),
                        ),
                      ],
                    ),
                  ),
                  MySpacing.height(12),
                  SizedBox(
                    width: 400,
                    child: Center(
                      child: MyText.bodySmall(
                        controller.dummyTexts[7],
                        maxLines: 2,
                        muted: true,
                      ),
                    ),
                  ),
                ],
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
                      child: MyCard(
                        shadow: MyShadow(
                            elevation: 1, position: MyShadowPosition.bottom),
                        paddingAll: 24,
                        child: Column(
                          children: [
                            MyText.titleMedium(
                              "PROFESSIONAL PACK",
                              fontWeight: 600,
                            ),
                            MySpacing.height(32),
                            MyContainer.rounded(
                              height: 60,
                              width: 60,
                              color: contentTheme.primary.withValues(alpha: 0.12),
                              child: Center(
                                child: Icon(
                                  LucideIcons.users,
                                  color: contentTheme.primary,
                                ),
                              ),
                            ),
                            MySpacing.height(32),
                            RichText(
                              text: TextSpan(
                                text: '\$ 19',
                                style: MyTextStyle.getStyle(
                                    fontSize: 32, fontWeight: 600),
                                children: [
                                  TextSpan(
                                    text: '/ Month',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MySpacing.height(32),
                            buildText("10 GB Storage", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("500 GB BandWidth", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("No Domain", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("1 User", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("Email Support", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("24 x 7 Support", contentTheme.primary),
                            MySpacing.height(32),
                            MyButton(
                              onPressed: () {},
                              elevation: 0,
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: MyText.bodySmall(
                                'Sign Up',
                                color: contentTheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-4 md-12",
                      child: MyContainer(
                        color: contentTheme.primary,
                        paddingAll: 24,
                        child: Column(
                          children: [
                            MyText.titleMedium(
                              "BUSINESS PACK",
                              fontWeight: 600,
                              color: contentTheme.onPrimary,
                            ),
                            MySpacing.height(32),
                            MyContainer.rounded(
                              height: 60,
                              width: 60,
                              color: contentTheme.onPrimary.withValues(alpha: 0.12),
                              child: Center(
                                child: Icon(
                                  LucideIcons.award,
                                  color: contentTheme.onPrimary,
                                ),
                              ),
                            ),
                            MySpacing.height(32),
                            RichText(
                              text: TextSpan(
                                text: '\$ 29',
                                style: MyTextStyle.getStyle(
                                    fontSize: 32,
                                    fontWeight: 600,
                                    color: contentTheme.onPrimary),
                                children: [
                                  TextSpan(
                                    text: '/ Month',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MySpacing.height(32),
                            buildText("50 GB Storage", contentTheme.onPrimary),
                            MySpacing.height(16),
                            buildText(
                                "900 GB BandWidth", contentTheme.onPrimary),
                            MySpacing.height(16),
                            buildText("2 Domain", contentTheme.onPrimary),
                            MySpacing.height(16),
                            buildText("10 User", contentTheme.onPrimary),
                            MySpacing.height(16),
                            buildText("Email Support", contentTheme.onPrimary),
                            MySpacing.height(16),
                            buildText("24 x 7 Support", contentTheme.onPrimary),
                            MySpacing.height(32),
                            MyButton(
                              onPressed: () {},
                              elevation: 0,
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: contentTheme.onPrimary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: MyText.bodySmall(
                                'Sign Up',
                                color: contentTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-4 md-12",
                      child: MyCard(
                        shadow: MyShadow(
                            elevation: 1, position: MyShadowPosition.bottom),
                        paddingAll: 24,
                        child: Column(
                          children: [
                            MyText.titleMedium(
                              "ENTERPRISE PACK",
                              fontWeight: 600,
                            ),
                            MySpacing.height(32),
                            MyContainer.rounded(
                              height: 60,
                              width: 60,
                              color: contentTheme.primary.withValues(alpha: 0.12),
                              child: Center(
                                child: Icon(
                                  LucideIcons.briefcase,
                                  color: contentTheme.primary,
                                ),
                              ),
                            ),
                            MySpacing.height(44),
                            MyText.titleMedium('Based on Usage',
                                fontWeight: 600),
                            MySpacing.height(44),
                            buildText("100 GB Storage", contentTheme.primary),
                            MySpacing.height(16),
                            buildText(
                                "Unlimited BandWidth", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("Unlimited Domain", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("Unlimited User", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("Email Support", contentTheme.primary),
                            MySpacing.height(16),
                            buildText("24 x 7 Support", contentTheme.primary),
                            MySpacing.height(32),
                            MyButton(
                              onPressed: () {},
                              elevation: 0,
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: contentTheme.primary,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: MyText.bodySmall(
                                'Contact US',
                                color: contentTheme.onPrimary,
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

Widget buildText(String text, Color? color) {
  return MyText.bodySmall(
    text,
    fontSize: 14,
    color: color,
  );
}

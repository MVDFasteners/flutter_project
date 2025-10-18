import 'package:flatten/controllers/apps/nft/dashboard_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
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
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class NFTDashboardPage extends StatefulWidget {
  const NFTDashboardPage({super.key});

  @override
  State<NFTDashboardPage> createState() => _NFTDashboardPageState();
}

class _NFTDashboardPageState extends State<NFTDashboardPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late NFTDashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NFTDashboardController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
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
                      "NFT Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "NFT"),
                        MyBreadcrumbItem(name: "Dashboard", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyFlex(
                      wrapAlignment: WrapAlignment.start,
                      contentPadding: false,
                      wrapCrossAlignment: WrapCrossAlignment.start,
                      children: [
                        MyFlexItem(
                          sizes: "lg-8",
                          child: Column(
                            children: [
                              MyFlex(
                                contentPadding: false,
                                children: [
                                  MyFlexItem(
                                    sizes: "lg-6 md-12",
                                    child: MyContainer(
                                      // shadow: MyShadow(elevation: 4),
                                      paddingAll: 0,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Image.asset(
                                            Images.marketplaceImages[2],
                                            height: 300,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                          Padding(
                                            padding: MySpacing.all(24),
                                            child: MyContainer(
                                              height: 250,
                                              color:
                                                  Colors.white.withAlpha(120),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  MyText.bodyMedium(
                                                    "Time remaining",
                                                    color: Colors.black,
                                                  ),
                                                  MyText.titleMedium(
                                                    "${Utils.getTimeStringFromDateTime(
                                                      DateTime.now(),
                                                    )}",
                                                    fontWeight: 700,
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    muted: true,
                                                  ),
                                                  MySpacing.height(12),
                                                  Image.asset(
                                                      Images.ethLogoIcon,
                                                      height: 34),
                                                  MySpacing.height(12),
                                                  MyText.bodyMedium(
                                                    "Highest Bid",
                                                    color: Colors.black,
                                                  ),
                                                  MyText.bodyMedium(
                                                    "25.55 ETH",
                                                    fontWeight: 700,
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                  MyButton(
                                                    onPressed: () {},
                                                    elevation: 0,
                                                    borderRadiusAll: AppStyle
                                                        .buttonRadius.medium,
                                                    padding:
                                                        MySpacing.xy(20, 16),
                                                    backgroundColor:
                                                        contentTheme.primary,
                                                    child: MyText.bodySmall(
                                                      'Place a Bid',
                                                      color: contentTheme
                                                          .onPrimary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MyFlexItem(
                                    sizes: "lg-6",
                                    child: buildProductCard(
                                      "Wild Forest",
                                      "25.55 ETH",
                                    ),
                                  ),
                                ],
                              ),
                              MySpacing.height(20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyText.titleMedium(
                                        "Top Seller",
                                        fontWeight: 600,
                                        fontSize: 18,
                                      ),
                                      MyButton(
                                        onPressed: () {},
                                        elevation: 0,
                                        borderColor: contentTheme.primary,
                                        backgroundColor: contentTheme.primary
                                            .withValues(alpha: 0.12),
                                        splashColor: contentTheme.primary
                                            .withValues(alpha: 0.2),
                                        borderRadiusAll:
                                            AppStyle.buttonRadius.medium,
                                        child: Row(
                                          children: [
                                            MyText.bodySmall(
                                              'View All',
                                              fontWeight: 600,
                                              color: contentTheme.primary,
                                            ),
                                            MySpacing.width(8),
                                            Icon(
                                              LucideIcons.move_right,
                                              color: contentTheme.primary,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(24),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        buildTopSeller(
                                          Images.avatars[0],
                                          "Donica ",
                                          "\$44,654.45",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[1],
                                          "Kevina ",
                                          "\$55,658.25",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[2],
                                          "Barnard ",
                                          "\$44,987.45",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[3],
                                          "Shandra ",
                                          "\$68,154.89",
                                        ),
                                        buildTopSeller(
                                          Images.avatars[4],
                                          "Ivor ",
                                          "\$99,562.87",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              MySpacing.height(20),
                              MyFlex(
                                contentPadding: false,
                                children: [
                                  MyFlexItem(
                                    sizes: "lg-6 sm-12",
                                    child: buildProductCard(
                                      "Antonia Forest",
                                      "89.10 ETH",
                                    ),
                                  ),
                                  MyFlexItem(
                                    sizes: "lg-6 sm-12",
                                    child: buildProductCard(
                                      "Earl Forest",
                                      "35.05 ETH",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        MyFlexItem(
                          sizes: "lg-4 md-12",
                          child: Column(
                            children: [
                              buildProfileDetail(),
                              MySpacing.height(24),
                              MyCard(
                                shadow: MyShadow(elevation: 0.5),
                                paddingAll: 20,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.wallet,
                                          color: contentTheme.onBackground
                                              .withAlpha(220),
                                        ),
                                        MySpacing.width(12),
                                        MyText.bodyMedium(
                                          "Your Balance",
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    MySpacing.height(16),
                                    MyContainer.bordered(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                Images.ethLogoIcon,
                                                height: 34,
                                              ),
                                              MySpacing.width(8),
                                              MyText.bodyMedium(
                                                "3,456 ETH",
                                                fontWeight: 600,
                                                fontSize: 16,
                                              ),
                                            ],
                                          ),
                                          MySpacing.height(16),
                                          Row(
                                            children: [
                                              MyButton.rounded(
                                                onPressed: () {},
                                                elevation: 0,
                                                borderColor:
                                                    contentTheme.primary,
                                                backgroundColor: contentTheme
                                                    .primary
                                                    .withAlpha(28),
                                                splashColor: contentTheme
                                                    .primary
                                                    .withAlpha(28),
                                                borderRadiusAll: AppStyle
                                                    .buttonRadius.medium,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      LucideIcons.plus,
                                                      size: 18,
                                                      color:
                                                          contentTheme.primary,
                                                    ),
                                                    MySpacing.width(6),
                                                    MyText.bodySmall(
                                                      'Add',
                                                      fontWeight: 600,
                                                      color:
                                                          contentTheme.primary,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    MySpacing.height(16),
                                    Center(
                                      child: SfCartesianChart(
                                        primaryXAxis: CategoryAxis(
                                          majorGridLines:
                                              MajorGridLines(width: 0),
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        primaryYAxis: CategoryAxis(
                                          majorGridLines:
                                              MajorGridLines(width: 0),
                                          axisLine: AxisLine(width: 0),
                                        ),
                                        tooltipBehavior:
                                            controller.tooltipBehavior,
                                        series: [
                                          SplineSeries<ChartData, String>(
                                            dataSource: controller.chartData,
                                            xValueMapper: (ChartData data, _) =>
                                                data.x,
                                            yValueMapper: (ChartData data, _) =>
                                                data.y,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
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

  Widget buildTopSeller(String avatar, String sellerName, String sellerPrice) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5),
      paddingAll: 8,
      margin: MySpacing.right(16),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      width: 200,
      child: Row(
        children: [
          MyContainer.none(
            borderRadiusAll: AppStyle.buttonRadius.medium,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              avatar,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          MySpacing.width(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(
                sellerName,
                fontWeight: 700,
                fontSize: 16,
              ),
              MyText.bodyMedium(
                sellerPrice,
                muted: true,
                fontSize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildProductCard(String productName, String productPrice) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5),
      padding: MySpacing.all(16),
      borderRadiusAll: AppStyle.buttonRadius.medium,
      child: MyFlex(
        contentPadding: false,
        children: [
          MyFlexItem(
            sizes: "lg-5",
            child: MyContainer(
              borderRadiusAll: AppStyle.buttonRadius.medium,
              paddingAll: 0,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    Images.marketplaceImages[1],
                    height: 267,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  MyContainer.none(
                    paddingAll: 0,
                    height: 40,
                    color: contentTheme.primary.withValues(alpha: 0.6),
                    child: Center(
                      child: MyText.bodyMedium(
                        "Add To Cart",
                        color: contentTheme.onPrimary,
                        fontWeight: 600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MyFlexItem(
            sizes: "lg-7",
            child: SizedBox(
              height: 267,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText.bodyLarge(
                    productName,
                    fontWeight: 600,
                  ),
                  MyContainer.bordered(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText.bodyMedium(
                              "Bidding Ends In",
                            ),

                            MyText.titleMedium(
                              "${Utils.getTimeStringFromDateTime(
                                DateTime.now(),
                              )}",
                              color: contentTheme.primary,
                              fontWeight: 700,
                              fontSize: 20,
                              muted: true,
                            ),
                            MySpacing.height(24),
                            MyText.titleSmall(
                              "Current Bid",
                              fontSize: 12,
                              muted: true,
                            ),
                            // MySpacing.height(6),
                            MyText.titleSmall(
                              productPrice,
                              fontSize: 28,
                              fontWeight: 700,
                              color: contentTheme.primary,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MyButton(
                    onPressed: () {},
                    elevation: 0,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    borderRadiusAll: AppStyle.buttonRadius.medium,
                    child: MyText.bodySmall(
                      'Place a Bid',
                      color: contentTheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileDetail() {
    Widget buildNumbers(String number, String name) {
      return MyContainer(
        paddingAll: 8,
        width: 100,
        color: contentTheme.onBackground.withAlpha(28),
        child: Column(
          children: [
            MyText.bodyMedium(
              number,
              fontSize: 24,
              fontWeight: 600,
              color: contentTheme.onBackground,
            ),
            MyText.bodyMedium(
              name,
              fontSize: 14,
              fontWeight: 600,
              color: contentTheme.onBackground,
            ),
          ],
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MyCard(
            shadow: MyShadow(elevation: 0.5),
            borderRadiusAll: AppStyle.buttonRadius.medium,
            height: 250,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyText.titleMedium(
                    "Deo",
                    fontWeight: 500,
                    fontSize: 14,
                  ),
                  MyText.titleMedium(
                    "Top Rated",
                    fontWeight: 600,
                    fontSize: 16,
                  ),
                  MySpacing.height(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildNumbers("10K", "Followers"),
                      buildNumbers("50K", "Likes"),
                      buildNumbers("80", "Bidding"),
                    ],
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: MyContainer.rounded(
              height: 100,
              width: 100,
              paddingAll: 0,
              child: Image.asset(
                Images.avatars[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

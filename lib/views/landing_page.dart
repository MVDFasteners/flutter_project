import 'package:flatten/controllers/landing_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin, UIMixin {
  late LandingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LandingController(this));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder(
          init: controller,
          builder: (controller) {
            return Stack(
              children: [
                Image.asset(
                  Images.landing[3],
                ),
                Column(
                  children: [
                    MyContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    Images.logoIcon,
                                    height: 24,
                                    fit: BoxFit.cover,
                                    color: contentTheme.primary,
                                  ),
                                  MySpacing.width(8),
                                  MyText.titleMedium(
                                    "FLATTEN",
                                    fontWeight: 600,
                                    fontSize: 24,
                                    letterSpacing: 2,
                                    color: contentTheme.primary,
                                  ),
                                ],
                              ),
                              MySpacing.width(40),
                              TabBar(
                                indicatorColor: Colors.yellow,
                                controller: controller.defaultTabController,
                                isScrollable: true,
                                tabs: [
                                  Tab(
                                    icon: MyText.bodyMedium(
                                      "Home",
                                      fontWeight: controller.defaultIndex == 0
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 0
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: MyText.bodyMedium(
                                      "Feature",
                                      fontWeight: controller.defaultIndex == 1
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 1
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: MyText.bodyMedium(
                                      "ScreenShot",
                                      fontWeight: controller.defaultIndex == 2
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 2
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: MyText.bodyMedium(
                                      "Testimonial",
                                      fontWeight: controller.defaultIndex == 3
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 3
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: MyText.bodyMedium(
                                      "Pricing",
                                      fontWeight: controller.defaultIndex == 4
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 4
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                  Tab(
                                    icon: MyText.bodyMedium(
                                      "Contact Us",
                                      fontWeight: controller.defaultIndex == 5
                                          ? 600
                                          : 500,
                                      color: controller.defaultIndex == 5
                                          ? contentTheme.primary
                                          : null,
                                    ),
                                  ),
                                ],
                                indicatorSize: TabBarIndicatorSize.tab,
                              ),
                              MySpacing.width(40),
                              Row(
                                children: [
                                  MyButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      "LogInn",
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                  MySpacing.width(8),
                                  MyButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      "Sign Up",
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          MySpacing.height(52),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Let's ",
                                  style: MyTextStyle.titleMedium(
                                    fontWeight: 600,
                                    fontSize: 44,
                                  ),
                                ),
                                TextSpan(
                                    text: 'Build Your Product',
                                    style: MyTextStyle.titleMedium(
                                        fontSize: 44,
                                        fontWeight: 600,
                                        color: contentTheme.primary)),
                                TextSpan(
                                  text: '\n By Flatten App.',
                                  style: MyTextStyle.titleMedium(
                                    fontWeight: 600,
                                    fontSize: 44,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(40),
                          SizedBox(
                            width: 600,
                            child: MyText.bodySmall(
                              controller.dummyTexts[7],
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              fontSize: 16,
                              fontWeight: 600,
                              muted: true,
                            ),
                          ),
                          MySpacing.height(52),
                          MyButton(
                            onPressed: () {},
                            elevation: 0,
                            padding: MySpacing.xy(20, 16),
                            backgroundColor: contentTheme.primary,
                            borderRadiusAll: AppStyle.buttonRadius.medium,
                            child: MyText.bodySmall(
                              "Let's Started",
                              color: contentTheme.onPrimary,
                            ),
                          ),
                          MySpacing.height(100),
                          Image.asset(
                            Images.landing[0],
                          ),
                          MySpacing.height(52),
                          buildLayoutTitle(
                            "How IT ",
                            "WORK",
                            " How dose it work?",
                            controller.dummyTexts[1],
                          ),
                          MySpacing.height(52),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            runSpacing: 16,
                            spacing: 32,
                            children: [
                              buildWork(LucideIcons.list,
                                  "1. Intuitive visual editor"),
                              buildWork(LucideIcons.palette,
                                  "2. Huge design collection"),
                              buildWork(LucideIcons.layers,
                                  "3. One click installation"),
                            ],
                          ),
                          MySpacing.height(52),
                        ],
                      ),
                    ),
                    MySpacing.height(40),
                    Padding(
                      padding: MySpacing.all(flexSpacing),
                      child: Column(
                        children: [
                          MySpacing.height(52),
                          buildLayoutTitle(
                            "OUR ",
                            "FEATURES",
                            "Smart Solutions For Professional People",
                            controller.dummyTexts[2],
                          ),
                          MySpacing.height(100),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Images.landing[1],
                              ),
                              Expanded(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    MyText.titleLarge(
                                      "Discover your destination",
                                      fontSize: 32,
                                      fontWeight: 600,
                                    ),
                                    MySpacing.height(8),
                                    SizedBox(
                                      width: 300,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: MyText.bodySmall(
                                          controller.dummyTexts[3],
                                          maxLines: 2,
                                          letterSpacing: 2,
                                          muted: true,
                                        ),
                                      ),
                                    ),
                                    MySpacing.height(16),
                                    buildDiscoveryDestination(
                                      LucideIcons.check,
                                      controller.dummyTexts[1],
                                    ),
                                    MySpacing.height(16),
                                    buildDiscoveryDestination(
                                      LucideIcons.layers,
                                      controller.dummyTexts[2],
                                    ),
                                    MySpacing.height(16),
                                    buildDiscoveryDestination(
                                      LucideIcons.lock,
                                      controller.dummyTexts[2],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          MySpacing.height(flexSpacing),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      MySpacing.xy(flexSpacing, flexSpacing),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText.titleLarge(
                                        "Connecting people, Places",
                                        fontSize: 32,
                                        fontWeight: 600,
                                      ),
                                      MySpacing.height(8),
                                      SizedBox(
                                        width: 300,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: MyText.bodySmall(
                                            controller.dummyTexts[3],
                                            maxLines: 2,
                                            letterSpacing: 2,
                                            muted: true,
                                          ),
                                        ),
                                      ),
                                      MySpacing.height(16),
                                      buildDiscoveryDestination(
                                        LucideIcons.check,
                                        controller.dummyTexts[1],
                                      ),
                                      MySpacing.height(16),
                                      buildDiscoveryDestination(
                                        LucideIcons.layers,
                                        controller.dummyTexts[2],
                                      ),
                                      MySpacing.height(16),
                                      buildDiscoveryDestination(
                                        LucideIcons.lock,
                                        controller.dummyTexts[2],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Image.asset(
                                Images.landing[2],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MyContainer(
                      padding: MySpacing.y(100),
                      width: double.infinity,
                      color: contentTheme.background,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.center,
                        runSpacing: 20,
                        spacing: 40,
                        children: [
                          buildContainer(
                              LucideIcons.globe, "452", "GLOBAL BRANDS"),
                          buildContainer(
                              LucideIcons.smile, "15000+", "HAPPY CLIENT"),
                          buildContainer(
                              LucideIcons.lightbulb, "999+", "CREATIVE IDEAS"),
                          buildContainer(
                              LucideIcons.users, "5000+", "USER CLIENT"),
                        ],
                      ),
                    ),
                    MySpacing.height(40),
                    Padding(
                      padding: MySpacing.all(flexSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MySpacing.height(52),
                          buildLayoutTitle(
                            "OUR ",
                            "TESTIMONIAL",
                            "What Our Customers Say",
                            controller.dummyTexts[3],
                          ),
                          MySpacing.height(52),
                          MyText.bodyMedium(
                            "“Taqueria earum us tenure sapiens deselect asperiores repellat.”",
                            muted: true,
                            fontWeight: 600,
                            textAlign: TextAlign.center,
                          ),
                          MySpacing.height(8),
                          SizedBox(
                            width: 700,
                            child: Align(
                              alignment: Alignment.center,
                              child: MyText.bodySmall(
                                controller.dummyTexts[7],
                                maxLines: 3,
                                fontSize: 16,
                                fontWeight: 600,
                                muted: true,
                              ),
                            ),
                          ),
                          MySpacing.height(40),
                          MyContainer.rounded(
                            paddingAll: 0,
                            height: 100,
                            width: 100,
                            child: Image.asset(
                              Images.avatars[5],
                            ),
                          ),
                          MySpacing.height(16),
                          MyText.titleMedium(
                            "Donica Ainsley",
                            fontWeight: 600,
                          ),
                          MyText.titleMedium(
                            "Web Development, USA",
                            fontWeight: 600,
                            muted: true,
                          ),
                          MySpacing.height(60),
                          Wrap(
                            spacing: 150,
                            runSpacing: 16,
                            children: [
                              Image.asset(
                                Images.brand[0],
                                width: 150,
                              ),
                              Image.asset(
                                Images.brand[1],
                                width: 150,
                              ),
                              Image.asset(
                                Images.brand[2],
                                width: 150,
                              ),
                              Image.asset(
                                Images.brand[3],
                                width: 150,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(40),
                    MyContainer(
                      child: Column(
                        children: [
                          MySpacing.height(52),
                          // buildLayoutTitle(
                          //   "OUR ",
                          //   "PRICING",
                          //   "Pricing Plan",
                          //   controller.dummyTexts[8],
                          // ),
                          Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "OUR ",
                                      style: MyTextStyle.bodyMedium(
                                        fontSize: 22,
                                        muted: true,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "PRICING",
                                      style: MyTextStyle.titleLarge(
                                        fontWeight: 600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // MyText.titleLarge(
                              //   subTitle,
                              //   fontSize: 26,
                              //   fontWeight: 600,
                              //   textAlign: TextAlign.center,
                              // ),
                              MySpacing.height(16),
                              SizedBox(
                                width: 600,
                                child: Align(
                                  child: MyText.bodySmall(
                                    controller.dummyTexts[5],
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    fontSize: 16,
                                    muted: true,
                                  ),
                                ),
                              ),
                              MySpacing.height(16),
                              MyText.titleLarge(
                                "Pricing Plan",
                                fontSize: 26,
                                fontWeight: 600,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          MySpacing.height(40),
                          TabBar(
                            controller: controller.backgroundTabController,
                            isScrollable: true,

                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: contentTheme.primary),
                            tabs: [
                              Tab(
                                icon: MyText.bodyMedium(
                                  "Monthly",
                                  fontWeight: controller.backgroundIndex == 0
                                      ? 600
                                      : 500,
                                  color: controller.backgroundIndex == 0
                                      ? contentTheme.onPrimary
                                      : null,
                                ),
                              ),
                              Tab(
                                icon: MyText.bodyMedium(
                                  "Yearly",
                                  fontWeight: controller.backgroundIndex == 1
                                      ? 600
                                      : 500,
                                  color: controller.backgroundIndex == 1
                                      ? contentTheme.onPrimary
                                      : null,
                                ),
                              ),
                            ],
                            // controller: _tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                          ),
                          MySpacing.height(16),
                          SizedBox(
                            height: 500,
                            child: TabBarView(
                              physics: FixedExtentScrollPhysics(),
                              controller: controller.backgroundTabController,
                              children: [
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    buildMonthlyPricing("Free", "\$00.0", "3",
                                        "600GB", "6", "/Month"),
                                    buildMonthlyPricing("Standard", "\$30.0",
                                        "15", "1TB", "10", "/Month"),
                                    buildMonthlyPricing("Enterprise", "\$60.0",
                                        "25", "3TB", "16", "/Month"),
                                  ],
                                ),
                                Wrap(
                                  alignment: WrapAlignment.center,
                                  spacing: 20,
                                  runSpacing: 20,
                                  children: [
                                    buildMonthlyPricing("Free", "\$30.0", "13",
                                        "2TB", "12", "/Year"),
                                    buildMonthlyPricing("Standard", "\$55.0",
                                        "30", "8TB", "20", "/Year"),
                                    buildMonthlyPricing("Enterprise", "\$102.0",
                                        "50", "10TB", "35", "/Year"),
                                  ],
                                ),
                              ],
                              // controller: _tabController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(40),
                    Padding(
                      padding: MySpacing.all(flexSpacing),
                      child: Column(
                        children: [
                          // MySpacing.height(50),
                          buildLayoutTitle(
                            "OUR ",
                            "FAQs",
                            "Frequently Asked Questions",
                            controller.dummyTexts[5],
                          ),
                          MySpacing.height(52),
                          Wrap(
                            runSpacing: 20,
                            spacing: 100,
                            children: [
                              Image.asset(
                                Images.landing[4],
                              ),
                              SizedBox(
                                width: 500,
                                child: Column(
                                  children: [
                                    ExpansionPanelList.radio(
                                      expandedHeaderPadding: MySpacing.zero,
                                      animationDuration:
                                          Duration(milliseconds: 600),
                                      children: controller.landing
                                          .mapIndexed(
                                            (index, data) =>
                                                ExpansionPanelRadio(
                                              value: data,
                                              canTapOnHeader: true,
                                              headerBuilder: (_, isExpanded) =>
                                                  MyContainer(
                                                child: MyText.titleMedium(
                                                    data.title),
                                              ),
                                              body: MyContainer(
                                                child: MyText.titleMedium(
                                                  controller.dummyTexts[2],
                                                  maxLines: 3,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(40),
                    MyContainer(
                      padding: MySpacing.y(68),
                      width: double.infinity,
                      child: Padding(
                        padding: MySpacing.all(flexSpacing),
                        child: Column(
                          children: [
                            MyText.titleMedium(
                              "Available For Your\nSmartphone.",
                              textAlign: TextAlign.center,
                              fontWeight: 600,
                              fontSize: 40,
                            ),
                            MySpacing.height(40),
                            SizedBox(
                              width: 600,
                              child: Align(
                                child: MyText.bodySmall(
                                  controller.dummyTexts[8],
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  letterSpacing: 2,
                                  muted: true,
                                ),
                              ),
                            ),
                            MySpacing.height(40),
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                Image.asset(
                                  Images.brand[4],
                                ),
                                Image.asset(
                                  Images.brand[5],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    MySpacing.height(40),
                    Padding(
                      padding: MySpacing.all(flexSpacing),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildLayoutTitle(
                            "OUR ",
                            "CONTACT US",
                            "Get in Touch",
                            controller.dummyTexts[5],
                          ),
                          MySpacing.height(52),
                          MyFlex(
                            children: [
                              MyFlexItem(
                                sizes: "lg-3 md-6",
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          Images.brand[6],
                                          height: 100,
                                        ),
                                        MySpacing.width(16),
                                        MyText.titleLarge(
                                          "Say hello!",
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    MySpacing.height(20),
                                    Row(
                                      children: [
                                        MyContainer.none(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withValues(alpha: 0.12),
                                          child: Center(
                                            child: Icon(
                                              LucideIcons.mail,
                                              size: 20,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                        MySpacing.width(16),
                                        MyText.bodyMedium(
                                          "Email",
                                          fontSize: 20,
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    MySpacing.height(20),
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.move_right,
                                        ),
                                        MySpacing.width(8),
                                        MyText.bodyMedium("abc@gmail.com"),
                                      ],
                                    ),
                                    MySpacing.height(20),
                                    Row(
                                      children: [
                                        MyContainer.none(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withValues(alpha: 0.12),
                                          child: Center(
                                            child: Icon(
                                              LucideIcons.phone,
                                              size: 20,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                        MySpacing.width(16),
                                        MyText.bodyMedium(
                                          "Phone",
                                          fontSize: 20,
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    MySpacing.height(20),
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.move_right,
                                        ),
                                        MySpacing.width(8),
                                        MyText.bodyMedium("(+01) 1234 5678 00"),
                                      ],
                                    ),
                                    MySpacing.height(20),
                                    Row(
                                      children: [
                                        MyContainer.none(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          color: contentTheme.primary
                                              .withValues(alpha: 0.12),
                                          child: Center(
                                            child: Icon(
                                              LucideIcons.map,
                                              size: 20,
                                              color: contentTheme.primary,
                                            ),
                                          ),
                                        ),
                                        MySpacing.width(16),
                                        MyText.bodyMedium(
                                          "Address",
                                          fontSize: 20,
                                          fontWeight: 600,
                                        ),
                                      ],
                                    ),
                                    MySpacing.height(20),
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.move_right,
                                        ),
                                        MySpacing.width(8),
                                        MyText.bodyMedium("Anguilla Office"),
                                      ],
                                    ),
                                    MyText.bodyMedium(
                                        "331 Maple Street, Monroe Avenue, CA 90017"),
                                  ],
                                ),
                              ),
                              MyFlexItem(
                                sizes: "lg-4 md-6",
                                child: MyContainer(
                                  child: Column(
                                    children: [
                                      MyFlex(
                                        children: [
                                          MyFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                'First Name', "Denish"),
                                          ),
                                          MyFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                "Last Name", "Navadiya"),
                                          ),
                                        ],
                                      ),
                                      MySpacing.height(20),
                                      MyFlex(
                                        children: [
                                          MyFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                'Email Address',
                                                "example@domain.com"),
                                          ),
                                          MyFlexItem(
                                            sizes: "md-6 sm-12",
                                            child: buildTextField(
                                                "Phone Number",
                                                "+91 123456789"),
                                          ),
                                        ],
                                      ),
                                      MySpacing.height(20),
                                      MyFlex(
                                        children: [
                                          MyFlexItem(
                                            sizes: "md-12",
                                            child: buildTextField(
                                                "Subject", "Type Subject..."),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: MySpacing.xy(12, 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.bodyMedium(
                                              "Message",
                                              fontWeight: 600,
                                              muted: true,
                                            ),
                                            MySpacing.height(8),
                                            TextFormField(
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                hintText: "Write somethings...",
                                                hintStyle:
                                                    MyTextStyle.bodySmall(
                                                        xMuted: true),
                                                border: outlineInputBorder,
                                                enabledBorder:
                                                    outlineInputBorder,
                                                focusedBorder:
                                                    focusedInputBorder,
                                                contentPadding:
                                                    MySpacing.all(16),
                                                isCollapsed: true,
                                                floatingLabelBehavior:
                                                    FloatingLabelBehavior.never,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: MySpacing.x(12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            MyButton(
                                              onPressed: () {},
                                              elevation: 0,
                                              padding: MySpacing.xy(20, 16),
                                              backgroundColor:
                                                  contentTheme.primary,
                                              borderRadiusAll:
                                                  AppStyle.buttonRadius.medium,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    LucideIcons.send,
                                                    size: 16,
                                                  ),
                                                  MySpacing.width(8),
                                                  MyText.bodySmall(
                                                    'Send Message',
                                                    color:
                                                        contentTheme.onPrimary,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    MySpacing.height(40),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        MyContainer.none(
                          padding: MySpacing.y(52),
                          width: double.infinity,
                          color: contentTheme.dark,
                          child: Image.asset(
                            Images.brand[7],
                            height: 300,
                          ),
                        ),
                        Wrap(
                          spacing: 60,
                          runSpacing: 32,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            SizedBox(
                              width: 190,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        Images.logoIcon,
                                        height: 24,
                                        fit: BoxFit.cover,
                                        color: contentTheme.onPrimary,
                                      ),
                                      MySpacing.width(8),
                                      MyText.titleMedium(
                                        "FLATTEN",
                                        fontWeight: 600,
                                        fontSize: 24,
                                        letterSpacing: 2,
                                        color: contentTheme.onPrimary,
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  MyText.bodyMedium(
                                    "example@domain.com",
                                    color: contentTheme.onPrimary,
                                  ),
                                  MyText.bodyMedium(
                                    "(+01) 1234 5678 00",
                                    color: contentTheme.onPrimary,
                                  ),
                                  MySpacing.height(20),
                                  MyText.bodyMedium(
                                    "Follow Us On",
                                    fontWeight: 600,
                                    color: contentTheme.onPrimary,
                                  ),
                                  MySpacing.height(16),
                                  Row(
                                    children: [
                                      buildSocialLogo(LucideIcons.facebook),
                                      MySpacing.width(8),
                                      buildSocialLogo(LucideIcons.twitter),
                                      MySpacing.width(8),
                                      buildSocialLogo(LucideIcons.linkedin),
                                      MySpacing.width(8),
                                      buildSocialLogo(LucideIcons.youtube),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFooter(
                                  "About Us",
                                  "Support Center",
                                  "Customer Support",
                                  "About Us",
                                  "Copyright",
                                  "Popular Campaign",
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFooter(
                                  "Our Information",
                                  "Return Policy",
                                  "Privacy Policy",
                                  "Terms & Conditions",
                                  "Site Map",
                                  "Store Hours",
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFooter(
                                  "My Account",
                                  "Press Inquiries",
                                  "Social Media Directories",
                                  "Images & B-roll",
                                  "Permissions",
                                  "Speaker Requests",
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildFooter(
                                  "Policy",
                                  "Application Security",
                                  "Software Principles",
                                  "Unwanted Software",
                                  "Responsible Supply Chain",
                                  "Speaker Requests",
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildWork(IconData icons, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MyContainer.rounded(
          height: 80,
          width: 80,
          paddingAll: 0,
          color: contentTheme.primary.withValues(alpha: 0.12),
          child: Center(
              child: Icon(
            icons,
            color: contentTheme.primary,
            size: 40,
          )),
        ),
        MySpacing.height(16),
        MyText.bodyMedium(
          title,
          fontSize: 20,
          fontWeight: 600,
        ),
        MySpacing.height(8),
        SizedBox(
          width: 280,
          child: Align(
            alignment: Alignment.center,
            child: MyText.bodyMedium(
              controller.dummyTexts[1],
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        )
      ],
    );
  }

  Widget buildDiscoveryDestination(IconData icons, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyContainer.rounded(
          height: 32,
          width: 32,
          paddingAll: 0,
          color: contentTheme.primary.withValues(alpha: 0.12),
          child: Center(
            child: Icon(
              icons,
              size: 16,
              color: contentTheme.primary,
            ),
          ),
        ),
        MySpacing.width(16),
        Expanded(
          child: MyText.bodySmall(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget buildContainer(IconData icons, String number, String text) {
    return MyContainer.bordered(
      padding: MySpacing.xy(24, 16),
      height: 100,
      width: 250,
      color: contentTheme.primary.withAlpha(30),
      child: Row(
        children: [
          Icon(
            icons,
            size: 36,
            color: contentTheme.primary,
          ),
          MySpacing.width(8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(
                number,
                fontSize: 26,
                fontWeight: 600,
                color: contentTheme.primary,
              ),
              MyText.bodyMedium(
                text,
                fontSize: 16,
                color: contentTheme.primary,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildLayoutTitle(
      String title1, String title2, String subTitle, String dummyText) {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: title1,
                style: MyTextStyle.bodyMedium(
                  fontSize: 22,
                  muted: true,
                ),
              ),
              TextSpan(
                text: title2,
                style: MyTextStyle.titleLarge(
                  fontWeight: 600,
                ),
              ),
            ],
          ),
        ),
        // MySpacing.height(16),
        MyText.titleLarge(
          subTitle,
          fontSize: 26,
          fontWeight: 600,
          textAlign: TextAlign.center,
        ),
        MySpacing.height(32),
        SizedBox(
          width: 600,
          child: Align(
            child: MyText.bodySmall(
              dummyText,
              textAlign: TextAlign.center,
              maxLines: 2,
              fontSize: 16,
              muted: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildMonthlyPricing(
      String monthlyPremiumType,
      String monthlyPremiumPrice,
      String project,
      String storage,
      String domain,
      String selectMonth) {
    return MyContainer.bordered(
      height: 450,
      width: 350,
      child: Column(
        children: [
          MyContainer(
            width: 300,
            color: contentTheme.primary.withAlpha(20),
            child: Column(
              children: [
                MyText.bodyMedium(
                  monthlyPremiumType,
                  fontSize: 20,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: monthlyPremiumPrice,
                        style: MyTextStyle.bodyMedium(
                          fontWeight: 600,
                          fontSize: 32,
                          color: contentTheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: selectMonth,
                        style: MyTextStyle.titleMedium(
                          // fontSize: 44,
                          fontWeight: 600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          MySpacing.height(32),
          Row(
            children: [
              Icon(
                LucideIcons.check,
              ),
              MySpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: project,
                      style: MyTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: " Project",
                        style: MyTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(16),
          Row(
            children: [
              Icon(
                LucideIcons.check,
              ),
              MySpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: storage,
                      style: MyTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: " Storage",
                        style: MyTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(16),
          Row(
            children: [
              Icon(
                LucideIcons.check,
              ),
              MySpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Unlimited ",
                      style: MyTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: "Contacts",
                        style: MyTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(16),
          Row(
            children: [
              Icon(
                LucideIcons.check,
              ),
              MySpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: domain,
                      style: MyTextStyle.bodyLarge(fontWeight: 600),
                    ),
                    TextSpan(
                        text: " Domains",
                        style: MyTextStyle.bodyMedium(muted: true)),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(16),
          Row(
            children: [
              Icon(
                LucideIcons.check,
              ),
              MySpacing.width(8),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Free Support ",
                      style: MyTextStyle.bodyMedium(
                        muted: true,
                      ),
                    ),
                    TextSpan(
                        text: "24/7",
                        style: MyTextStyle.bodyLarge(
                          fontWeight: 600,
                        )),
                  ],
                ),
              ),
            ],
          ),
          MySpacing.height(36),
          MyButton(
            onPressed: () {},
            elevation: 0,
            padding: MySpacing.xy(20, 16),
            backgroundColor: contentTheme.primary,
            borderRadiusAll: AppStyle.buttonRadius.medium,
            child: MyText.bodySmall(
              "Choose Plan",
              color: contentTheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String fieldTitle, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(
          fieldTitle,
        ),
        MySpacing.height(8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }

  Widget buildFooter(
    String footerTitle,
    String footerItem1,
    String footerItem2,
    String footerItem3,
    String footerItem4,
    String footerItem5,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.titleLarge(
          footerTitle,
          fontWeight: 600,
          color: contentTheme.onPrimary,
        ),
        MySpacing.height(8),
        MyText.bodyMedium(
          footerItem1,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        MySpacing.height(8),
        MyText.bodyMedium(
          footerItem2,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        MySpacing.height(8),
        MyText.bodyMedium(
          footerItem3,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        MySpacing.height(8),
        MyText.bodyMedium(
          footerItem4,
          muted: true,
          color: contentTheme.onPrimary,
        ),
        MySpacing.height(8),
        MyText.bodyMedium(
          footerItem5,
          muted: true,
          color: contentTheme.onPrimary,
        ),
      ],
    );
  }

  Widget buildSocialLogo(IconData icons) {
    return MyContainer.none(
      height: 32,
      width: 32,
      alignment: Alignment.center,
      color: contentTheme.onPrimary.withAlpha(40),
      child: Icon(
        icons,
        color: contentTheme.onPrimary,
        size: 20,
      ),
    );
  }
}

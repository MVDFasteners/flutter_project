import 'package:flatten/controllers/pages/profile_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController(this));
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
                      "Profile",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "Profile", active: true),
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
                      sizes: "lg-4 md-12",
                      child: Column(
                        children: [
                          MyContainer.bordered(
                            paddingAll: 20,
                            child: Column(
                              children: [
                                MyContainer.rounded(
                                  height: 80,
                                  width: 80,
                                  paddingAll: 0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.asset(
                                    Images.avatars[0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // MySpacing.height(16),
                                MyText.titleSmall(
                                  "Den Doe",
                                  fontWeight: 700,
                                  fontSize: 16,
                                  muted: true,
                                ),
                                MyText.titleSmall(
                                  "Founder",
                                  fontSize: 12,
                                  muted: true,
                                ),
                                MySpacing.height(8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.success,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: MyText.bodySmall(
                                        'Follow',
                                        color: contentTheme.onSuccess,
                                      ),
                                    ),
                                    MySpacing.width(flexSpacing / 3),
                                    MyButton(
                                      onPressed: () {},
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                      child: MyText.bodySmall(
                                        'Message',
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                MySpacing.height(16),
                                Row(
                                  children: [
                                    MyText.titleSmall(
                                      "ABOUT ME:",
                                      fontWeight: 700,
                                      muted: true,
                                    )
                                  ],
                                ),
                                MySpacing.height(8),
                                MyText.titleSmall(
                                  controller.dummyTexts[0],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  muted: true,
                                ),
                                MySpacing.height(8),
                                buildProfileDetail(
                                    "Full Name :", "Denish Navadiya"),
                                MySpacing.height(8),
                                buildProfileDetail(
                                    "Mobile :", "(123) 123 1234"),
                                MySpacing.height(8),
                                buildProfileDetail("Email :", "demo@abc.com"),
                                MySpacing.height(8),
                                buildProfileDetail("Location :", "INDIA")
                              ],
                            ),
                          ),
                          MySpacing.height(20),
                          MyContainer.bordered(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyText.titleSmall(
                                      "Message",
                                      fontWeight: 700,
                                      muted: true,
                                    ),
                                    PopupMenuButton(
                                      elevation: 2,
                                      itemBuilder: (BuildContext context) => [
                                        PopupMenuItem(
                                          padding: MySpacing.all(8),
                                          height: 10,
                                          child: MyText.bodySmall(
                                            "Setting",
                                          ),
                                        ),
                                        PopupMenuItem(
                                          padding: MySpacing.all(8),
                                          height: 10,
                                          child: MyText.bodySmall(
                                            "Action",
                                          ),
                                        ),
                                      ],
                                      iconSize: 16,
                                    )
                                  ],
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: controller.chats.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        MyContainer.rounded(
                                          height: 40,
                                          width: 40,
                                          paddingAll: 0,
                                          child: Image.asset(
                                            Images.avatars[
                                                index % Images.avatars.length],
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        MySpacing.width(16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: MyText.bodyMedium(
                                                      "${controller.chats[index].firstName}",
                                                    ),
                                                  ),
                                                  MyButton.text(
                                                    borderRadiusAll: 0,
                                                    padding: MySpacing.xy(0, 0),
                                                    onPressed: () {},
                                                    child: MyText.bodySmall(
                                                      'Reply',
                                                      color:
                                                          contentTheme.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              MyText.bodySmall(
                                                "${controller.chats[index].messages}",
                                                muted: true,
                                                fontWeight: 400,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-8 md-12",
                      child: Column(
                        children: [
                          MyContainer.bordered(
                            paddingAll: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText.titleMedium(
                                  "Orders & Revenue",
                                  fontWeight: 700,
                                  muted: true,
                                ),
                                MySpacing.height(16),
                                SizedBox(
                                  height: 334,
                                  child: SfCartesianChart(
                                    primaryXAxis: NumericAxis(
                                      majorGridLines: MajorGridLines(width: 0),
                                      axisLine: AxisLine(width: 0),
                                    ),
                                    primaryYAxis: NumericAxis(
                                      majorGridLines: MajorGridLines(width: 0),
                                      axisLine: AxisLine(width: 0),
                                    ),
                                    tooltipBehavior: controller.tooltipBehavior,
                                    series: [
                                      ColumnSeries<ChartData, double>(
                                        width: 0.6,
                                        dataSource: controller.chartData,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                      ),
                                      ColumnSeries<ChartData, double>(
                                        width: 0.6,
                                        dataSource: controller.chartData,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MySpacing.height(20),
                          MyContainer.bordered(
                            paddingAll: 20,
                            child: Column(
                              children: [
                                TabBar(
                                  indicatorPadding: MySpacing.y(4),
                                  isScrollable: false,
                                  controller: controller.fullWidthTabController,
                                  indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color:
                                          contentTheme.primary.withAlpha(40)),
                                  tabs: [
                                    Tab(
                                      icon: MyText.labelMedium(
                                        "About",
                                        fontWeight:
                                            controller.fullWidthIndex == 0
                                                ? 600
                                                : 500,
                                        color: controller.fullWidthIndex == 0
                                            ? contentTheme.primary
                                            : null,
                                      ),
                                    ),
                                    Tab(
                                      icon: MyText.labelMedium(
                                        "Timeline",
                                        fontWeight:
                                            controller.fullWidthIndex == 1
                                                ? 600
                                                : 500,
                                        color: controller.fullWidthIndex == 1
                                            ? contentTheme.primary
                                            : null,
                                      ),
                                    ),
                                    Tab(
                                      icon: MyText.labelMedium(
                                        "Settings",
                                        fontWeight:
                                            controller.fullWidthIndex == 2
                                                ? 600
                                                : 500,
                                        color: controller.fullWidthIndex == 2
                                            ? contentTheme.primary
                                            : null,
                                      ),
                                    ),
                                  ],
                                  indicatorSize: TabBarIndicatorSize.tab,
                                ),
                                MySpacing.height(flexSpacing),
                                SizedBox(
                                  height: 1000,
                                  child: TabBarView(
                                    controller:
                                        controller.fullWidthTabController,
                                    children: [
                                      tabAbout(),
                                      tabTimeLine(),
                                      tabSettings(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

  Row buildProfileDetail(String firstName, String lastName) {
    return Row(
      children: [
        MyText.titleSmall(
          firstName,
          fontWeight: 700,
          muted: true,
        ),
        MySpacing.width(8),
        MyText.titleSmall(
          lastName,
          muted: true,
        ),
      ],
    );
  }

  Column buildTextField(String fieldTitle, String hintText) {
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

  Column buildSocialTextField(
    String fieldTitle,
    String hintText,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.labelMedium(
          fieldTitle,
        ),
        MySpacing.height(8),
        TextFormField(
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MyTextStyle.bodySmall(xMuted: true),
            border: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            // focusedBorder: focusedInputBorder,
            prefixIcon: MyContainer.none(
              margin: MySpacing.right(12),
              alignment: Alignment.center,
              color: contentTheme.primary.withAlpha(40),
              child: Icon(
                icon,
                color: contentTheme.primary,
                size: 18,
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 50,
              minWidth: 50,
              maxWidth: 50,
            ),
            contentPadding: MySpacing.all(16),
            isCollapsed: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
      ],
    );
  }

  Widget tabAbout() {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              LucideIcons.briefcase,
              size: 16,
            ),
            MySpacing.width(8),
            MyText.titleMedium(
              "PROJECT",
              muted: true,
              fontSize: 16,
              fontWeight: 700,
            )
          ],
        ),
        MySpacing.height(26),
        MyContainer.none(
          borderRadiusAll: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: DataTable(
            sortColumnIndex: 1,
            sortAscending: true,
            onSelectAll: (_) => {},
            headingRowColor:
                WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
            dataRowMaxHeight: 60,
            showBottomBorder: true,
            columns: [
              DataColumn(
                label: MyText.labelLarge(
                  "Id",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: MyText.labelLarge(
                  "Client",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: MyText.labelLarge(
                  "Project's",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: MyText.labelLarge(
                  "Start Date",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: MyText.labelLarge(
                  "Due Date",
                  color: contentTheme.primary,
                ),
              ),
              DataColumn(
                label: MyText.labelLarge(
                  "Status",
                  color: contentTheme.primary,
                ),
              ),
            ],
            rows: controller.chats
                .mapIndexed(
                  (index, data) => DataRow(
                    cells: [
                      DataCell(
                        MyText.bodyMedium(
                          "#${controller.customers[index].id}",
                        ),
                      ),
                      DataCell(
                        Row(
                          children: [
                            MyContainer.rounded(
                              height: 40,
                              width: 40,
                              paddingAll: 0,
                              child: Image.asset(
                                Images.avatars[index % Images.avatars.length],
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            MySpacing.width(8),
                            MyText.labelLarge(
                              "${controller.chats[index].firstName}",
                            ),
                          ],
                        ),
                      ),
                      DataCell(
                        MyText.labelLarge(
                          "${controller.customers[index].projectName}",
                        ),
                      ),
                      DataCell(MyText.bodySmall(
                        '${DateTime(2020, 3, 4)}',
                        muted: true,
                        fontWeight: 600,
                      )),
                      DataCell(MyText.bodySmall(
                        '${DateTime(2020, 3, 4)}',
                        muted: true,
                        fontWeight: 600,
                      )),
                      DataCell(MyText.bodySmall(
                        '${Utils.getTimeStringFromDateTime(
                          controller.customers[index].lastOrder,
                          showSecond: false,
                        )}',
                        muted: true,
                        fontWeight: 600,
                      )),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        MySpacing.height(26),
        Row(
          children: [
            Icon(
              LucideIcons.monitor,
              size: 16,
            ),
            MySpacing.width(8),
            MyText.titleMedium(
              "EXPERIENCE",
              muted: true,
              fontSize: 16,
              fontWeight: 700,
            )
          ],
        ),
        MySpacing.height(26),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.circle_dot,
              color: contentTheme.primary,
              size: 22,
            ),
            MySpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleSmall(
                  "Lead designer / Developer",
                ),
                MyText.titleSmall(
                  "website.com Year: 2015 - 18",
                  muted: true,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
        MySpacing.height(4),
        Padding(
          padding: MySpacing.x(30),
          child: MyText.bodySmall(
            controller.dummyTexts[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            muted: true,
          ),
        ),
        MySpacing.height(24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.circle_dot,
              color: contentTheme.primary,
              size: 22,
            ),
            MySpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleSmall(
                  "Senior Graphic Designer",
                ),
                MyText.titleSmall(
                  "Software Inc. Year: 2012 - 15",
                  muted: true,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
        MySpacing.height(4),
        Padding(
          padding: MySpacing.x(30),
          child: MyText.bodySmall(
            controller.dummyTexts[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            muted: true,
          ),
        ),
        MySpacing.height(24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              LucideIcons.circle_dot,
              color: contentTheme.primary,
              size: 22,
            ),
            MySpacing.width(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleSmall(
                  "Graphic Designer",
                ),
                MyText.titleSmall(
                  "Getappui Design LLP Year: 2010 - 12",
                  muted: true,
                  fontSize: 10,
                ),
              ],
            ),
          ],
        ),
        MySpacing.height(4),
        Padding(
          padding: MySpacing.x(30),
          child: MyText.bodySmall(
            controller.dummyTexts[0],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            muted: true,
          ),
        ),
      ],
    );
  }

  Widget tabTimeLine() {
    return Column(
      children: [
        MyContainer.bordered(
          paddingAll: 0,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                  hintText: "Write somethings...",
                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                  contentPadding: MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              MyContainer.none(
                color: colorScheme.primary.withValues(alpha: 0.08),
                padding: MySpacing.xy(16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LucideIcons.user,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LucideIcons.map,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LucideIcons.camera,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LucideIcons.smile,
                              color: contentTheme.primary,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyButton(
                      onPressed: () {},
                      elevation: 0,
                      padding: MySpacing.xy(16, 12),
                      backgroundColor: contentTheme.primary,
                      borderRadiusAll: AppStyle.buttonRadius.medium,
                      child: MyText.bodySmall(
                        'Post',
                        color: contentTheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        MySpacing.height(flexSpacing),
        MyContainer.bordered(
          paddingAll: 0,
          child: Column(
            children: [
              MyContainer.none(
                padding: MySpacing.xy(flexSpacing, 12),
                color: colorScheme.primary.withValues(alpha: 0.08),
                child: Row(
                  children: [
                    MyContainer.rounded(
                      height: 36,
                      width: 36,
                      paddingAll: 0,
                      child: Image.asset(
                        Images.avatars[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    MySpacing.width(12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.titleMedium(
                          "Denish Navadiya",
                          fontWeight: 700,
                          fontSize: 12,
                        ),
                        MyText.titleMedium(
                          "${Utils.getTimeStringFromDateTime(
                            DateTime.now(),
                            showSecond: false,
                          )} Minutes Ago",
                          fontWeight: 700,
                          fontSize: 10,
                          muted: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              MyContainer(
                alignment: Alignment.center,
                child: MyText.bodySmall(
                  controller.dummyTexts[0],
                  maxLines: 2,
                  style: TextStyle(fontStyle: FontStyle.italic),
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                  muted: true,
                ),
              ),
              MyContainer(
                padding: MySpacing.xy(36, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyContainer.rounded(
                      height: 36,
                      width: 36,
                      paddingAll: 0,
                      child: Image.asset(
                        Images.avatars[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    MySpacing.width(16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            MyText.bodyMedium(
                              "Kevina Levered ",
                              fontWeight: 600,
                            ),
                            MyText.bodySmall(
                              "about 2 minutes ago",
                              fontSize: 10,
                              muted: true,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        MyText.bodyMedium(
                          "Nice work, makes me think of The Money Pit.",
                          fontWeight: 600,
                          fontSize: 12,
                          muted: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        MySpacing.height(16),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.reply,
                              size: 16,
                            ),
                            MySpacing.width(8),
                            MyText.bodySmall(
                              "Reply",
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tabSettings() {
    return Column(
      children: [
        MyContainer.none(
          color: colorScheme.primary.withValues(alpha: 0.08),
          padding: MySpacing.xy(16, 8),
          child: Row(
            children: [
              Icon(
                LucideIcons.user,
                color: contentTheme.primary,
                size: 16,
              ),
              MySpacing.width(12),
              MyText.titleMedium(
                "PERSONAL INFO",
                fontWeight: 600,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
        MySpacing.height(24),
        MyFlex(
          children: [
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField('First Name', "Denish"),
            ),
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField(
                "Last Name",
                "Navadiya",
              ),
            ),
          ],
        ),
        Padding(
          padding: MySpacing.xy(12, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(
                "Bio",
                fontWeight: 600,
                muted: true,
              ),
              MySpacing.height(8),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Write somethings...",
                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: focusedInputBorder,
                  contentPadding: MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
            ],
          ),
        ),
        MyFlex(
          children: [
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField(
                "Email Address",
                "demo@abc.com",
              ),
            ),
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.labelMedium(
                    'Password',
                  ),
                  MySpacing.height(8),
                  TextFormField(
                    obscureText: controller.showPassword,
                    decoration: InputDecoration(
                      hintText: "********",
                      hintStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: InkWell(
                        onTap: controller.onChangeShowPassword,
                        child: Icon(
                          controller.showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        MySpacing.height(24),
        MyContainer.none(
          color: colorScheme.primary.withValues(alpha: 0.08),
          padding: MySpacing.xy(16, 8),
          child: Row(
            children: [
              Icon(
                LucideIcons.building_2,
                color: contentTheme.primary,
                size: 16,
              ),
              MySpacing.width(12),
              MyText.titleMedium(
                "COMPANY INFO",
                fontWeight: 600,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
        MySpacing.height(24),
        MyFlex(
          children: [
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField('Company Name', "GetAppUi"),
            ),
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildTextField(
                "Website",
                "WWW.example.com",
              ),
            ),
          ],
        ),
        MySpacing.height(24),
        MyContainer.none(
          color: colorScheme.primary.withValues(alpha: 0.08),
          padding: MySpacing.xy(16, 8),
          child: Row(
            children: [
              Icon(
                LucideIcons.globe,
                color: contentTheme.primary,
                size: 16,
              ),
              MySpacing.width(12),
              MyText.titleMedium(
                "SOCIAL",
                fontWeight: 600,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
        MySpacing.height(24),
        MyFlex(
          children: [
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Facebook",
                'facebook.com/username',
                LucideIcons.facebook,
              ),
            ),
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Twitter",
                'twitter.com/username',
                LucideIcons.twitter,
              ),
            ),
          ],
        ),
        MySpacing.height(24),
        MyFlex(
          children: [
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Instagram",
                'instagram.com/username',
                LucideIcons.instagram,
              ),
            ),
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "LinkedIn",
                'linkedIn.com/username',
                LucideIcons.linkedin,
              ),
            ),
          ],
        ),
        MySpacing.height(24),
        MyFlex(
          children: [
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "Duo",
                'duo',
                LucideIcons.video,
              ),
            ),
            MyFlexItem(
              sizes: "md-6 sm-12",
              child: buildSocialTextField(
                "GitHub",
                'github.com/username',
                LucideIcons.github,
              ),
            ),
          ],
        ),
        MySpacing.height(24),
        Padding(
          padding: MySpacing.x(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                onPressed: () {},
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: contentTheme.primary,
                borderRadiusAll: AppStyle.buttonRadius.medium,
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.save,
                      size: 18,
                    ),
                    MySpacing.width(8),
                    MyText.bodySmall(
                      'Save',
                      color: contentTheme.onPrimary,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flatten/controllers/dashboard/job_dashboard_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';

class JobDashboardScreen extends StatefulWidget {
  const JobDashboardScreen({super.key});

  @override
  State<JobDashboardScreen> createState() => _JobDashboardScreenState();
}

class _JobDashboardScreenState extends State<JobDashboardScreen> with UIMixin {
  JobDashboardController controller = Get.put(JobDashboardController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'job_dashboard_controller',
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
                      "Job Dashboard",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Job'),
                        MyBreadcrumbItem(name: 'Dashboard', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats("3,000", "Total Team Members", LucideIcons.users, contentTheme.primary)),
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats("500", "Job Applicants", LucideIcons.user_check, contentTheme.success)),
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats("25%", "Offer Acceptance Rate", LucideIcons.circle_check, contentTheme.info)),
                    MyFlexItem(sizes: 'lg-3 md-6', child: stats("2,100", "Active Subscriptions", LucideIcons.archive, contentTheme.secondary)),
                    MyFlexItem(sizes: 'lg-3 md-6', child: recentCandidate()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: mostViewedCVs()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: recentChat()),
                    MyFlexItem(sizes: 'lg-3 md-6', child: newApplication()),
                    MyFlexItem(child: recentApplication()),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget stats(String title, String subTitle, IconData icon, Color color) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        children: [
          Row(
            children: [
              MyContainer(
                color: color,
                child: Icon(icon, color: contentTheme.light),
              ),
              MySpacing.width(20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(title),
                    MyText.bodySmall(subTitle, maxLines: 1),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget recentCandidate() {
    Widget candidatesData(String image, title, subtitle) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(title, fontWeight: 600, maxLines: 1),
                MyText.bodySmall(subtitle, fontWeight: 600, xMuted: true, maxLines: 1, overflow: TextOverflow.visible)
              ],
            ),
          )
        ],
      );
    }

    List<Map<String, dynamic>> candidates = [
      {'avatar': Images.avatars[0], 'name': 'Lucas Martin', 'description': controller.dummyTexts[0]},
      {'avatar': Images.avatars[1], 'name': 'Emma Thompson', 'description': controller.dummyTexts[1]},
      {'avatar': Images.avatars[2], 'name': 'James Williams', 'description': controller.dummyTexts[2]},
      {'avatar': Images.avatars[3], 'name': 'Mia Wilson', 'description': controller.dummyTexts[3]},
      {'avatar': Images.avatars[4], 'name': 'Oliver Taylor', 'description': controller.dummyTexts[4]},
      {'avatar': Images.avatars[5], 'name': 'Charlotte Harris', 'description': controller.dummyTexts[5]},
    ];

    return MyCard(
        shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
        padding: MySpacing.nBottom(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Newly Added Candidates", fontWeight: 600, maxLines: 1),
            MySpacing.height(24),
            for (Map<String, dynamic> candidate in candidates)
              Column(
                children: [candidatesData(candidate['avatar'], candidate['name'], candidate['description']), MySpacing.height(24)],
              )
          ],
        ));
  }

  Widget mostViewedCVs() {
    Widget cv(String title) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: contentTheme.primary.withAlpha(40),
            child: Icon(LucideIcons.file_text, color: contentTheme.primary),
          ),
          MySpacing.width(12),
          Expanded(child: MyText.bodyMedium(title, fontWeight: 600, overflow: TextOverflow.ellipsis)),
          InkWell(onTap: () {}, child: Icon(LucideIcons.download))
        ],
      );
    }

    List<String> names = [
      "Sophia Williams",
      "Ethan Harris",
      "Olivia Johnson",
      "Aiden Moore",
      "Emma Taylor",
      "Noah Davis",
    ];

    return MyCard(
      shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
      padding: MySpacing.nBottom(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Top Rated Resumes", fontWeight: 600), // Updated title
          MySpacing.height(24),
          for (var name in names)
            Column(
              children: [cv(name), MySpacing.height(24)],
            ),
        ],
      ),
    );
  }

  Widget recentChat() {
    Widget chat(String image, name, message) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          MySpacing.width(16),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.bodyMedium(name, fontWeight: 600),
              MyText.labelSmall(message, fontWeight: 600, maxLines: 1, muted: true, overflow: TextOverflow.ellipsis),
            ],
          )),
          MySpacing.width(28),
          Icon(LucideIcons.message_square, size: 20)
        ],
      );
    }

    List<Map<String, dynamic>> chats = [
      {'avatar': Images.avatars[0], 'name': 'Lucas', 'message': controller.dummyTexts[0]},
      {'avatar': Images.avatars[1], 'name': 'Mia', 'message': controller.dummyTexts[1]},
      {'avatar': Images.avatars[2], 'name': 'Ethan', 'message': controller.dummyTexts[2]},
      {'avatar': Images.avatars[3], 'name': 'Olivia', 'message': controller.dummyTexts[3]},
      {'avatar': Images.avatars[4], 'name': 'Sophia', 'message': controller.dummyTexts[4]},
      {'avatar': Images.avatars[5], 'name': 'Aiden', 'message': controller.dummyTexts[5]},
    ];

    return MyCard(
        shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
        padding: MySpacing.nBottom(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          MyText.bodyMedium("Recent Conversations", fontWeight: 600),
          MySpacing.height(24),
          for (Map<String, dynamic> user in chats)
            Column(
              children: [
                chat(user['avatar'], user['name'], user['message']),
                MySpacing.height(24),
              ],
            ),
        ]));
  }

  Widget newApplication() {
    Widget newApplicationWidget(String avatar, String name, String position) {
      return Row(
        children: [
          MyContainer.rounded(
            paddingAll: 0,
            height: 44,
            width: 44,
            child: Image.asset(avatar),
          ),
          MySpacing.width(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(name, fontWeight: 600, maxLines: 1),
                MyText.bodySmall(position, maxLines: 1),
              ],
            ),
          ),
          MyContainer.rounded(
            onTap: () {},
            paddingAll: 0,
            height: 36,
            width: 36,
            color: contentTheme.primary.withValues(alpha: 0.2),
            child: Icon(LucideIcons.phone_call, size: 12),
          ),
          MySpacing.width(12),
          MyContainer.rounded(
            onTap: () {},
            paddingAll: 0,
            height: 36,
            width: 36,
            color: contentTheme.secondary.withValues(alpha: 0.2),
            child: Icon(LucideIcons.at_sign, size: 12),
          ),
        ],
      );
    }

    List<Map<String, String>> applications = [
      {'avatar': Images.avatars[0], 'name': 'Mona Cruz\'s', 'position': 'React Developer'},
      {'avatar': Images.avatars[1], 'name': 'Ethan Davis', 'position': 'Flutter Developer'},
      {'avatar': Images.avatars[2], 'name': 'Olivia Green', 'position': 'UI/UX Designer'},
      {'avatar': Images.avatars[3], 'name': 'James Wilson', 'position': 'Backend Developer'},
      {'avatar': Images.avatars[4], 'name': 'Sophia Taylor', 'position': 'Mobile App Developer'},
      {'avatar': Images.avatars[5], 'name': 'Liam Brown', 'position': 'Full Stack Developer'},
    ];

    return MyCard(
        shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
        padding: MySpacing.nBottom(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("New Application", fontWeight: 600),
            MySpacing.height(24),
            for (Map<String, String> application in applications)
              Column(
                children: [newApplicationWidget(application['avatar']!, application['name']!, application['position']!), MySpacing.height(24)],
              ),
          ],
        ));
  }

  Widget recentApplication() {
    return MyCard(
        shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
        paddingAll: 24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.bodyMedium("Recent Application"),
            MySpacing.height(24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  sortAscending: true,
                  columnSpacing: 102,
                  onSelectAll: (_) => {},
                  headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                  dataRowMaxHeight: 60,
                  showBottomBorder: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                  columns: [
                    DataColumn(label: MyText.labelLarge('Candidate', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Category', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Designation', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Mail', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Location', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Date', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Type', color: contentTheme.primary)),
                    DataColumn(label: MyText.labelLarge('Action', color: contentTheme.primary)),
                  ],
                  rows: controller.recentApplication
                      .mapIndexed((index, data) => DataRow(cells: [
                            DataCell(Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyContainer.rounded(
                                  height: 40,
                                  width: 40,
                                  paddingAll: 0,
                                  child: Image.asset(Images.avatars[index % Images.avatars.length], fit: BoxFit.cover),
                                ),
                                MySpacing.width(24),
                                MyText.labelMedium(data.candidate, fontWeight: 600)
                              ],
                            )),
                            DataCell(MyText.labelMedium(data.category, fontWeight: 600)),
                            DataCell(MyText.labelMedium(data.designation, fontWeight: 600)),
                            DataCell(MyText.labelMedium(data.mail, fontWeight: 600)),
                            DataCell(MyText.labelMedium(data.location, fontWeight: 600)),
                            DataCell(MyText.labelMedium("${Utils.getDateStringFromDateTime(data.date)}", fontWeight: 600)),
                            DataCell(MyText.labelMedium(data.type, fontWeight: 600)),
                            DataCell(Row(
                              children: [
                                MyContainer(
                                  onTap: () {},
                                  color: contentTheme.primary,
                                  paddingAll: 8,
                                  child: Icon(LucideIcons.download, size: 16, color: contentTheme.onPrimary),
                                ),
                                MySpacing.width(12),
                                MyContainer(
                                  onTap: () {},
                                  color: contentTheme.secondary,
                                  paddingAll: 8,
                                  child: Icon(LucideIcons.pencil, size: 16, color: contentTheme.onPrimary),
                                ),
                              ],
                            ))
                          ]))
                      .toList()),
            )
          ],
        ));
  }
}

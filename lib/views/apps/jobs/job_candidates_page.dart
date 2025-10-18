import 'package:flatten/controllers/apps/jobs/job_candidate_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class JobCandidatePage extends StatefulWidget {
  const JobCandidatePage({super.key});

  @override
  State<JobCandidatePage> createState() => _JobCandidatePageState();
}

class _JobCandidatePageState extends State<JobCandidatePage>
    with SingleTickerProviderStateMixin, UIMixin {
  late JobCandidateController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(JobCandidateController());
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
                      "Job Candidate",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "Job Candidate", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      runAlignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 16,
                      spacing: 16,
                      children: [
                        MyContainer.none(
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: contentTheme.primary.withAlpha(30),
                              prefixIcon: Icon(
                                LucideIcons.search,
                                size: 18,
                                color: contentTheme.primary,
                              ),
                              isDense: true,
                              hintText: "Search Files",
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: contentTheme.primary,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: MySpacing.horizontal(20),
                            ),
                          ),
                        ),
                        MyContainer.none(
                          width: 250,
                          child: PopupMenuButton(
                              onSelected: controller.onSelectedJob,
                              itemBuilder: (BuildContext context) {
                                return [
                                  "Select Job",
                                  "Engineer",
                                  "Developer",
                                  "Artist",
                                  "Lawyer"
                                ].map((behavior) {
                                  return PopupMenuItem(
                                    value: behavior,
                                    height: 32,
                                    child: MyText.bodySmall(
                                      behavior.toString(),
                                      color: contentTheme.primary,
                                      fontWeight: 600,
                                    ),
                                  );
                                }).toList();
                              },
                              color: theme.cardTheme.color,
                              child: MyContainer.none(
                                color: contentTheme.primary.withAlpha(30),
                                padding: MySpacing.xy(12, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectJob.toString(),
                                      color: contentTheme.primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      child: Icon(
                                        LucideIcons.chevron_down,
                                        size: 22,
                                        color: contentTheme.primary,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                        MyContainer.none(
                          width: 250,
                          child: PopupMenuButton(
                              onSelected: controller.onSelectedRating,
                              itemBuilder: (BuildContext context) {
                                return [
                                  "Select Rating",
                                  "Ok",
                                  "Good",
                                  "Better",
                                  "Best",
                                  "Excellent",
                                ].map((behavior) {
                                  return PopupMenuItem(
                                    value: behavior,
                                    height: 32,
                                    child: MyText.bodySmall(
                                      behavior.toString(),
                                      color: contentTheme.primary,
                                      fontWeight: 600,
                                    ),
                                  );
                                }).toList();
                              },
                              color: theme.cardTheme.color,
                              child: MyContainer.none(
                                color: contentTheme.primary.withAlpha(30),
                                padding: MySpacing.xy(12, 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectRating.toString(),
                                      color: contentTheme.primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 4),
                                      child: Icon(
                                        LucideIcons.chevron_down,
                                        size: 22,
                                        color: contentTheme.primary,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                    MySpacing.height(flexSpacing),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 255,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 220,
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      itemCount: controller.jobCandidate.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            MyContainer.none(
                              paddingAll: 0,
                            ),
                            Padding(
                              padding: MySpacing.xy(16, 16),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: MyContainer.none(
                                  borderRadiusAll: 22,
                                  width: 45,
                                  height: 20,
                                  color: contentTheme.primary.withAlpha(40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        LucideIcons.star,
                                        size: 16,
                                        color: AppColors.star,
                                      ),
                                      MySpacing.width(4),
                                      MyText.bodyMedium(
                                        "${controller.jobCandidate[index].rating}",
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: MySpacing.y(26),
                              child: Column(
                                children: [
                                  MyContainer.rounded(
                                    paddingAll: 0,
                                    // borderRadiusAll: 25,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.asset(
                                      Images.avatars[
                                          index % Images.avatars.length],
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  MySpacing.height(12),
                                  MyText.titleSmall(
                                    controller.jobCandidate[index].jobTitle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  MySpacing.height(8),
                                  MyText.titleSmall(
                                    controller.jobCandidate[index].appName,
                                  ),
                                  MySpacing.height(12),
                                  MyButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    padding: MySpacing.xy(20, 16),
                                    backgroundColor: contentTheme.primary,
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      'View Detail',
                                      color: contentTheme.onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )
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

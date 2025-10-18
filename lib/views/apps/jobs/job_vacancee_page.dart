import 'package:flatten/controllers/apps/jobs/job_vacancee_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_progress_bar.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/models/job_vacancee.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class JobVacanciesPage extends StatefulWidget {
  const JobVacanciesPage({super.key});

  @override
  State<JobVacanciesPage> createState() => _JobVacanciesPageState();
}

class _JobVacanciesPageState extends State<JobVacanciesPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late JobVacanceeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(JobVacanceeController());
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
                      "Job Vacancee",
                      fontWeight: 600,
                      fontSize: 18,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "Job Vacancee", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      sizes: "lg-4",
                      child: MyContainer.none(
                        paddingAll: 16,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText.labelLarge(
                                  "Filter",
                                  fontSize: 16,
                                ),
                                MyButton.outlined(
                                  onPressed: () {},
                                  elevation: 0,
                                  padding: MySpacing.xy(20, 16),
                                  borderColor: contentTheme.primary,
                                  splashColor:
                                      contentTheme.primary.withValues(alpha: 0.1),
                                  borderRadiusAll: 20,
                                  child: MyText.bodySmall(
                                    'Reset',
                                    color: contentTheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 24,
                            ),
                            ExpansionTile(
                              childrenPadding: MySpacing.y(16),
                              tilePadding: MySpacing.zero,
                              title: Row(
                                children: [
                                  MyText.labelLarge(
                                    "Salary Range",
                                  ),
                                ],
                              ),
                              children: [
                                RangeSlider(
                                  values: controller.rangeSlider,
                                  min: 0,
                                  max: 100,
                                  divisions: 10,
                                  labels: RangeLabels(
                                      controller.rangeSlider.start
                                          .floor()
                                          .toString(),
                                      controller.rangeSlider.end
                                          .floor()
                                          .toString()),
                                  onChanged: controller.onChangeRangeSlider,
                                  activeColor:
                                      theme.sliderTheme.activeTrackColor,
                                  inactiveColor:
                                      theme.sliderTheme.inactiveTrackColor,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyContainer.bordered(
                                      width: 100,
                                      child: MyText.titleMedium(
                                          "Min. ${controller.rangeSlider.start}"),
                                    ),
                                    MyContainer.bordered(
                                      width: 100,
                                      child: MyText.titleMedium(
                                          "Max. ${controller.rangeSlider.end}"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            MySpacing.height(16),
                            ExpansionTile(
                              childrenPadding: MySpacing.zero,
                              tilePadding: MySpacing.zero,
                              title: Row(
                                children: [
                                  MyText.labelLarge("JobType"),
                                ],
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.jobType.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                          '${controller.jobType[index].name}'),
                                      value:
                                          controller.jobType[index].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          controller.jobType[index].isChecked =
                                              value!;
                                        });
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                            MySpacing.height(16),
                            Row(
                              children: [
                                Expanded(
                                  child: MyText.labelLarge(
                                    "Open to remote",
                                  ),
                                ),
                                Switch(
                                  value: controller.isSwitch,
                                  onChanged: (value) {
                                    setState(() {
                                      controller.isSwitch = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            MySpacing.height(16),
                            ExpansionTile(
                              childrenPadding: MySpacing.zero,
                              tilePadding: MySpacing.zero,
                              title: Row(
                                children: [
                                  MyText.labelLarge(
                                    "Job Categories",
                                  ),
                                ],
                              ),
                              children: [
                                TextFormField(
                                  maxLines: 1,
                                  style: MyTextStyle.bodyMedium(),
                                  decoration: InputDecoration(
                                      hintText: "search",
                                      hintStyle:
                                          MyTextStyle.bodySmall(xMuted: true),
                                      border: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      focusedBorder: focusedInputBorder,
                                      prefixIcon: Align(
                                          alignment: Alignment.center,
                                          child: Icon(
                                            LucideIcons.search,
                                            size: 14,
                                          )),
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 36,
                                          maxWidth: 36,
                                          minHeight: 32,
                                          maxHeight: 32),
                                      contentPadding: MySpacing.xy(16, 12),
                                      isCollapsed: true,
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.jobCategories.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                          '${controller.jobCategories[index].name}'),
                                      value: controller
                                          .jobCategories[index].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          controller.jobCategories[index]
                                              .isChecked = value!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            MySpacing.height(16),
                            ExpansionTile(
                              childrenPadding: MySpacing.zero,
                              tilePadding: MySpacing.zero,
                              title: Row(
                                children: [
                                  MyText.labelLarge(
                                    "Experience",
                                  ),
                                ],
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: controller.jobExperience.length,
                                  itemBuilder: (context, index) {
                                    return CheckboxListTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(
                                          '${controller.jobExperience[index].name}'),
                                      value: controller
                                          .jobExperience[index].isChecked,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          controller.jobExperience[index]
                                              .isChecked = value!;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "lg-8",
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 350,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          mainAxisExtent: 230,
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        itemCount: controller.jobVacancee.length,
                        itemBuilder: (BuildContext context, int index) {
                          return JobVacanceeWidget(
                            jobVacancee: controller.jobVacancee[index],
                          );
                        },
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

class JobVacanceeWidget extends StatefulWidget {
  final JobVacancee jobVacancee;

  const JobVacanceeWidget({
    required this.jobVacancee,
    super.key,
  });

  @override
  State<JobVacanceeWidget> createState() => _JobVacanceeWidgetState();
}

class _JobVacanceeWidgetState extends State<JobVacanceeWidget> with UIMixin {
  late JobVacancee jobVacancee;
  bool isSave = false;

  @override
  void initState() {
    super.initState();
    jobVacancee = widget.jobVacancee;
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer.none(
      paddingAll: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              MyContainer.none(
                borderRadiusAll: 22,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.asset(
                  jobVacancee.image,
                  height: 44,
                  width: 44,
                  fit: BoxFit.cover,
                ),
              ),
              MySpacing.width(12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText.bodyMedium(
                      jobVacancee.companyName,
                      fontSize: 16,
                    ),
                    MyText.bodySmall(
                      jobVacancee.appName,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSave = !isSave;
                      });
                    },
                    icon: Icon(
                        !isSave
                            ? Icons.bookmark_outline
                            : Icons.bookmark_outlined,
                        size: 24,
                        color: contentTheme.primary),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                LucideIcons.map,
                size: 20,
              ),
              MySpacing.width(8),
              MyText.bodyMedium(
                jobVacancee.location,
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                LucideIcons.briefcase,
                size: 20,
              ),
              MySpacing.width(8),
              MyText.bodyMedium(
                "${jobVacancee.years} Years",
                overflow: TextOverflow.ellipsis,
              ),
              MySpacing.width(16),
              Icon(
                LucideIcons.badge_dollar_sign,
                size: 20,
              ),
              MySpacing.width(8),
              MyText.bodyMedium(
                "\$${jobVacancee.amount} - \$${jobVacancee.amount}",
              ),
            ],
          ),
          MyProgressBar(
            width: 300,
            progress: jobVacancee.progress,
            height: 3,
            radius: 4,
            inactiveColor: theme.dividerColor,
            activeColor: colorScheme.primary,
          ),
          Row(
            children: [
              Expanded(
                child: MyText.bodyMedium(
                  "6 of 15 Filled",
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              MyText.bodyMedium(
                "Upload ${jobVacancee.years} Hours ago",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

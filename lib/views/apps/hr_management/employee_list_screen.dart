import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/apps/hr_management/employee_list_controller.dart';
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
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/employee.dart';
import 'package:flatten/views/apps/hr_management/common_text_field.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen>
    with SingleTickerProviderStateMixin, UIMixin {
  late EmployeeListController controller;

  @override
  void initState() {
    controller = EmployeeListController();
    super.initState();
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
                      "Employee List",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Hr Management'),
                        MyBreadcrumbItem(name: 'Employee List', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyFlex(
                  contentPadding: false,
                  children: [
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyContainer(
                          child: Column(
                            children: [
                              buildEmployeeIndex(
                                  LucideIcons.user,
                                  contentTheme.primary,
                                  "Recently Joined",
                                  controller.employee.length.toString(),
                                  contentTheme.primary),
                              Divider(height: 20),
                              buildEmployeeIndex(
                                  LucideIcons.users,
                                  contentTheme.primary,
                                  "Employed Since 1 year",
                                  "2",
                                  contentTheme.primary),
                              Divider(height: 20),
                              buildEmployeeIndex(
                                  LucideIcons.users,
                                  contentTheme.primary,
                                  "Old Employee",
                                  "2",
                                  contentTheme.primary),
                              Divider(height: 20),
                              buildEmployeeIndex(
                                  LucideIcons.crown,
                                  contentTheme.primary,
                                  "Managers",
                                  "2",
                                  contentTheme.primary),
                              Divider(height: 20),
                              buildEmployeeIndex(
                                  LucideIcons.codepen,
                                  contentTheme.primary,
                                  "Flutter Devs",
                                  "2",
                                  contentTheme.primary),
                              Divider(height: 20),
                              buildEmployeeIndex(
                                  LucideIcons.code,
                                  contentTheme.primary,
                                  "React Devs",
                                  "2",
                                  contentTheme.primary),
                              Divider(height: 20),
                              buildEmployeeIndex(
                                  LucideIcons.code,
                                  contentTheme.primary,
                                  "Angular",
                                  "2",
                                  contentTheme.primary),
                              Divider(height: 32),
                              buildAddDataField(),
                            ],
                          ),
                        )),
                    MyFlexItem(
                      sizes: 'lg-8',
                      child: MyCard(
                        shadow: MyShadow(elevation: 0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            controller.employee.isEmpty
                                ? SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Column(
                                        children: [
                                          MyText.bodyLarge(
                                            "No data found. Please Add Employees first",
                                            fontWeight: 600,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: buildEmployeeData()),
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

  Widget buildAddDataField() {
    return Form(
      key: controller.basicValidator.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          EmployeeCommonTextField(
            hintText: "Name",
            controller: controller.nameTE,
            validator: controller.validateName,
          ),
          MySpacing.height(16),
          EmployeeCommonTextField(
            hintText: "Phone Number",
            controller: controller.phoneNoTE,
            validator: controller.validatePhoneNumber,
          ),
          MySpacing.width(12),
          MySpacing.height(12),
          Row(
            children: [
              Expanded(
                  child: MyContainer(
                paddingAll: 0,
                height: 46,
                color: contentTheme.secondary.withAlpha(30),
                borderRadiusAll: 12,
                onTap: () {
                  controller.pickDate();
                  setState(() {});
                },
                child: Padding(
                  padding: MySpacing.all(12),
                  child: MyText.bodyMedium(
                    controller.selectedDate != null
                        ? dateFormatter.format(controller.selectedDate!)
                        : dateFormatter.format(DateTime.now()).toString(),
                    fontWeight: 600,
                  ),
                ),
              )),
              MySpacing.width(12),
              Expanded(
                child: EmployeeCommonTextField(
                  hintText: "Experience",
                  controller: controller.experienceTE,
                ),
              ),
            ],
          ),
          MySpacing.height(16),
          MyContainer(
            paddingAll: 0,
            height: 46,
            color: contentTheme.secondary.withAlpha(30),
            borderRadiusAll: 12,
            child: Center(
              child: DropdownButtonFormField<Designation>(
                  dropdownColor: contentTheme.background,
                  focusColor: contentTheme.background,
                  borderRadius: BorderRadius.circular(12),
                  padding: MySpacing.y(4),
                  items: Designation.values
                      .map((designation) => DropdownMenuItem<Designation>(
                          onTap: () {
                            controller.onSelectDesignation(designation);
                          },
                          value: designation,
                          child: MyText.labelMedium(
                            designation.name.capitalize!,
                          )))
                      .toList(),
                  icon: Icon(
                    LucideIcons.chevron_down,
                    size: 20,
                  ),
                  decoration: InputDecoration(
                      hintText: "Select Designation",
                      hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      contentPadding: MySpacing.all(12),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  onChanged: controller.basicValidator
                      .onChanged<Object?>('designation'),
                  validator: controller.basicValidator
                      .getValidation<Designation?>('designation')),
            ),
          ),
          MySpacing.height(12),
          MyContainer(
            paddingAll: 0,
            height: 36,
            borderRadiusAll: 8,
            color: contentTheme.primary,
            onTap: () => controller.addData(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.plus,
                  color: contentTheme.onPrimary,
                  size: 20,
                ),
                MySpacing.width(8),
                MyText.bodyMedium(
                  "Add Data",
                  fontWeight: 600,
                  color: theme.colorScheme.onPrimary,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildEmployeeIndex(IconData icon, Color iconColor, String title,
      String dataIndex, Color color) {
    return Row(
      children: [
        MyContainer(
          height: 32,
          width: 32,
          paddingAll: 0,
          color: iconColor.withAlpha(36),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Icon(
            icon,
            size: 16,
            color: iconColor,
          ),
        ),
        MySpacing.width(12),
        MyText.titleMedium(title, fontWeight: 600),
        Spacer(),
        MyContainer(
          paddingAll: 0,
          height: 22,
          width: 22,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: color.withAlpha(36),
          child: Center(
              child: MyText.bodyMedium(
            dataIndex,
            fontWeight: 600,
            color: color,
          )),
        )
      ],
    );
  }

  Widget buildEmployeeData() {
    return DataTable(
      sortColumnIndex: 1,
      sortAscending: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      headingRowColor:
          WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
      dataRowMaxHeight: 60,
      showBottomBorder: false,
      columns: [
        DataColumn(
          label: MyText.labelLarge(
            'Name',
            color: contentTheme.primary,
          ),
        ),
        DataColumn(
          label: MyText.labelLarge(
            'Designation',
            color: contentTheme.primary,
          ),
        ),
        DataColumn(
          label: MyText.labelLarge(
            'Phone No.',
            color: contentTheme.primary,
          ),
        ),
        DataColumn(
            label: MyText.labelLarge(
          'Experience',
          color: contentTheme.primary,
        )),
        DataColumn(
            label: MyText.labelLarge(
          'Joining Date',
          color: contentTheme.primary,
        )),
        DataColumn(
            label: MyText.labelLarge(
          'Actions',
          color: contentTheme.primary,
        )),
      ],
      rows: controller.employee
          .mapIndexed(
            (index, data) => DataRow(
              cells: [
                DataCell(Row(
                  children: [
                    MyContainer.rounded(
                      paddingAll: 0,
                      height: 32,
                      width: 32,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(
                          Images.avatars[index % Images.avatars.length]),
                    ),
                    MySpacing.width(8),
                    MyText.bodyMedium(data.name!, fontWeight: 600),
                  ],
                )),
                DataCell(MyText.bodyMedium(data.designation!, fontWeight: 600)),
                DataCell(MyText.bodyMedium("+${data.phoneNumber!}",
                    fontWeight: 600)),
                DataCell(MyText.bodyMedium("${data.experience!} Years",
                    fontWeight: 600)),
                DataCell(MyText.bodyMedium(
                    data.joiningDate == null
                        ? "${Utils.getDateStringFromDateTime(DateTime.now())}"
                        : "${Utils.getDateStringFromDateTime(data.joiningDate!, showMonthShort: true)}",
                    fontWeight: 600)),
                DataCell(Row(
                  children: [
                    MyContainer(
                      paddingAll: 0,
                      height: 28,
                      width: 28,
                      color: contentTheme.primary.withAlpha(36),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onTap: () {},
                      child: Icon(
                        LucideIcons.pencil,
                        size: 16,
                        color: contentTheme.primary,
                      ),
                    ),
                    MySpacing.width(8),
                    MyContainer(
                      paddingAll: 0,
                      height: 28,
                      width: 28,
                      color: contentTheme.danger.withAlpha(36),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onTap: () => controller.removeData(index),
                      child: Icon(
                        LucideIcons.trash_2,
                        size: 16,
                        color: contentTheme.danger,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          )
          .toList(),
    );
  }
}

import 'package:flatten/controllers/apps/files/file_manager_controller.dart';
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
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_progress_bar.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FileManagerPage extends StatefulWidget {
  const FileManagerPage({super.key});

  @override
  State<FileManagerPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FileManagerPage> with SingleTickerProviderStateMixin, UIMixin {
  late FileManagerController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FileManagerController());
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
                    MyText.titleMedium("File Manager", fontWeight: 600),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "Extra Pages"),
                        MyBreadcrumbItem(name: "File Manager", active: true),
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
                      sizes: "xxl-2 xl-3 lg-4  md-4 sm-12",
                      child: MyCard(
                        shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
                        paddingAll: 0,
                        child: Padding(
                          padding: MySpacing.all(flexSpacing),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyButton(
                                onPressed: () {},
                                elevation: 0,
                                padding: MySpacing.xy(20, 16),
                                backgroundColor: contentTheme.primary,
                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(LucideIcons.plus),
                                    MySpacing.width(8),
                                    MyText.bodySmall('Create New', color: contentTheme.onPrimary),
                                  ],
                                ),
                              ),
                              MySpacing.height(24),
                              buildCreateNew("My File", LucideIcons.folder),
                              MySpacing.height(16),
                              buildCreateNew("Google Drive", LucideIcons.file_image),
                              MySpacing.height(16),
                              buildCreateNew("Share With Me", LucideIcons.folder),
                              MySpacing.height(16),
                              buildCreateNew("Recent", LucideIcons.history),
                              MySpacing.height(16),
                              buildCreateNew("Starred", LucideIcons.star),
                              MySpacing.height(16),
                              buildCreateNew("Delete File", LucideIcons.trash_2),
                              MySpacing.height(40),
                              MyText.bodySmall("STORAGE", fontWeight: 700),
                              MySpacing.height(14),
                              MyProgressBar(
                                width: 200,
                                progress: 0.5,
                                height: 3,
                                radius: 4,
                                inactiveColor: theme.dividerColor,
                                activeColor: colorScheme.primary,
                              ),
                              MySpacing.height(14),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(text: '7.02 GB ', style: MyTextStyle.bodyMedium(fontWeight: 700)),
                                    TextSpan(text: '(46%) of  '),
                                    TextSpan(text: '15 GB', style: MyTextStyle.bodyMedium(fontWeight: 700)),
                                    TextSpan(text: ' used'),
                                  ],
                                ),
                              ),
                              MySpacing.height(20),
                              Center(
                                child: MyButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  padding: MySpacing.xy(20, 16),
                                  borderColor: contentTheme.primary,
                                  backgroundColor: contentTheme.primary.withAlpha(28),
                                  splashColor: contentTheme.primary.withAlpha(28),
                                  borderRadiusAll: 20,
                                  child: MyText.bodyMedium('UPGRADE', color: contentTheme.primary, fontWeight: 600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MyFlexItem(
                      sizes: "xxl-10 xl-9 lg-8 md-8 sm-12",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyCard(
                            shadow: MyShadow(elevation: 0.5, position: MyShadowPosition.bottom),
                            paddingAll: 22,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    MyContainer.none(
                                      width: 250,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: contentTheme.primary.withValues(alpha: 0.08),
                                          prefixIcon: Icon(LucideIcons.search, size: 18, color: contentTheme.primary),
                                          isDense: true,
                                          hintText: "Search Files",
                                          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
                                          contentPadding: MySpacing.horizontal(20),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        MyContainer.bordered(paddingAll: 5, child: Icon(LucideIcons.list, size: 18)),
                                        MySpacing.width(6),
                                        MyContainer.bordered(paddingAll: 5, child: Icon(LucideIcons.layout_template, size: 18)),
                                        MySpacing.width(6),
                                        MyContainer.bordered(paddingAll: 5, child: Icon(LucideIcons.circle_alert, size: 18)),
                                      ],
                                    ),
                                  ],
                                ),
                                MySpacing.height(16),
                                MyText.bodyMedium("Quick Access", fontWeight: 600),
                                MySpacing.height(16),
                                Wrap(
                                  spacing: 16,
                                  runSpacing: 16,
                                  children: [
                                    buildFile(LucideIcons.folder, "Flatten - Zip", 458631),
                                    buildFile(LucideIcons.folder_archive, "Compile Version", 1458631),
                                    buildFile(LucideIcons.folder_cog, "My Admin", 4358631),
                                    buildFile(LucideIcons.folder_lock, "Documentation.pdf", 4586531),
                                    buildFile(LucideIcons.folder_kanban, "License-details.pdf", 8456312),
                                    buildFile(LucideIcons.folder, "Purchase Verification", 47856),
                                    buildFile(LucideIcons.folder_archive, "Flatten Integrations", 125789),
                                  ],
                                ),
                                MySpacing.height(18),
                                MyText.bodyMedium("Recent", fontWeight: 600),
                                MySpacing.height(18),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: MyContainer.none(
                                    borderRadiusAll: 4,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: DataTable(
                                      sortAscending: true,
                                      onSelectAll: (_) => {},
                                      headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                                      // dataRowHeight: 60,
                                      dataRowMaxHeight: 60,
                                      showBottomBorder: false,
                                      columns: [
                                        DataColumn(label: MyText.labelLarge("Name", color: contentTheme.primary)),
                                        DataColumn(label: MyText.labelLarge("Last Modified", color: contentTheme.primary)),
                                        DataColumn(label: MyText.labelLarge("Size", color: contentTheme.primary)),
                                        DataColumn(label: MyText.labelLarge("Owner", color: contentTheme.primary)),
                                        DataColumn(label: MyText.labelLarge("Members", color: contentTheme.primary)),
                                        DataColumn(label: MyText.labelLarge("Action", color: contentTheme.primary)),
                                      ],
                                      rows: [
                                        buildDataRows(
                                          "Flutter Design Files",
                                          DateTime.utc(2023, 1, 25),
                                          "Andrew",
                                          134217728,
                                          "Danielle Thompson",
                                          LucideIcons.folder,
                                          [Images.avatars[0], Images.avatars[1], Images.avatars[2], Images.avatars[3]],
                                        ),
                                        buildDataRows(
                                          "Sketch File",
                                          DateTime.utc(2020, 2, 13),
                                          "Getappui",
                                          546308096,
                                          "Coder Themes",
                                          LucideIcons.file,
                                          [Images.avatars[0], Images.avatars[2], Images.avatars[3]],
                                        ),
                                        buildDataRows(
                                          "Flatten Requirement.pdf",
                                          DateTime.utc(2020, 2, 13),
                                          "Alejandro",
                                          7549747,
                                          "Gary Coley",
                                          LucideIcons.file_text,
                                          [Images.avatars[5], Images.avatars[4], Images.avatars[1]],
                                        ),
                                        buildDataRows(
                                          "Wireframes",
                                          DateTime.utc(2023, 1, 25),
                                          "Dunkle",
                                          56832819,
                                          "Jasper Rigg",
                                          LucideIcons.folder,
                                          [Images.avatars[0], Images.avatars[1], Images.avatars[2], Images.avatars[3]],
                                        ),
                                        buildDataRows(
                                          "Documentation.docs",
                                          DateTime.utc(2020, 2, 13),
                                          "Justin",
                                          8703180,
                                          "Cooper Sharwood",
                                          LucideIcons.file_text,
                                          [Images.avatars[4], Images.avatars[1]],
                                        ),
                                      ],
                                    ),
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

  Row buildCreateNew(String fileName, IconData icon) {
    return Row(children: [Icon(icon, size: 24), MySpacing.width(16), MyText.bodyMedium(fileName, fontWeight: 600)]);
  }

  DataRow buildDataRows(String name, DateTime modifyAt, String author, int bytes, String owner, IconData? icon, List<String> images) {
    return DataRow(
      cells: [
        DataCell(SizedBox(width: 250, child: Row(children: [Icon(icon, size: 22), MySpacing.width(16), MyText.bodyMedium(name, fontWeight: 600)]))),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.bodyMedium('${Utils.getDateStringFromDateTime(modifyAt, showMonthShort: true)}'),
              MyText.bodySmall("by $author", muted: true),
            ],
          ),
        ),
        DataCell(MyText.bodyMedium(Utils.getStorageStringFromByte(bytes))),
        DataCell(MyText.bodyMedium(owner)),
        DataCell(
          SizedBox(
            width: 130,
            child: Stack(
              alignment: Alignment.centerRight,
              children: images
                  .mapIndexed(
                    (index, image) => Positioned(
                      left: (18 + (20 * index)).toDouble(),
                      child: MyContainer.rounded(bordered: true, paddingAll: 0, child: Image.asset(image, height: 28, width: 28, fit: BoxFit.cover)),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        DataCell(
          MyContainer.none(
            paddingAll: 8,
            borderRadiusAll: 5,
            color: contentTheme.primary.withValues(alpha: 0.05),
            child: PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(children: [Icon(LucideIcons.share, size: 16), MySpacing.width(8), MyText.bodySmall("Share")]),
                ),
                PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(children: [Icon(LucideIcons.link, size: 16), MySpacing.width(8), MyText.bodySmall("Get Sharable Link")]),
                ),
                PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(children: [Icon(LucideIcons.pencil, size: 16), MySpacing.width(8), MyText.bodySmall("Rename")]),
                ),
                PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(children: [Icon(LucideIcons.download, size: 16), MySpacing.width(8), MyText.bodySmall("Download")]),
                ),
                PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(children: [Icon(LucideIcons.trash, size: 16), MySpacing.width(8), MyText.bodySmall("Remove")]),
                ),
              ],
              child: Icon(LucideIcons.ellipsis, size: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFile(IconData icon, String name, int bytes) {
    return MyContainer.bordered(
      paddingAll: 8,
      width: 220,
      child: Row(
        children: [
          MyContainer(color: contentTheme.onBackground.withAlpha(28), paddingAll: 8, child: Icon(icon, size: 20)),
          MySpacing.width(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.bodyMedium(name, maxLines: 1, overflow: TextOverflow.ellipsis, fontWeight: 600),
                MyText.bodySmall(Utils.getStorageStringFromByte(bytes)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

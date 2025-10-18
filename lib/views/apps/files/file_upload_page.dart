import 'package:flatten/controllers/apps/files/file_upload_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_dotted_line.dart';
import 'package:flatten/helpers/widgets/my_list_extension.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});

  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late FileUploadController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(FileUploadController());
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
                      "File Upload",
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: "UI"),
                        MyBreadcrumbItem(name: "File Upload", active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard(
                  shadow: MyShadow(
                      elevation: 0.75, position: MyShadowPosition.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText.bodyMedium(
                        "Please upload any file to see a previews",
                        fontSize: 12,
                        fontWeight: 600,
                      ),
                      MySpacing.height(16),
                      InkWell(
                        onTap: controller.pickFile,
                        child: MyDottedLine(
                          strokeWidth: 0.2,
                          color: contentTheme.onBackground,
                          corner: MyDottedLineCorner(
                            leftBottomCorner: 2,
                            leftTopCorner: 2,
                            rightBottomCorner: 2,
                            rightTopCorner: 2,
                          ),
                          child: Center(
                            heightFactor: 1.5,
                            child: Padding(
                              padding: MySpacing.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(LucideIcons.cloud_upload, size: 22),
                                  MyContainer(
                                    width: 340,
                                    alignment: Alignment.center,
                                    paddingAll: 0,
                                    child: MyText.titleMedium(
                                      "Drop files here or click to upload.",
                                      fontWeight: 600,
                                      muted: true,
                                      fontSize: 18,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  MyContainer(
                                    alignment: Alignment.center,
                                    width: 610,
                                    child: MyText.titleMedium(
                                      "(This is just a demo dropzone. Selected files are not actually uploaded.)",
                                      muted: true,
                                      fontWeight: 500,
                                      fontSize: 16,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (controller.files.isNotEmpty) ...[
                        MySpacing.height(16),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: controller.files
                              .mapIndexed((index, file) => MyContainer.bordered(
                                    paddingAll: 8,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MyContainer(
                                          color: contentTheme.onBackground
                                              .withAlpha(28),
                                          paddingAll: 8,
                                          child: Icon(
                                            LucideIcons.file,
                                            size: 20,
                                          ),
                                        ),
                                        MySpacing.width(16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            MyText.bodyMedium(
                                              file.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: 600,
                                            ),
                                            MyText.bodySmall(
                                                Utils.getStorageStringFromByte(
                                                    file.bytes?.length ?? 0)),
                                          ],
                                        ),
                                        MySpacing.width(32),
                                        MyContainer.roundBordered(
                                          onTap: () =>
                                              controller.removeFile(file),
                                          paddingAll: 4,
                                          child: Icon(
                                            LucideIcons.x,
                                            size: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        )
                      ],
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

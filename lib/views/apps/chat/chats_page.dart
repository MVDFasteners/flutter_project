import 'package:flatten/controllers/apps/chat/chats_controller.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/utils.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb.dart';
import 'package:flatten/helpers/widgets/my_breadcrumb_item.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_flex.dart';
import 'package:flatten/helpers/widgets/my_flex_item.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/views/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage>
    with SingleTickerProviderStateMixin, UIMixin {
  late ChatsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChatsController());
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
                      "Chat",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Apps'),
                        MyBreadcrumbItem(name: 'Chat', active: true),
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
                      child: buildProfileDetail(),
                    ),
                    MyFlexItem(
                      sizes: "lg-8",
                      child: messages(),
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

  Widget buildProfileDetail() {
    return MyContainer(
      paddingAll: 0,
      borderRadiusAll: 8,
      child: Padding(
        padding: MySpacing.all(flexSpacing),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyContainer.rounded(
                  height: 40,
                  width: 40,
                  paddingAll: 0,
                  child: Image.asset(
                    Images.avatars[0],
                    fit: BoxFit.cover,
                  ),
                ),
                MySpacing.width(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText.labelLarge(
                        "Den",
                      ),
                      MySpacing.height(4),
                      Row(
                        children: [
                          MyContainer.rounded(
                            height: 10,
                            width: 10,
                            color: contentTheme.primary,
                          ),
                          MySpacing.width(8),
                          MyText.bodySmall(
                            "Online",
                            muted: true,
                            fontWeight: 400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.settings),
              ],
            ),
            MySpacing.height(22),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: contentTheme.primary.withValues(alpha: 0.12),
                prefixIcon: Icon(
                  LucideIcons.search,
                  color: contentTheme.primary,
                ),
                hintText: "People,groups & messages...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding: MySpacing.all(16),
              ),
            ),
            MySpacing.height(22),
            MyText.titleMedium(
              "GROUP CHAT",
              color: contentTheme.title,
              muted: true,
              fontWeight: 600,
            ),
            MySpacing.height(20),
            Row(
              children: [
                Icon(
                  LucideIcons.circle,
                  color: contentTheme.success,
                  size: 16,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  "App Development",
                ),
              ],
            ),
            MySpacing.height(8),
            Row(
              children: [
                Icon(
                  LucideIcons.circle,
                  color: contentTheme.warning,
                  size: 16,
                ),
                MySpacing.width(8),
                MyText.bodySmall(
                  "Office WOrk",
                ),
              ],
            ),
            MySpacing.height(22),
            MyText.titleMedium(
              "CONTACT",
              color: contentTheme.title,
              muted: true,
              fontWeight: 600,
            ),
            MySpacing.height(20),
            SizedBox(
              height: 400,
              child: ListView.separated(
                primary: true,
                shrinkWrap: true,
                itemCount: controller.filteredChats.length,
                itemBuilder: (context, index) {
                  return MyButton(
                    onPressed: () {
                      controller.onChangeChat(controller.filteredChats[index]);
                    },
                    elevation: 0,
                    borderRadiusAll: 8,
                    padding: MySpacing.xy(12, 16),
                    backgroundColor: theme.colorScheme.surface.withAlpha(5),
                    splashColor: theme.colorScheme.onSurface.withAlpha(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyContainer.rounded(
                          height: 40,
                          width: 40,
                          paddingAll: 0,
                          child: Image.asset(
                            controller.filteredChats[index].image,
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        MySpacing.width(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText.labelLarge(
                                controller.filteredChats[index].firstName,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 200,
                                child: MyText.bodySmall(
                                  controller.filteredChats[index].messages
                                          .lastOrNull?.message ??
                                      "No new Messages",
                                  muted: true,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: 400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            if (controller
                                    .filteredChats[index].messages.lastOrNull !=
                                null)
                              MyText.bodySmall(
                                '${Utils.getTimeStringFromDateTime(
                                  controller.filteredChats[index].messages
                                      .lastOrNull!.sendAt,
                                  showSecond: false,
                                )}',
                                muted: true,
                                fontWeight: 600,
                              ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return MySpacing.height(20);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages() {
    return MyContainer(
      borderRadiusAll: 8,
      child: controller.selectedChat != null
          ? Column(
              children: [
                Row(
                  children: [
                    MyContainer.rounded(
                      height: 40,
                      width: 40,
                      paddingAll: 0,
                      child: Image.asset(
                        Images.avatars[1],
                        fit: BoxFit.cover,
                      ),
                    ),
                    MySpacing.width(16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.labelLarge(
                            "Lurette",
                          ),
                          MySpacing.height(4),
                          Row(
                            children: [
                              MyContainer.rounded(
                                height: 10,
                                width: 10,
                                color: contentTheme.primary,
                              ),
                              MySpacing.width(8),
                              MyText.bodySmall(
                                "Online",
                                fontSize: 12,
                                muted: true,
                                fontWeight: 400,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(LucideIcons.phone, size: 18),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(LucideIcons.video, size: 18),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(LucideIcons.user_plus, size: 18),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(LucideIcons.trash, size: 18),
                    ),
                  ],
                ),
                Divider(),
                MySpacing.height(12),
                SizedBox(
                  height: 560,
                  child: ListView.separated(
                    controller: controller.scrollController,
                    itemCount: (controller.selectedChat?.messages ?? []).length,
                    separatorBuilder: (context, index) => SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      final message =
                          (controller.selectedChat?.messages ?? [])[index];
                      final isSent = message.fromMe == true;
                      final theme = isSent
                          ? contentTheme.primary
                          : contentTheme.secondary;

                      return Row(
                        mainAxisAlignment: isSent
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isSent)
                            Column(
                              children: [
                                MyContainer.rounded(
                                  height: 32,
                                  width: 32,
                                  paddingAll: 0,
                                  child: Image.asset(
                                    controller.selectedChat!.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                MySpacing.height(4),
                                MyText.bodySmall(
                                  '${Utils.getTimeStringFromDateTime(
                                    message.sendAt,
                                    showSecond: false,
                                  )}',
                                  fontSize: 8,
                                  muted: true,
                                  fontWeight: 600,
                                ),
                              ],
                            ),
                          MySpacing.width(12),
                          Expanded(
                            child: Wrap(
                              alignment: isSent
                                  ? WrapAlignment.end
                                  : WrapAlignment.start,
                              children: [
                                MyContainer(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                    left: isSent
                                        ? MediaQuery.of(context).size.width *
                                            0.20
                                        : 0,
                                    right: isSent
                                        ? 0
                                        : MediaQuery.of(context).size.width *
                                            0.20,
                                  ),
                                  color: theme.withAlpha(30),
                                  borderRadiusAll: 8,
                                  child: MyText.bodyMedium(
                                    message.message,
                                    fontWeight: 600,
                                    color: isSent
                                        ? contentTheme.primary
                                        : contentTheme.secondary,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MySpacing.width(12),
                          if (controller.selectedChat != null && isSent)
                            Column(
                              children: [
                                MyContainer.rounded(
                                  height: 32,
                                  width: 32,
                                  paddingAll: 0,
                                  child: Image.asset(
                                    Images.avatars[6],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                MySpacing.height(4),
                                MyText.bodySmall(
                                  '${Utils.getTimeStringFromDateTime(
                                    message.sendAt,
                                    showSecond: false,
                                  )}',
                                  fontSize: 8,
                                  muted: true,
                                  fontWeight: 600,
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: MyContainer(
                    color: contentTheme.primary.withAlpha(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.messageController,
                            autocorrect: false,
                            style: MyTextStyle.bodySmall(),
                            decoration: InputDecoration(
                              hintText: "Type message here",
                              hintStyle: MyTextStyle.bodySmall(xMuted: true),
                              border: outlineInputBorder,
                              enabledBorder: outlineInputBorder,
                              focusedBorder: focusedInputBorder,
                              contentPadding: MySpacing.xy(16, 16),
                              isCollapsed: true,
                            ),
                          ),
                        ),
                        MySpacing.width(16),
                        InkWell(
                          onTap: () {
                            controller.sendMessage();
                          },
                          child: const Icon(
                            LucideIcons.send,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : SizedBox(
              height: 705,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MySpacing.height(12),
                    MyText.titleLarge(
                      "Chat isn't selected \nPlease Select a chat",
                      fontWeight: 600,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

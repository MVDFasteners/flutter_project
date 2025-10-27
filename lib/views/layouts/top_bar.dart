import 'dart:convert';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/services/localizations/language.dart';
import 'package:flatten/helpers/theme/app_notifier.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/theme/theme_customizer.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_dashed_divider.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/helpers/widgets/my_text_style.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/user.dart';
import 'package:flatten/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopBar extends StatefulWidget {
  final Widget? anyWidget;

  const TopBar({super.key, this.anyWidget});

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar>
    with SingleTickerProviderStateMixin, UIMixin {
  Function? languageHideFn;
  late LoginController controller;

  // final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: controller,
      builder: (controller) {
        return MyCard(
          shadow: MyShadow(
            position: MyShadowPosition.bottomRight,
            elevation: 0.5,
          ),
          height: 60,
          borderRadiusAll: 0,
          padding: MySpacing.x(24),
          color: topBarTheme.background.withAlpha(246),
          child: Row(
            children: [
              Row(
                children: [
                  InkWell(
                    splashColor: colorScheme.onSurface,
                    highlightColor: colorScheme.onSurface,
                    onTap: () {
                      ThemeCustomizer.toggleLeftBarCondensed();
                    },
                    child: Icon(Icons.menu, color: topBarTheme.onBackground),
                  ),
                  MySpacing.width(24),
                  widget.anyWidget ?? Container(),
                  widget.anyWidget != null ? SizedBox(width: 10) : Container(),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      maxLines: 1,
                      style: MyTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                        hintText: "search".trim(),
                        hintStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: outlineInputBorder,
                        enabledBorder: outlineInputBorder,
                        focusedBorder: focusedInputBorder,
                        prefixIcon: Align(
                          alignment: Alignment.center,
                          child: Icon(LucideIcons.search, size: 14),
                        ),
                        prefixIconConstraints: BoxConstraints(
                          minWidth: 36,
                          maxWidth: 36,
                          minHeight: 32,
                          maxHeight: 32,
                        ),
                        contentPadding: MySpacing.xy(16, 12),
                        isCollapsed: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        ThemeCustomizer.setTheme(
                          ThemeCustomizer.instance.theme == ThemeMode.dark
                              ? ThemeMode.light
                              : ThemeMode.dark,
                        );
                      },
                      child: Icon(
                        ThemeCustomizer.instance.theme == ThemeMode.dark
                            ? LucideIcons.sun
                            : LucideIcons.moon,
                        size: 18,
                        color: topBarTheme.onBackground,
                      ),
                    ),
                    MySpacing.width(12),
                    CustomPopupMenu(
                      backdrop: true,
                      hideFn: (hide) => languageHideFn = hide,
                      onChange: (_) {},
                      offsetX: -36,
                      menu: Padding(
                        padding: MySpacing.xy(8, 8),
                        child: Center(
                          child: ClipRRect(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            borderRadius: BorderRadius.circular(2),

                            child: Image.asset(
                              'assets/lang/${ThemeCustomizer.instance.currentLanguage.locale.languageCode}.jpg',
                              width: 24,
                              height: 18,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      menuBuilder: (_) =>
                          buildLanguageSelector(controller.userModel),
                    ),
                    MySpacing.width(6),
                    CustomPopupMenu(
                      backdrop: true,
                      onChange: (_) {},
                      offsetX: -120,
                      menu: Padding(
                        padding: MySpacing.xy(8, 8),
                        child: Center(child: Icon(LucideIcons.bell, size: 18)),
                      ),
                      menuBuilder: (_) => buildNotifications(),
                    ),
                    MySpacing.width(4),
                    CustomPopupMenu(
                      backdrop: true,
                      onChange: (_) {},
                      offsetX: -60,
                      offsetY: 8,
                      menu: Padding(
                        padding: MySpacing.xy(8, 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MyContainer.rounded(
                              paddingAll: 0,
                              child: ClipOval(
                                child: controller.userImage != null
                                    ? Image.memory(
                                        base64Decode(
                                          controller.userImage!.split(',')[1],
                                        ),
                                        width: 100, // diameter
                                        height: 100,
                                        fit: BoxFit
                                            .cover, // Use contain to show full image
                                      )
                                    : Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[200],
                                        child: Icon(Icons.person, size: 50),
                                      ),
                              ),
                            ),
                            MySpacing.width(8),
                            MyText.labelLarge(
                              controller.userModel.fullName ?? "",
                            ),
                          ],
                        ),
                      ),
                      menuBuilder: (_) => buildAccountMenu(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildLanguageSelector(UserModel user) {
    return MyContainer.bordered(
      padding: MySpacing.xy(8, 8),
      width: 125,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Language.languages
            .map(
              (language) => MyButton.text(
                padding: MySpacing.xy(8, 4),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                splashColor: contentTheme.onBackground.withAlpha(20),
                onPressed: () async {
                  languageHideFn?.call();
                  // Language.changeLanguage(language);
                  await Provider.of<AppNotifier>(
                    context,
                    listen: false,
                  ).changeLanguage(language, notify: true);
                  ThemeCustomizer.notify();
                  setState(() {});
                },
                child: Row(
                  children: [
                    ClipRRect(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(2),
                      child:
                      user.image != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                "http://192.168.1.143:8000${user.image!}",
                              ),
                            )
                          :
                      const CircleAvatar(
                              radius: 50,
                              child: Icon(Icons.person, size: 50),
                            ),

                      // child: Image.asset(
                      //   'assets/lang/${language.locale.languageCode}.jpg',
                      //   width: 18,
                      //   height: 14,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    MySpacing.width(8),
                    MyText.labelMedium(language.languageName),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildNotifications() {
    Widget buildNotification(String title, String description) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.labelLarge(title),
          MySpacing.height(4),
          MyText.bodySmall(description),
        ],
      );
    }

    return MyContainer.bordered(
      paddingAll: 0,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(16, 12),
            child: MyText.titleMedium("Notification", fontWeight: 600),
          ),
          MyDashedDivider(
            height: 1,
            color: theme.dividerColor,
            dashSpace: 4,
            dashWidth: 6,
          ),
          Padding(
            padding: MySpacing.xy(16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildNotification(
                  "Your order is received",
                  "Order #1232 is ready to deliver",
                ),
                MySpacing.height(12),
                buildNotification(
                  "Account Security ",
                  "Your account password changed 1 hour ago",
                ),
              ],
            ),
          ),
          MyDashedDivider(
            height: 1,
            color: theme.dividerColor,
            dashSpace: 4,
            dashWidth: 6,
          ),
          Padding(
            padding: MySpacing.xy(16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.primary.withAlpha(28),
                  child: MyText.labelSmall(
                    "View All",
                    color: contentTheme.primary,
                  ),
                ),
                MyButton.text(
                  onPressed: () {},
                  splashColor: contentTheme.danger.withAlpha(28),
                  child: MyText.labelSmall("Clear", color: contentTheme.danger),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAccountMenu() {
    return MyContainer.bordered(
      paddingAll: 0,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: MySpacing.xy(8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyButton(
                  onPressed: () => {},
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.user,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium("My Account", fontWeight: 600),
                    ],
                  ),
                ),
                MySpacing.height(4),
                MyButton(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => {},
                  borderRadiusAll: AppStyle.buttonRadius.medium,
                  padding: MySpacing.xy(8, 4),
                  splashColor: colorScheme.onSurface.withAlpha(20),
                  backgroundColor: Colors.transparent,
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.settings,
                        size: 14,
                        color: contentTheme.onBackground,
                      ),
                      MySpacing.width(8),
                      MyText.labelMedium("Settings", fontWeight: 600),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1),
          Padding(
            padding: MySpacing.xy(8, 8),
            child: MyButton(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () => {},
              borderRadiusAll: AppStyle.buttonRadius.medium,
              padding: MySpacing.xy(8, 4),
              splashColor: contentTheme.danger.withAlpha(28),
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    LucideIcons.log_out,
                    size: 14,
                    color: contentTheme.danger,
                  ),
                  MySpacing.width(8),
                  MyText.labelMedium(
                    "Log out",
                    fontWeight: 600,
                    color: contentTheme.danger,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

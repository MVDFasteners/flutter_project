import 'dart:convert';

import 'package:flatten/app_constant.dart';
import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/controllers/layouts/layout_controller.dart';
import 'package:flatten/helpers/theme/admin_theme.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/theme/theme_customizer.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_dashed_divider.dart';
import 'package:flatten/helpers/widgets/my_responsiv.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/models/user.dart';
import 'package:flatten/myPages/login_new_screen.dart';
import 'package:flatten/views/auth/login.dart';
import 'package:flatten/views/layouts/left_bar.dart';
import 'package:flatten/views/layouts/right_bar.dart';
import 'package:flatten/views/layouts/top_bar.dart';
import 'package:flatten/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class Layout extends StatelessWidget {
  final Widget? child;
  final Widget? anyWidget;
  final bool? scrollNeed;
  final Widget? floatingAction;
  final Widget? bottomBar;
  final Widget? leadingWidget;

  final LayoutController controller = LayoutController();
  final LoginController loginController = Get.put(LoginController());

  final topBarTheme = AdminTheme.theme.topBarTheme;
  final contentTheme = AdminTheme.theme.contentTheme;

  Layout({
    super.key,
    this.child,
    this.leadingWidget,
    this.anyWidget,
    this.scrollNeed = true,
    this.floatingAction,
    this.bottomBar,
  });

  @override
  Widget build(BuildContext context) {
    return MyResponsive(
      builder: (BuildContext context, _, screenMT) {
        return GetBuilder(
          init: controller,
          builder: (controller) {
            if (screenMT.isMobile || screenMT.isTablet) {
              return mobileScreen(scrollNeed: scrollNeed, context: context);
            } else {
              return largeScreen();
            }
          },
        );
      },
    );
  }

  Widget mobileScreen({
    bool? scrollNeed = true,
    required BuildContext context,
  }) {
    return Scaffold(
      floatingActionButton: floatingAction,
      key: controller.scaffoldKey,
      bottomNavigationBar: bottomBar,
      appBar: AppBar(
        leading: leadingWidget,
        elevation: 0,
        actions: [
          if (anyWidget != null) anyWidget!,
          if (anyWidget != null) SizedBox(width: 20),
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
              size: 24,
              color: topBarTheme.onBackground,
            ),
          ),
          MySpacing.width(8),
          // CustomPopupMenu(
          //   backdrop: true,
          //   onChange: (_) {},
          //   offsetX: -180,
          //   menu: Padding(
          //     padding: MySpacing.xy(8, 8),
          //     child: Center(child: Icon(LucideIcons.bell, size: 18)),
          //   ),
          //   menuBuilder: (_) => buildNotifications(),
          // ),
          // MySpacing.width(8),
          CustomPopupMenu(
            backdrop: true,
            onChange: (_) {},
            offsetX: -90,
            offsetY: 4,
            menu: Padding(
              padding: MySpacing.xy(8, 8),
              child: InkWell(
                onTap: () async {
                  await _showProfile(context);
                },
                child: MyContainer.rounded(
                  paddingAll: 0,
                  child: loginController.userImage != null
                      ? Image.memory(
                          base64Decode(
                            loginController.userImage!.split(',')[1],
                          ),
                          width: 50, // diameter
                          height: 100,
                          fit: BoxFit.fitHeight,
                        )
                      : Container(
                          width: 50,
                          height: 100,
                          color: Colors.grey[200],
                          child: Icon(Icons.person, size: 50),
                        ),

                  // Image.asset(
                  //   Images.avatars[0],
                  //   height: 28,
                  //   width: 28,
                  //   fit: BoxFit.cover,
                  // ),
                ),
              ),
            ),
            menuBuilder: (_) => buildAccountMenu(context),
          ),
          MySpacing.width(20),
        ],
      ),
      // endDrawer: RightBar(),
      // extendBodyBehindAppBar: true,
      // appBar: TopBar(
      drawer: LeftBar(),
      body: scrollNeed == null || scrollNeed == true
          ? SingleChildScrollView(key: controller.scrollKey, child: child)
          : child,
    );
  }

  Widget largeScreen() {
    return Scaffold(
      floatingActionButton: floatingAction,
      key: controller.scaffoldKey,
      endDrawer: RightBar(),
      body: Row(
        children: [
          LeftBar(isCondensed: ThemeCustomizer.instance.leftBarCondensed),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: scrollNeed == null || scrollNeed == true
                      ? SingleChildScrollView(
                          padding: MySpacing.fromLTRB(
                            0,
                            58 + flexSpacing,
                            0,
                            flexSpacing,
                          ),
                          key: controller.scrollKey,
                          child: child,
                        )
                      : Container(
                          padding: MySpacing.fromLTRB(
                            0,
                            58 + flexSpacing,
                            0,
                            flexSpacing,
                          ),
                          child: child,
                        ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: TopBar(anyWidget: anyWidget),
                ),
              ],
            ),
          ),
          // Expanded(
          //     child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     TopBar(),
          //     Expanded(
          //         child: SingleChildScrollView(
          //       padding: MySpacing.y(flexSpacing),
          //       key: controller.scrollKey,
          //       child: child,
          //     )),
          //   ],
          // ))
        ],
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

  Widget buildAccountMenu(context) {
    return Container();
    //   MyContainer.bordered(
    //   paddingAll: 0,
    //   width: 150,
    //   child: Padding(
    //     padding: MySpacing.xy(8, 8),
    //     child: Column(
    //       children: [
    //         MyButton(
    //           onPressed: () async {
    //             await _showProfile(context);
    //           },
    //           child: MyText.labelMedium(
    //             "View Profile",
    //             fontWeight: 600,
    //             color: Colors.white,
    //           ),
    //         ),
    //         MyButton(
    //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //           onPressed: () async {
    //             await loginController.userLogOut();
    //             Navigator.pushAndRemoveUntil(
    //               context,
    //               MaterialPageRoute(builder: (context) => LoginPageNew()),
    //               (Route<dynamic> route) =>
    //                   false, // removes all previous routes
    //             );
    //           },
    //           borderRadiusAll: AppStyle.buttonRadius.medium,
    //           padding: MySpacing.xy(8, 4),
    //           splashColor: contentTheme.danger.withAlpha(28),
    //           backgroundColor: Colors.transparent,
    //           child: Row(
    //             children: [
    //               Icon(
    //                 LucideIcons.log_out,
    //                 size: 14,
    //                 color: contentTheme.danger,
    //               ),
    //               MySpacing.width(8),
    //               MyText.labelMedium(
    //                 "Log out",
    //                 fontWeight: 600,
    //                 color: contentTheme.danger,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   // Column(
    //   //   crossAxisAlignment: CrossAxisAlignment.start,
    //   //   children: [
    //   //     Padding(
    //   //       padding: MySpacing.xy(8, 8),
    //   //       child: Column(
    //   //         crossAxisAlignment: CrossAxisAlignment.start,
    //   //         children: [
    //   //           MyButton(
    //   //             onPressed: () => {},
    //   //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //   //             borderRadiusAll: AppStyle.buttonRadius.medium,
    //   //             padding: MySpacing.xy(8, 4),
    //   //             splashColor: contentTheme.onBackground.withAlpha(20),
    //   //             backgroundColor: Colors.transparent,
    //   //             child: Row(
    //   //               children: [
    //   //                 Icon(
    //   //                   LucideIcons.user,
    //   //                   size: 14,
    //   //                   color: contentTheme.onBackground,
    //   //                 ),
    //   //                 MySpacing.width(8),
    //   //                 MyText.labelMedium("My Account", fontWeight: 600),
    //   //               ],
    //   //             ),
    //   //           ),
    //   //           MySpacing.height(4),
    //   //           MyButton(
    //   //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //   //             onPressed: () => {},
    //   //             borderRadiusAll: AppStyle.buttonRadius.medium,
    //   //             padding: MySpacing.xy(8, 4),
    //   //             splashColor: contentTheme.onBackground.withAlpha(20),
    //   //             backgroundColor: Colors.transparent,
    //   //             child: Row(
    //   //               children: [
    //   //                 Icon(
    //   //                   LucideIcons.settings,
    //   //                   size: 14,
    //   //                   color: contentTheme.onBackground,
    //   //                 ),
    //   //                 MySpacing.width(8),
    //   //                 InkWell(
    //   //                   onTap: () {
    //   //                     toastMessage(message: "working");
    //   //                   },
    //   //                   child: MyText.labelMedium("Settings", fontWeight: 600),
    //   //                 ),
    //   //               ],
    //   //             ),
    //   //           ),
    //   //         ],
    //   //       ),
    //   //     ),
    //   //     Divider(height: 1, thickness: 1),
    //   //
    //   //   ],
    //   // ),
    // );
  }

  Future<void> _showProfile(context) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Profile View"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () async {
                toastMessage(message: "Next Update Will Come");
              },
              child: _profileImage(150),
            ),
            const SizedBox(height: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loginController.userModel.fullName ?? "No Name"),
                const SizedBox(height: 4),
                Text(loginController.userModel.employeeId ?? "No Employee Id"),
                const SizedBox(height: 4),
                Text(loginController.userModel.department ?? "No Department"),
                const SizedBox(height: 4),
                Text(loginController.userModel.company ?? "No Company"),
                const SizedBox(height: 4),
              ],
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await loginController.userLogOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPageNew()),
                (Route<dynamic> route) => false, // removes all previous routes
              );
            },
            label: Text("Log Out", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _profileImage(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle),
      child: loginController.userImage != null
          ? Image.memory(
              base64Decode(loginController.userImage!.split(',')[1]),
              width: size, // diameter
              height: size,
              fit: BoxFit.fitHeight,
            )
          : Container(
              width: size,
              height: size,
              color: Colors.grey[200],
              child: Icon(Icons.person, size: 50),
            ),
    );
  }
}

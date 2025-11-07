import 'package:flatten/controllers/auth/login_controller.dart';
import 'package:flatten/controllers/dashboard/dashboard_controller.dart';
import 'package:flatten/helpers/extensions/string.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/theme/theme_customizer.dart';
import 'package:flatten/helpers/services/url_service.dart';
import 'package:flatten/helpers/utils/mixins/ui_mixin.dart';
import 'package:flatten/helpers/utils/my_shadow.dart';
import 'package:flatten/helpers/widgets/my_button.dart';
import 'package:flatten/helpers/widgets/my_card.dart';
import 'package:flatten/helpers/widgets/my_container.dart';
import 'package:flatten/helpers/widgets/my_spacing.dart';
import 'package:flatten/helpers/widgets/my_text.dart';
import 'package:flatten/images.dart';
import 'package:flatten/responsive.dart';
import 'package:flatten/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static void attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static void detachListener(String key) {
    observers.remove(key);
  }

  static void notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;

  const LeftBar({super.key, this.isCondensed = false});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar>
    with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;

  bool isCondensed = false;
  String path = UrlService.getCurrentUrl();
  late LoginController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return GetBuilder<LoginController>(
      init: controller,
      builder: (controller) {
        return MyCard(
          paddingAll: 0,
          shadow: MyShadow(
            position: MyShadowPosition.centerRight,
            elevation: 0.2,
          ),
          child: AnimatedContainer(
            color: leftBarTheme.background,
            width: 70,
            // isCondensed ? 70 : 180,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed('/');
                        },
                        child: Image.asset(
                          Images.logoIcon,
                          height: widget.isCondensed ? 24 : 32,
                        ),
                      ),
                      // if (!widget.isCondensed)
                      //   Flexible(
                      //     fit: FlexFit.loose,
                      //     child: MySpacing.width(16),
                      //   ),
                      // if (!widget.isCondensed)
                      //   Flexible(
                      //     fit: FlexFit.loose,
                      //     child: MyText.labelLarge(
                      //       "MVD",
                      //       style: GoogleFonts.raleway(
                      //         fontSize: 28,
                      //         fontWeight: FontWeight.w800,
                      //         color: contentTheme.primary,
                      //         letterSpacing: 1,
                      //       ),
                      //       maxLines: 1,
                      //     ),
                      //   ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (Responsive.isMobile(context))
                          NavigationItem(
                            iconData: Icons.home,
                            title: "home".tr(),
                            isCondensed: true,
                            route: '/default',
                          ),
                        if (Responsive.isMobile(context))
                          NavigationItem(
                            iconData: Icons.group,
                            title: "Attendance".tr(),
                            isCondensed: isCondensed,
                            route: '/attendance',
                          ),

                        if (Responsive.isMobile(context))
                          NavigationItem(
                            iconData: Icons.route,
                            title: "Trip List".tr(),
                            isCondensed: isCondensed,
                            route: '/trip_list',
                          ),

                        if (Responsive.isDesktop(context))
                          NavigationItem(
                            iconData: Icons.report,
                            title: "Login Report".tr(),
                            isCondensed: isCondensed,
                            route: '/per_day_login_report',
                          ),

                        if (Responsive.isDesktop(context))
                          NavigationItem(
                            iconData: Icons.groups,
                            title: "Monthly Login Report".tr(),
                            isCondensed: isCondensed,
                            route: '/monthly_hr_report',
                          ),

                        //
                        // NavigationItem(
                        //   iconData: LucideIcons.chart_area,
                        //   title: "CRM".tr(),
                        //   isCondensed: isCondensed,
                        //   route: '/crm/dashboard',
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.briefcase,
                        //   title: "Job",
                        //   isCondensed: isCondensed,
                        //   route: '/job/dashboard',
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.settings,
                        //   title: "Project",
                        //   isCondensed: isCondensed,
                        //   route: '/project/dashboard',
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.badge_dollar_sign,
                        //   title: "Crypto",
                        //   isCondensed: isCondensed,
                        //   route: '/project/crypto',
                        //   newTag: true,
                        // ),
                        // labelWidget("apps".tr()),
                        // MenuWidget(
                        //   iconData: LucideIcons.store,
                        //   isCondensed: isCondensed,
                        //   title: "ecommerce".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "products".tr(),
                        //       isCondensed: isCondensed,
                        //       route: '/apps/ecommerce/products',
                        //     ),
                        //     MenuItem(
                        //       title: "add_product".tr(),
                        //       isCondensed: isCondensed,
                        //       route: '/apps/ecommerce/add_product',
                        //     ),
                        //     MenuItem(
                        //       title: "product_detail".tr(),
                        //       isCondensed: isCondensed,
                        //       route: '/apps/ecommerce/product-detail',
                        //     ),
                        //     MenuItem(
                        //       title: "reviews".tr(),
                        //       isCondensed: isCondensed,
                        //       route: '/apps/ecommerce/product-reviews',
                        //     ),
                        //     MenuItem(
                        //       title: "customers".tr(),
                        //       isCondensed: isCondensed,
                        //       route: '/apps/ecommerce/customers',
                        //     ),
                        //     MenuItem(
                        //       title: "invoice".tr(),
                        //       isCondensed: isCondensed,
                        //       route: '/apps/ecommerce/invoice',
                        //     ),
                        //   ],
                        // ),
                        // MenuWidget(
                        //   iconData: LucideIcons.briefcase,
                        //   isCondensed: isCondensed,
                        //   title: "jobs".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "discover".tr(),
                        //       route: '/apps/jobs/discover',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "candidates".tr(),
                        //       route: '/apps/jobs/candidates',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "vacancies".tr(),
                        //       route: '/apps/jobs/vacancies',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //   ],
                        // ),
                        // MenuWidget(
                        //   iconData: LucideIcons.folder_plus,
                        //   isCondensed: isCondensed,
                        //   title: "files".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "manager".tr(),
                        //       route: '/apps/files',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "upload".tr(),
                        //       route: '/apps/files/upload',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //   ],
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.badge_dollar_sign,
                        //   title: "nft_dashboard".tr(),
                        //   route: '/nft/dashboard',
                        //   isCondensed: isCondensed,
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.music_4,
                        //   title: "music".tr(),
                        //   route: '/apps/music',
                        //   isCondensed: isCondensed,
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.message_square,
                        //   title: "chats".tr(),
                        //   route: '/chats',
                        //   isCondensed: isCondensed,
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.codesandbox,
                        //   title: "HR Management",
                        //   route: '/apps/hr_management',
                        //   isCondensed: isCondensed,
                        // ),
                        // labelWidget("pages".tr()),
                        // MenuWidget(
                        //   iconData: LucideIcons.shield,
                        //   isCondensed: isCondensed,
                        //   title: "auth".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "login".tr(),
                        //       route: '/auth/login',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "register".tr(),
                        //       route: '/auth/register',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "forgot_password".tr(),
                        //       route: '/auth/forgot_password',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "reset_password".tr(),
                        //       route: '/auth/reset_password',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "locked".tr(),
                        //       route: '/auth/locked',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //   ],
                        // ),
                        // MenuWidget(
                        //   iconData: LucideIcons.layout_grid,
                        //   isCondensed: isCondensed,
                        //   title: "widgets".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "buttons".tr(),
                        //       route: '/ui/buttons',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "cards".tr(),
                        //       route: '/ui/cards',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "tabs".tr(),
                        //       route: '/ui/tabs',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "dialogs".tr(),
                        //       route: '/ui/dialogs',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "carousels".tr(),
                        //       route: '/ui/carousels',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "drag_drop".tr(),
                        //       route: '/ui/drag_drop',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "notifications".tr(),
                        //       route: '/ui/notifications',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //   ],
                        // ),
                        // MenuWidget(
                        //   iconData: LucideIcons.file_plus_2,
                        //   isCondensed: isCondensed,
                        //   title: "form".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "basic".tr(),
                        //       route: '/forms/basic',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "validations".tr(),
                        //       route: '/forms/validation',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "html_editor".tr(),
                        //       route: '/forms/html_editor',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "masks".tr(),
                        //       route: '/forms/masks',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "wizard".tr(),
                        //       route: '/forms/wizard',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //   ],
                        // ),
                        // MenuWidget(
                        //   iconData: LucideIcons.file,
                        //   isCondensed: isCondensed,
                        //   title: "extra".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "profile".tr(),
                        //       route: '/pages/profile',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "success".tr(),
                        //       route: '/pages/success',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "coming_soon".tr(),
                        //       route: '/pages/coming-soon',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "error_404".tr(),
                        //       route: '/pages/error-404',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "error_404_alt".tr(),
                        //       route: '/pages/error-404-alt',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "error_404_cover".tr(),
                        //       route: '/pages/error-404-cover',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "error_500".tr(),
                        //       route: '/pages/error-500',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "offline".tr(),
                        //       route: '/pages/offline',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "maintenance".tr(),
                        //       route: '/pages/maintenance',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //   ],
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.indian_rupee,
                        //   title: "pricing".tr(),
                        //   route: '/pricing',
                        //   isCondensed: isCondensed,
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.circle_help,
                        //   title: "FAQs".tr(),
                        //   route: '/faqs',
                        //   isCondensed: isCondensed,
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.folder,
                        //   title: "starter".tr(),
                        //   route: '/starter',
                        //   isCondensed: isCondensed,
                        // ),
                        // labelWidget("other".tr()),
                        // NavigationItem(
                        //   iconData: LucideIcons.table_2,
                        //   title: "basic_tables".tr(),
                        //   route: '/other/basic_tables',
                        //   isCondensed: isCondensed,
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.chart_area,
                        //   title: "syncfusion_chart".tr(),
                        //   route: '/other/syncfusion_charts',
                        //   isCondensed: isCondensed,
                        // ),
                        // NavigationItem(
                        //   iconData: LucideIcons.chart_area,
                        //   title: "fl_chart".tr(),
                        //   route: '/other/fl_chart',
                        //   isCondensed: isCondensed,
                        // ),
                        // MenuWidget(
                        //   iconData: LucideIcons.map,
                        //   isCondensed: isCondensed,
                        //   title: "maps".tr(),
                        //   children: [
                        //     MenuItem(
                        //       title: "google_map".tr(),
                        //       route: '/maps/google_maps',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //     MenuItem(
                        //       title: "leaflet".tr(),
                        //       route: '/maps/leaflet',
                        //       isCondensed: widget.isCondensed,
                        //     ),
                        //   ],
                        // ),
                        // if (!isCondensed) MySpacing.height(20),
                        // if (!isCondensed)
                        //   Center(
                        //     child: MyButton(
                        //       borderRadiusAll: AppStyle.buttonRadius.small,
                        //       elevation: 0,
                        //       padding: MySpacing.xy(12, 16),
                        //       onPressed: () {
                        //         UrlService.goToPurchase();
                        //       },
                        //       backgroundColor: contentTheme.primary,
                        //       child: MyText.labelMedium(
                        //         'purchase_now'.tr(),
                        //         color: contentTheme.onPrimary,
                        //       ),
                        //     ),
                        //   ),
                        // if (!isCondensed) MySpacing.height(20),
                        // if (!isCondensed)
                        //   InkWell(
                        //     onTap: () {
                        //       UrlService.goToPagger();
                        //     },
                        //     child: Padding(
                        //       padding: MySpacing.x(16),
                        //       child: Container(
                        //         padding: EdgeInsets.symmetric(vertical: 16),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //           // color: contentTheme.primary.withAlpha(40),
                        //           gradient: LinearGradient(
                        //             colors: const [
                        //               Colors.deepPurple,
                        //               Colors.lightBlue,
                        //             ],
                        //             begin: Alignment.topLeft,
                        //             end: Alignment.bottomRight,
                        //           ),
                        //         ),
                        //         child: Column(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceEvenly,
                        //           children: [
                        //             Container(
                        //               padding: EdgeInsets.all(8),
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(8),
                        //                 color: Colors.white.withAlpha(32),
                        //               ),
                        //               child: Icon(
                        //                 LucideIcons.layout_dashboard,
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //             SizedBox(height: 16),
                        //             MyText.bodyLarge(
                        //               "Ready to use page for any Flutter Project",
                        //               color: Colors.white,
                        //               textAlign: TextAlign.center,
                        //             ),
                        //             SizedBox(height: 16),
                        //             Container(
                        //               padding: EdgeInsets.symmetric(
                        //                 vertical: 8,
                        //                 horizontal: 16,
                        //               ),
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(4),
                        //                 color: Colors.white,
                        //               ),
                        //               child: MyText.bodyMedium(
                        //                 "Free Download",
                        //                 color: Colors.black,
                        //                 fontWeight: 600,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // if (isCondensed) MySpacing.height(20),
                        // if (isCondensed)
                        //   InkWell(
                        //     onTap: () {
                        //       UrlService.goToPagger();
                        //     },
                        //     child: Padding(
                        //       padding: MySpacing.x(16),
                        //       child: Container(
                        //         padding: EdgeInsets.all(8),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(4),
                        //           // color: contentTheme.primary.withAlpha(40),
                        //           gradient: LinearGradient(
                        //             colors: const [
                        //               Colors.deepPurple,
                        //               Colors.lightBlue,
                        //             ],
                        //             begin: Alignment.topLeft,
                        //             end: Alignment.bottomRight,
                        //           ),
                        //         ),
                        //         child: Icon(
                        //           LucideIcons.download,
                        //           color: Colors.white,
                        //           size: 20,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // MySpacing.height(20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget labelWidget(String label) {
    return isCondensed
        ? MySpacing.empty()
        : Container(
            padding: MySpacing.xy(24, 8),
            child: MyText.labelSmall(
              label.toUpperCase(),
              color: leftBarTheme.labelColor,
              muted: true,
              maxLines: 1,
              overflow: TextOverflow.clip,
              fontWeight: 700,
            ),
          );
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;

  const MenuWidget({
    super.key,
    required this.iconData,
    required this.title,
    this.isCondensed = false,
    this.active = false,
    this.children = const [],
  });

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget>
    with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _controller.drive(
      Tween<double>(
        begin: 0.0,
        end: 0.5,
      ).chain(CurveTween(curve: Curves.easeIn)),
    );
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      // onChangeExpansion(false);
    }
  }

  void onChangeExpansion(bool value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var route = UrlService.getCurrentUrl();
    isActive = widget.children.any((element) => element.route == route);
    onChangeExpansion(isActive);
    if (hideFn != null) {
      hideFn!();
    }
    // popupShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    // var route = Uri.base.fragment;
    // isActive = widget.children.any((element) => element.route == route);

    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (hide) => hideFn = hide,
        onChange: (_) {
          // popupShowing = _;
        },
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            setState(() {
              isHover = true;
            });
          },
          onExit: (event) {
            setState(() {
              isHover = false;
            });
          },
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover
                ? leftBarTheme.activeItemBackground
                : Colors.transparent,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive)
                    ? leftBarTheme.activeItemColor
                    : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer.bordered(
          paddingAll: 8,
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: EdgeInsets.all(0),
            dense: true,
            horizontalTitleGap: 0.0,
            minLeadingWidth: 0,
            child: ExpansionTile(
              tilePadding: MySpacing.zero,
              initiallyExpanded: isActive,
              maintainState: true,
              onExpansionChanged: (context) {
                LeftbarObserver.notifyAll(widget.title);
                onChangeExpansion(context);
              },
              trailing: RotationTransition(
                turns: _iconTurns,
                child: Icon(
                  LucideIcons.chevron_down,
                  size: 18,
                  color: leftBarTheme.onBackground,
                ),
              ),
              iconColor: leftBarTheme.activeItemColor,
              childrenPadding: MySpacing.x(12),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    widget.iconData,
                    size: 20,
                    color: isHover || isActive
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                  MySpacing.width(18),
                  Expanded(
                    child: MyText.labelLarge(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      color: isHover || isActive
                          ? leftBarTheme.activeItemColor
                          : leftBarTheme.onBackground,
                    ),
                  ),
                ],
              ),
              collapsedBackgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.transparent),
              ),
              backgroundColor: Colors.transparent,
              children: widget.children,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    LeftbarObserver.detachListener(widget.title);
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
  });

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: MySpacing.xy(18, 7),
          child: MyText.bodySmall(
            "${widget.isCondensed ? "" : "- "}  ${widget.title}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontSize: 12.5,
            color: isActive || isHover
                ? leftBarTheme.activeItemColor
                : leftBarTheme.onBackground,
            fontWeight: isActive || isHover ? 600 : 500,
          ),
        ),
      ),
    );
  }
}

class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final bool newTag;
  final String? route;

  const NavigationItem({
    super.key,
    this.iconData,
    required this.title,
    this.isCondensed = false,
    this.route,
    this.newTag = false,
  });

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = UrlService.getCurrentUrl() == widget.route;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(16, 0, 16, 8),
          color: isActive || isHover
              ? leftBarTheme.activeItemBackground
              : Colors.transparent,
          padding: MySpacing.xy(8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(
                    widget.iconData,
                    color: (isHover || isActive)
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                    size: 20,
                  ),
                ),
              if (!widget.isCondensed)
                Flexible(fit: FlexFit.loose, child: MySpacing.width(16)),
              if (!widget.isCondensed)
                Expanded(
                  flex: 7,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover
                        ? leftBarTheme.activeItemColor
                        : leftBarTheme.onBackground,
                  ),
                ),
              if (!widget.isCondensed && widget.newTag)
                MyContainer(
                  padding: MySpacing.xy(5, 3),
                  color: contentTheme.success,
                  borderRadiusAll: 100,
                  child: MyText(
                    "NEW",
                    fontSize: 8,
                    color: contentTheme.onSuccess,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

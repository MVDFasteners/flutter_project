import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/myPages/Home%20Page.dart';
import 'package:flatten/myPages/TripListScreen.dart';
import 'package:flatten/myPages/lead_screen.dart';
import 'package:flatten/myPages/login_new_screen.dart';
import 'package:flatten/myPages/reports/monthly_login_details.dart';
import 'package:flatten/myPages/reports/one_day_login_details.dart';
import 'package:flatten/myPages/reports/pdf_formate.dart';
import 'package:flatten/responsive.dart';
import 'package:flatten/views/apps/chat/chats_page.dart';
import 'package:flatten/views/apps/ecommerce/add_product.dart';
import 'package:flatten/views/apps/ecommerce/customers.dart';
import 'package:flatten/views/apps/ecommerce/products.dart';
import 'package:flatten/views/apps/hr_management/employee_list_screen.dart';
import 'package:flatten/views/apps/jobs/job_vacancee_page.dart';
import 'package:flatten/views/apps/music/music_screen.dart';
import 'package:flatten/views/apps/nft/dashboard_page.dart';
import 'package:flatten/views/auth/forgot_password.dart';
import 'package:flatten/views/auth/locked.dart';
import 'package:flatten/views/auth/login.dart';
import 'package:flatten/views/auth/register.dart';
import 'package:flatten/views/auth/reset_password.dart';
import 'package:flatten/views/dashboard/FirstScreen.dart';
import 'package:flatten/views/dashboard/accounts.dart';
import 'package:flatten/views/dashboard/attendance.dart';
import 'package:flatten/views/dashboard/crm_dashboard_screen.dart';
import 'package:flatten/views/dashboard/crypto_screen.dart';
import 'package:flatten/views/dashboard/dashboard.dart';
import 'package:flatten/views/dashboard/job_dashboard_screen.dart';
import 'package:flatten/views/dashboard/project_screen.dart';
import 'package:flatten/views/dashboard/stock.dart';
import 'package:flatten/views/faqs_page.dart';
import 'package:flatten/views/forms/basic.dart';
import 'package:flatten/views/forms/form_mask.dart';
import 'package:flatten/views/forms/validation.dart';
import 'package:flatten/views/forms/wizard.dart';
import 'package:flatten/views/other/basic_table.dart';
import 'package:flatten/views/other/fl_chart_screen.dart';
import 'package:flatten/views/other/google_map.dart';
import 'package:flatten/views/other/syncfusion_charts.dart';
import 'package:flatten/views/pages/view_login_details.dart';
import 'package:flatten/views/starter.dart';
import 'package:flatten/views/pages/coming_soon_page.dart';
import 'package:flatten/views/pages/error_404_cover.dart';
import 'package:flatten/views/pages/error_offline_page.dart';
import 'package:flatten/views/apps/jobs/job_candidates_page.dart';
import 'package:flatten/views/landing_page.dart';
import 'package:flatten/views/ui/buttons.dart';
import 'package:flatten/views/ui/cards.dart';
import 'package:flatten/views/ui/carousels.dart';
import 'package:flatten/views/ui/dialogs.dart';
import 'package:flatten/views/apps/jobs/discover_page.dart';
import 'package:flatten/views/ui/drag_drop.dart';
import 'package:flatten/views/apps/files/file_manager_page.dart';
import 'package:flatten/views/apps/files/file_upload_page.dart';
import 'package:flatten/views/apps/ecommerce/invoice_page.dart';
import 'package:flatten/views/other/leaflet_page.dart';
import 'package:flatten/views/forms/html_editor_page.dart';
import 'package:flatten/views/pages/maintenance_page.dart';

import 'package:flatten/views/ui/notifications.dart';
import 'package:flatten/views/apps/ecommerce/product_detail.dart';
import 'package:flatten/views/pages/profile_page.dart';
import 'package:flatten/views/apps/ecommerce/reviews_page.dart';
import 'package:flatten/views/pages/success_page.dart';
import 'package:flatten/views/ui/tabs.dart';
import 'package:flutter/material.dart';

import 'package:flatten/views/other/pricing_page.dart';
import 'package:get/get.dart';

import 'package:flatten/views/pages/error_404_basic_page.dart';
import 'package:flatten/views/pages/error_404_alt_page.dart';
import 'package:flatten/views/pages/error_500_page.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    RouteSettings? value = AuthService.sessionId != null
        ? null
        // : RouteSettings(name: '/attendance');
        : RouteSettings(name: '/auth/login');
    return value;
  }
}

List<GetPage> getPageRoute() {
  var routes = [
    // GetPage(
    //   name: '/',
    //   page: () => FirstScreen(),
    //   middlewares: [AuthMiddleware()],
    // ),
    // GetPage(
    //   name: '/dashboard',
    //   page: () => DashboardPage(),
    //   middlewares: [AuthMiddleware()],
    // ),
    GetPage(
      name: '/',
      page: () => CompanyHomePage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/stock',
      page: () => Stock(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/accounts',
      page: () => Accounts(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/attendance',
      page: () => Attendance(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/monthly_hr_report',
      page: () => MonthlyLoginDetails(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/per_day_login_report',
      page: () => PerDayLogin(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/attendance_pdf',
      page: () => AttendancePdfFormat(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/login_details',
      page: () => CheckinDetails(),
      // middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/trip_list',
      page: () => TripListScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/crm/dashboard',
      page: () => CrmDashboardScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/job/dashboard',
      page: () => JobDashboardScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/project/dashboard',
      page: () => ProjectScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/project/crypto',
      page: () => CryptoScreen(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/starter',
      page: () => StarterPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: '/faqs', page: () => FAQsPage()),
    // GetPage(name: '/auth/login', page: () => LoginPage()),
    GetPage(name: '/auth/login', page: () => LoginPageNew()),
    GetPage(
      name: '/auth/forgot_password',
      page: () => ForgotPasswordPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/auth/reset_password',
      page: () => ResetPasswordPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/auth/register',
      page: () => RegisterPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pricing',
      page: () => PricingPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/auth/locked',
      page: () => LockedPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///========== Apps =================///
    GetPage(
      name: '/apps/ecommerce/products',
      page: () => EcommerceProductsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/ecommerce/add_product',
      page: () => AddProductPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/ecommerce/customers',
      page: () => CustomersPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/ecommerce/product-detail',
      page: () => ProductDetailPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/ecommerce/product-reviews',
      page: () => ReviewsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/ecommerce/invoice',
      page: () => InvoicePage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/hr_management',
      page: () => EmployeeListScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/chats',
      page: () => ChatsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/files',
      page: () => FileManagerPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/files/upload',
      page: () => FileUploadPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/apps/jobs/discover',
      page: () => JobDiscoverPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/jobs/candidates',
      page: () => JobCandidatePage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/apps/jobs/vacancies',
      page: () => JobVacanciesPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/nft/dashboard',
      page: () => NFTDashboardPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/apps/music',
      page: () => MusicScreen(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/landing',
      page: () => LandingPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///========== UI =================///
    GetPage(
      name: '/ui/buttons',
      page: () => ButtonsPage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/ui/cards',
      page: () => CardsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/tabs',
      page: () => TabsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/dialogs',
      page: () => DialogsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/carousels',
      page: () => CarouselsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/drag_drop',
      page: () => DragDropPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/ui/notifications',
      page: () => NotificationsPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///========== Forms =================///
    GetPage(
      name: '/forms/basic',
      page: () => BasicFormsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/forms/validation',
      page: () => ValidationFormsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/forms/html_editor',
      page: () => HtmlEditorPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/forms/wizard',
      page: () => WizardPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/forms/masks',
      page: () => FormMaskPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///========== Others =================///
    GetPage(
      name: '/other/basic_tables',
      page: () => BasicTablesPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/other/syncfusion_charts',
      page: () => SyncfusionChartsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/other/fl_chart',
      page: () => FlChartScreen(),
      middlewares: [AuthMiddleware()],
    ),

    ///========== Maps =================///
    GetPage(
      name: '/maps/google_maps',
      page: () => GoogleMapPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/maps/leaflet',
      page: () => LeafletPage(),
      middlewares: [AuthMiddleware()],
    ),

    ///========== Pages =================///
    ///
    GetPage(
      name: '/pages/profile',
      page: () => ProfilePage(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: '/pages/success',
      page: () => SuccessPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pages/coming-soon',
      page: () => ComingSoon(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pages/error-404',
      page: () => Error404BasicPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pages/error-404-alt',
      page: () => Error404AltPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pages/error-404-cover',
      page: () => Error404CoverPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pages/error-500',
      page: () => Error500Page(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pages/offline',
      page: () => ErrorOfflinePage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/pages/maintenance',
      page: () => MaintenancePage(),
      middlewares: [AuthMiddleware()],
    ),
  ];

  return routes
      .map(
        (e) => GetPage(
          name: e.name,
          page: e.page,
          middlewares: e.middlewares,
          transition: Transition.noTransition,
        ),
      )
      .toList();
}

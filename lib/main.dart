import 'package:flatten/helpers/services/auth_service.dart';
import 'package:flatten/helpers/services/localizations/app_localization_delegate.dart';
import 'package:flatten/helpers/services/localizations/language.dart';
import 'package:flatten/helpers/services/navigation_service.dart';
import 'package:flatten/helpers/services/storage/local_storage.dart';
import 'package:flatten/helpers/theme/app_notifier.dart';
import 'package:flatten/helpers/theme/app_style.dart';
import 'package:flatten/helpers/theme/theme_customizer.dart';
import 'package:flatten/responsive.dart';
import 'package:flatten/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:flatten/app_constant.dart';
import 'package:http/http.dart' as http;

//  this is testing commit
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  await LocalStorage.init();
  AppStyle.init();
  await ThemeCustomizer.init();
  // await Translator.clearTrans();
  // Translator.getUnTrans();

  runApp(
    ChangeNotifierProvider<AppNotifier>(
      create: (context) => AppNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _loadSessionId();
  }

  Future<void> _loadSessionId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    AuthService.sessionId = pref.getString("session_id");
    print("Session ID: ${AuthService.sessionId}");
    _isValid = await isSessionValid();
    _isLoading = false;
    setState(() {});
  }

  Future<bool> isSessionValid() async {
    final url = Uri.parse('$baseUrl/api/method/frappe.auth.get_logged_user');
    print("sid=${AuthService.sessionId}");
    final response = await http.get(
      url,
      headers: {"Cookie": "${AuthService.sessionId}"},
    );
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      return false; // Session expired
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return Consumer<AppNotifier>(
      builder: (_, notifier, _) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeCustomizer.instance.theme,
          navigatorKey: NavigationService.navigatorKey,
          initialRoute: Responsive.isDesktop(context)
              ? "/per_day_login_report"
              : _isValid
              ? "/"
              : "/auth/login",
          getPages: getPageRoute(),
          // onGenerateRoute: (_) => generateRoute(context, _),
          builder: (context, child) {
            NavigationService.registerContext(context);
            return Directionality(
              textDirection: AppTheme.textDirection,
              child: child ?? Container(),
            );
          },
          localizationsDelegates: [
            AppLocalizationsDelegate(context),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          supportedLocales: Language.getLocales(),

          // home: ButtonsPage(),
        );
      },
    );
  }
}

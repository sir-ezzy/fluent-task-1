import 'package:fluent/pages/dashboard.dart';
import 'package:fluent/pages/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splashPage = '/splash';
  static const String dashboardPage = '/dashboard';

  static List<GetPage> pages = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: dashboardPage, page: () => DashboardScreen()),
  ];
}

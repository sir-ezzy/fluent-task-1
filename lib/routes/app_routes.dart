import 'package:fluent/pages/course_detail_screen.dart';
import 'package:fluent/pages/courses_screen.dart';
import 'package:fluent/pages/dashboard_screen.dart';
import 'package:fluent/pages/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splashPage = '/splash';
  static const String dashboardPage = '/dashboard';
  static const String coursePage = '/course';
  static const String detailPage = '/detail';

  static List<GetPage> pages = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: dashboardPage, page: () => DashboardScreen()),
    GetPage(name: coursePage, page: () => CoursesScreen()),
    GetPage(
      name: detailPage,
      page: () => CourseDetailScreen(course: Get.arguments),
    ),
  ];
}

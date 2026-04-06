import 'package:fluent/controller/recently_viewed_controller.dart';
import 'package:fluent/widgets/course_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../controller/course_controller.dart';
import '../res/colors.dart';
import '../res/shimmer_loader.dart';
import '../routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final CourseController courseController = Get.put(CourseController());
  final RecentCoursesController recentController = Get.put(
    RecentCoursesController(),
  );

  @override
  void initState() {
    super.initState();
    courseController.fetchCourses();
    recentController.loadRecentCourses();
    ever(recentController.recentCourses, (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Fluent",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            PhosphorIcon(
              PhosphorIcons.dotsThreeOutlineVertical(),
              color: Colors.white,
              size: 22,
            ),
          ],
        ),
      ),
      body: Obx(() {
        final isLoadingRecommended = courseController.isLoading.value;
        final isLoadingRecent = recentController.isLoading.value;
        final hasRecentCourses = recentController.recentCourses.isNotEmpty;

        return RefreshIndicator(
          onRefresh: () async {
            await courseController.fetchCourses();
            await recentController.loadRecentCourses();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasRecentCourses) ...[
                  const SizedBox(height: 15),
                  const Text(
                    "Recently Viewed",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  if (isLoadingRecent)
                    const CourseShimmer()
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: recentController.recentCourses.length,
                      itemBuilder: (context, index) {
                        final course = recentController.recentCourses[index];
                        return CourseWidget(course: course);
                      },
                    ),
                ],

                // const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommended for you",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.coursePage),
                      child: Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                if (isLoadingRecommended)
                  const CourseShimmer()
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courseController.filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = courseController.filteredCourses[index];
                      return CourseWidget(course: course);
                    },
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

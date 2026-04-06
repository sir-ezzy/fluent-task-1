import 'package:fluent/controller/course_controller.dart';
import 'package:fluent/res/colors.dart';
import 'package:fluent/res/shimmer_loader.dart';
import 'package:fluent/widgets/course_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CoursesScreen extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());
  CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.white,
        backgroundColor: AppColor.primary,
        title: const Text(
          "Courses",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const CourseShimmer();
        }

        // Show error if any
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchCourses,
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        // Show courses list
        return SingleChildScrollView(
          child: RefreshIndicator(
            onRefresh: () async => await controller.fetchCourses(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColor.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 16),
                              PhosphorIcon(
                                PhosphorIcons.magnifyingGlass(),
                                color: AppColor.black.withAlpha(150),
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: TextField(
                                  cursorColor: AppColor.primary,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    hintText: 'Search courses',
                                    hintStyle: TextStyle(
                                      color: AppColor.black.withAlpha(100),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    controller.searchCourses(value);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    final results = controller.filteredCourses;

                    if (controller.isLoading.value) {
                      return const CourseShimmer();
                    }

                    if (results.isEmpty &&
                        controller.searchQuery.value.isNotEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 80,
                                color: AppColor.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "No results found",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Try searching with different keywords",
                                style: TextStyle(color: AppColor.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (results.isEmpty) {
                      return const Center(child: Text("No courses available"));
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        final course = results[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: CourseWidget(course: course),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

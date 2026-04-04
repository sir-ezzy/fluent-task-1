import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent/controller/course_controller.dart';
import 'package:fluent/res/colors.dart';
import 'package:fluent/res/shimmer_loader.dart';
import 'package:fluent/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());
  DashboardScreen({super.key});

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
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              PhosphorIcons.dotsThreeOutlineVertical(),
              color: Colors.white,
              size: 20,
            ),
          ],
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
                              Expanded(
                                child: TextField(
                                  cursorColor: AppColor.primary,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    hintText: 'Search For Items',
                                    hintStyle: TextStyle(
                                      color: AppColor.black.withAlpha(100),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.courseList.length,
                    itemBuilder: (context, index) {
                      final course = controller.courseList[index];
                      String truncatedDesc = course.description.length > 140
                          ? "${course.description.substring(0, 140)}..."
                          : course.description;
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.detailPage,
                              arguments: course,
                            );
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 2,
                                      ), // Optional nice border
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: course.instructorAvatar,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor:
                                                  const AlwaysStoppedAnimation<
                                                    Color
                                                  >(Colors.blue),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                              Icons.person,
                                              size: 30,
                                              color: Colors.grey,
                                            ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    course.instructor,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),

                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                width: double.infinity,
                                height: 200,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: course.image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: AppColor.grey.withAlpha(20),
                                      child: Shimmer.fromColors(
                                        baseColor: AppColor.grey.withAlpha(50),
                                        highlightColor: AppColor.grey.withAlpha(
                                          200,
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          height: 200,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          color: AppColor.grey.withAlpha(20),
                                          child: const Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              size: 50,
                                              color: AppColor.grey,
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                              Text(
                                course.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: AppColor.black,
                                  ),
                                  children: [
                                    TextSpan(text: truncatedDesc),
                                    const TextSpan(text: " "),
                                    TextSpan(
                                      text: "Read More",
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(
                                            AppRoutes.detailPage,
                                            arguments: course,
                                          ); 
                                        },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    "${course.rating}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: AppColor.black.withAlpha(150),
                                    ),
                                  ),
                                  RatingStars(
                                    value: course.rating,
                                    starSize: 12,
                                    maxValue: 5,
                                    starColor: Colors.orange,
                                    starOffColor: AppColor.grey.withAlpha(150),
                                    starSpacing: 1,
                                    maxValueVisibility: false,
                                    valueLabelVisibility: false,
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    "(${course.students} downloads)",
                                    style: TextStyle(
                                      color: AppColor.black.withAlpha(100),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${course.category} • ${course.level} • ${course.duration}",
                                  style: TextStyle(
                                    color: AppColor.black.withAlpha(150),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "₦${course.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              Divider(color: AppColor.grey.withAlpha(100)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

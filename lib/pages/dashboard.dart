import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent/controller/course_controller.dart';
import 'package:fluent/res/colors.dart';
import 'package:fluent/res/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DashboardScreen extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());
  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Row(
          children: [
            const Text(
              "Fluent",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
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
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle course tap, e.g. navigate to details
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
                                margin: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                width: double.infinity,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(course.image),
                                    fit: BoxFit.cover,
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
                              Text(
                                course.description,
                                style: TextStyle(
                                  color: AppColor.black.withAlpha(150),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "${course.category} • ${course.level} • ${course.duration}",
                                style: TextStyle(
                                  color: AppColor.grey.withAlpha(150),
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "\$${course.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColor.primary,
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
// ListTile(
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           course.image,
//                           width: 80,
//                           height: 60,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(
//                         course.title,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       subtitle: Text(
//                         "${course.instructor}\n${course.category}",
//                       ),
//                       trailing: Text(
//                         "\$${course.price}",
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     );
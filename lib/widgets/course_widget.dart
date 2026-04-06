import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent/controller/recently_viewed_controller.dart';
import 'package:fluent/model/course_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../res/colors.dart';
import '../routes/app_routes.dart';

class CourseWidget extends StatelessWidget {
  final Course course;

  const CourseWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    String truncatedDesc = course.description.length > 140
        ? "${course.description.substring(0, 140)}..."
        : course.description;

    return GestureDetector(
      onTap: () async {
        await RecentCoursesController().addToRecent(course);
        Get.toNamed(AppRoutes.detailPage, arguments: course);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructor Row
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: course.instructorAvatar,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(strokeWidth: 2.5),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Text(
                  course.instructor,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: course.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColor.grey.withAlpha(50),
                    highlightColor: AppColor.grey.withAlpha(200),
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColor.grey.withAlpha(20),
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: AppColor.grey,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              course.title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),

            RichText(
              text: TextSpan(
                style: const TextStyle(
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
                      ..onTap = () =>
                          Get.toNamed(AppRoutes.detailPage, arguments: course),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "${course.rating}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
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
                const SizedBox(width: 6),
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
  }
}

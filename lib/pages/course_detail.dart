import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluent/model/course_model.dart';
import 'package:fluent/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColor.white,
        title: const Text(
          "Course Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: course.image,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${course.instructor} • ${course.category} • ${course.level}",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.black.withAlpha(150),
                    ),
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "About this course",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    course.description,
                    style: const TextStyle(fontSize: 15, height: 1.6),
                  ),

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Duration"),
                          Text(
                            course.duration,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Rating"),
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
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Download"),
                          Text(
                            "${course.students}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Get.snackbar(
              backgroundColor: AppColor.primary.withAlpha(150),
              colorText: AppColor.white,
              "Enrolled!",
              "You have successfully enrolled in ${course.title}",
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green,
          ),
          child: Text(
            "Enroll Now - ₦${course.price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

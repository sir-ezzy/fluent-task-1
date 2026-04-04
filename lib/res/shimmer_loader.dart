import 'package:fluent/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseShimmer extends StatelessWidget {
  const CourseShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColor.grey.withAlpha(100),
      highlightColor: AppColor.grey.withAlpha(100),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Instructor Row
                        Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.white,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 18,
                              width: 160,
                              color: AppColor.white,
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Title
                        Container(
                          height: 20,
                          width: double.infinity,
                          color: AppColor.white,
                        ),

                        const SizedBox(height: 10),
                        Container(
                          height: 14,
                          width: double.infinity,
                          color: AppColor.white,
                        ),
                        const SizedBox(height: 6),
                        Container(
                          height: 14,
                          width: 280,
                          color: AppColor.white,
                        ),

                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              height: 14,
                              width: 40,
                              color: AppColor.white,
                            ),
                            const SizedBox(width: 8),
                            Container(
                              height: 14,
                              width: 80,
                              color: AppColor.white,
                            ),
                            const SizedBox(width: 12),
                            Container(
                              height: 14,
                              width: 100,
                              color: AppColor.white,
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Container(
                          height: 16,
                          width: 220,
                          color: AppColor.white,
                        ),

                        const SizedBox(height: 12),

                        Container(
                          height: 24,
                          width: 120,
                          color: AppColor.white,
                        ),

                        const SizedBox(height: 12),

                        Container(
                          height: 1,
                          width: double.infinity,
                          color: AppColor.white,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
